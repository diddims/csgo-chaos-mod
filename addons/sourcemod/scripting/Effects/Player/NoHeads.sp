public void Chaos_NoHeads(effect_data effect){
	effect.Title = "No Heads";
	effect.Duration = 30;
}

char originalNoHeadModels[MAXPLAYERS+1][PLATFORM_MAX_PATH];

char NoHead_T_Path[PLATFORM_MAX_PATH] = "models/player/custom_player/legacy/tm_leet_variantk_nohead.mdl";
char NoHead_CT_Path[PLATFORM_MAX_PATH] = "models/player/custom_player/legacy/ctm_st6_nohead.mdl";

public void Chaos_NoHeads_INIT(){
	PrecacheModel(NoHead_T_Path, true);
	PrecacheModel(NoHead_CT_Path, true);
	AddFileToDownloadsTable(NoHead_CT_Path);
	AddFileToDownloadsTable(NoHead_T_Path);
}
public void Chaos_NoHeads_START(){
	LoopAlivePlayers(i){
		SetNoHeadModel(i);
	}
}

void SetNoHeadModel(int client){
	int team = GetClientTeam(client);
	GetClientModel(client, originalNoHeadModels[client], PLATFORM_MAX_PATH);

	if(team == CS_TEAM_T){
		SetEntityModel(client, NoHead_T_Path);
	}else{
		SetEntityModel(client, NoHead_CT_Path);
	}
}


public Action Chaos_NoHeads_RESET(bool HasTimerEnded){
	if(HasTimerEnded){
		LoopAlivePlayers(i){
			if(originalNoHeadModels[i][0] != '\0'){
				SetEntityModel(i, originalNoHeadModels[i]);
			}
		}
	}
}


public void Chaos_NoHeads_OnPlayerSpawn(int client, bool EffectIsRunning){
	if(EffectIsRunning){
		SetNoHeadModel(client);
	}
}

public bool Chaos_NoHeads_Conditions(){
	if(!FileExists(NoHead_T_Path)) return false;
	if(!FileExists(NoHead_CT_Path)) return false;
	return true;
}