#pragma semicolon 1

public void Chaos_BlackBars(effect_data effect){
	effect.Title = "Black Bars";
	effect.Duration = 30;
}

bool blackBarsMaterials = true;

public void Chaos_BlackBars_OnMapStart(){
	PrecacheDecal("ChaosMod/BlackBars.vmt", true);
	PrecacheDecal("ChaosMod/BlackBars.vtf", true);
	AddFileToDownloadsTable("materials/ChaosMod/BlackBars.vtf");
	AddFileToDownloadsTable("materials/ChaosMod/BlackBars.vmt");

	if(!FileExists("materials/ChaosMod/BlackBars.vtf")) blackBarsMaterials =  false;
	if(!FileExists("materials/ChaosMod/BlackBars.vmt")) blackBarsMaterials = false;
}

public void Chaos_BlackBars_START(){
	Add_Overlay("/ChaosMod/BlackBars.vtf");
}


public void Chaos_BlackBars_RESET(bool EndChaos){
	Remove_Overlay("/ChaosMod/BlackBars.vtf");
}

public bool Chaos_BlackBars_Conditions(bool EffectRunRandomly){
	if(!CanRunOverlayEffect() && EffectRunRandomly) return false;
	return blackBarsMaterials;
}
