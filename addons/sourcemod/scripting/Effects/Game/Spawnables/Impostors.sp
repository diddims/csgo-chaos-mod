#pragma semicolon 1

ArrayList Impostors;
public void Chaos_Impostors(EffectData effect){
	effect.Title = "Impostors";
	effect.Duration = 60;
	
	effect.AddAlias("Clones");
	Impostors = new ArrayList();
}

public void Chaos_Impostors_START(){
	SpawnImpostors();
}

public void Chaos_Impostors_RESET(int ResetType){
	if(ResetType & RESET_EXPIRED){
		RemoveEntitiesInArray(Impostors);
	}
}

Handle ImpostorModels = INVALID_HANDLE;

void SpawnImpostors(){
	ImpostorModels = CreateArray(PLATFORM_MAX_PATH);
	char modelName[PLATFORM_MAX_PATH];
	LoopAlivePlayers(i){
		GetEntPropString(i, Prop_Data, "m_ModelName", modelName, sizeof(modelName));
		PushArrayString(ImpostorModels, modelName);
	}
	if(GetArraySize(ImpostorModels) == 0) return;

	for(int i = 0; i < GetArraySize(g_MapCoordinates); i++){
		int chance = GetRandomInt(0,100);
		if(chance <= 10){
			float vec[3];
			GetArrayArray(g_MapCoordinates, i, vec);
			
			if(DistanceToClosestEntity(vec, "prop_exploding_barrel") < 50) continue;
			if(IsCoopStrike() && DistanceToClosestPlayer(vec) > MAX_COOP_SPAWNDIST) continue;

			int chicken = CreateEntityByName("chicken");
			int fakePlayer = CreateEntityByName("prop_dynamic_override");

			if(chicken != -1 && fakePlayer != -1){
				DispatchKeyValue(chicken, "targetname", "Impostors");
				char ImpostorModel[PLATFORM_MAX_PATH];
				int randomSkin = GetRandomInt(0, GetArraySize(ImpostorModels) - 1);
				GetArrayString(ImpostorModels, randomSkin, ImpostorModel, sizeof(ImpostorModel));

				DispatchKeyValue(fakePlayer, "targetname", "fake_player");
				DispatchKeyValue(fakePlayer, "disableshadows", "1");
				DispatchKeyValue(fakePlayer, "model", ImpostorModel);
				
				TeleportEntity(chicken, vec, NULL_VECTOR, NULL_VECTOR);
				DispatchSpawn(chicken);
				Impostors.Push(EntIndexToEntRef(chicken));
				/*
					Thankyou backwards!
					https://discord.com/channels/335290997317697536/335290997317697536/840636933478678538
				*/

				float fChickenRot[3];
				GetEntPropVector(chicken, Prop_Data, "m_angAbsRotation", fChickenRot);

				float fForward[3], fSide[3], fUp[3];
				GetAngleVectors(fChickenRot, fForward, fSide, fUp);

				float fChickenPos[3];
				GetEntPropVector(chicken, Prop_Send, "m_vecOrigin", fChickenPos);

				float fChickenOffset[3];
				for(int g = 0;g<3;g++){
					fChickenOffset[g] = fChickenPos[g] + (fForward[g] * 5.0) + (fUp[g] * 10.0) - 10.0;
				}
				TeleportEntity(fakePlayer, fChickenOffset, fChickenRot, NULL_VECTOR);
				SetVariantString("!activator");     
				AcceptEntityInput(fakePlayer, "SetParent", chicken);

				//Note: Entities must be parented before being sent this input. Use at least a 0.1 second delay between SetParent and SetParentAttachmentMaintainOffset inputs, to ensure they run in the right order.

				AcceptEntityInput(fakePlayer, "SetParentAttachmentMaintainOffset", fakePlayer, fakePlayer, 0);    
				
				ActivateEntity(fakePlayer);
				DispatchSpawn(fakePlayer);

				int knife = CreateEntityByName("weapon_knife");
				SetVariantString("!activator");
				AcceptEntityInput(knife, "SetParent", fakePlayer);
				SetVariantString("weapon_hand_R");
				AcceptEntityInput(knife, "SetParentAttachment", knife, knife, 0);
				DispatchSpawn(knife);

				/*
					https://yougame.biz/threads/204191
					https://forums.alliedmods.net/showthread.php?t=288278&page=3

					Some animations will just glide, but it appears the following line is required:
					SetEntPropFloat(i, Prop_Send, "m_flPoseParameter", 0.0, 0);	
						> More info: https://pastebin.com/YMDDrN9n
					Couldn't get it to work so now is a todo for another time :(
				 */

				SetVariantString("move_knife_r");
				// SetVariantString("rifle_aim_walk");
				// SetVariantString("knife_aim_run");
				AcceptEntityInput(fakePlayer, "SetAnimation", 1, 1, 0);
				AcceptEntityInput(fakePlayer, "Enable");

				SetEntityRenderMode(chicken, RENDER_NONE);

				//causes those annoying messages when your chicken dies if i set the leader
				// SetEntPropEnt(chicken, Prop_Send, "m_leader", GetRandomAlivePlayer());

			}
		}
	}
	delete ImpostorModels;
}

public bool Chaos_Impostors_Conditions(bool EffectRunRandomly){
	if(!ValidMapPoints()) return false;
	return true;
}