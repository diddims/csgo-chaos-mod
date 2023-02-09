#pragma semicolon 1

char chickenModel[] = "models/chicken/chicken.mdl";
char playersModels[MAXPLAYERS + 1][PLATFORM_MAX_PATH];

public void Chaos_ChickenPlayers(EffectData effect){
	effect.Title = "Make all players a chicken";
	effect.Duration = 30;
	effect.AddFlag("playermodel");
}

public void Chaos_ChickenPlayers_START(){
	LoopAlivePlayers(i){
		SetChicken(i);
	}
}

public void Chaos_ChickenPlayers_RESET(int ResetType){
	if(ResetType & RESET_EXPIRED){
		LoopAlivePlayers(i){
			DisableChicken(i);
		}
	}
}

public void Chaos_ChickenPlayers_OnPlayerSpawn(int client){
	CreateTimer(0.5, Timer_SetChickenModel, client);
}

public Action Timer_SetChickenModel(Handle timer, int client){
	if(IsValidClient(client) && IsPlayerAlive(client)){
		SetChicken(client);
	}
	return Plugin_Continue;
}

void SetChicken(int client){
	// Get player model to revert it on chicken disable
	char modelName[PLATFORM_MAX_PATH];
	GetEntPropString(client, Prop_Data, "m_ModelName", modelName, sizeof(modelName));
	playersModels[client] = modelName;
	
	//Only for hitbox -> Collision hull still the same
	SetEntityModel(client, chickenModel);
	SetEntityHealth(client, 50);
}

void DisableChicken(int client){
	if(playersModels[client][0] != '\0'){
		if(ValidAndAlive(client)){
			SetEntityModel(client, playersModels[client]);
		}
	}
}