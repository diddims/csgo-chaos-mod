#pragma semicolon 1

ArrayList LittleChooks;
public void Chaos_LittleChooks(EffectData effect){
	effect.Title = "Lil' Chooks";
	effect.AddAlias("Chicken");
	effect.Duration = 60;
	effect.AddFlag("chicken");
	
	LittleChooks = new ArrayList();
}

public void Chaos_LittleChooks_START(){
	for(int i = 0; i < GetArraySize(g_MapCoordinates); i++){
		int chance = GetRandomInt(0,100);
		if(chance <= 25){ //too many chickens is a no no
			int ent = CreateEntityByName("chicken");
			if(ent != -1){
				float vec[3];
				GetArrayArray(g_MapCoordinates, i, vec);
				if(IsCoopStrike() && DistanceToClosestPlayer(vec) > MAX_COOP_SPAWNDIST) continue;
				TeleportEntity(ent, vec, NULL_VECTOR, NULL_VECTOR);
				DispatchSpawn(ent);
				float randomSize = GetRandomFloat(0.4, 0.9);
				SetEntPropFloat(ent, Prop_Data, "m_flModelScale", randomSize);
				DispatchKeyValue(ent, "targetname", "LittleChooks");
				LittleChooks.Push(EntIndexToEntRef(ent));
			}
		}
	
	}
}

public void Chaos_LittleChooks_RESET(int ResetType){
	RemoveEntitiesInArray(LittleChooks);
}

public bool Chaos_LittleChooks_Conditions(bool EffectRunRandomly){
	if(!ValidMapPoints()) return false;
	if(!CanSpawnChickens() && EffectRunRandomly) return false;
	return true;
}