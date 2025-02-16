#pragma semicolon 1

/*
	Thanks to @defuj for providing the blur .vmt materials 
	https://steamcommunity.com/id/defuj/
*/

public void Chaos_Blur(EffectData effect){
	effect.Title = "Blur";
	effect.Duration = 30;
	effect.AddFlag("blur");
	effect.AddAlias("Visual");
	effect.AddFlag("r_screenoverlay");
}

bool blurMaterials = true;

public void Chaos_Blur_OnMapStart(){
	PrecacheDecal("ChaosMod/Blur_2.vmt", true);
	PrecacheDecal("nature/water_coast01_normal.vtf", true);
	AddFileToDownloadsTable("materials/nature/water_coast01_normal.vtf");
	AddFileToDownloadsTable("materials/ChaosMod/Blur_2.vmt");
	if(!FileExists("materials/ChaosMod/Blur_2.vmt")) blurMaterials = false;
}

public void Chaos_Blur_START(){
	LoopValidPlayers(i){
		ClientCommand(i, "r_screenoverlay \"/ChaosMod/Blur_2.vmt\"");
	}
}

public void Chaos_Blur_OnPlayerSpawn(int client){
	ClientCommand(client, "r_screenoverlay \"/ChaosMod/Blur_2.vmt\"");
}


public void Chaos_Blur_RESET(bool EndChaos){
	LoopValidPlayers(i){
		ClientCommand(i, "r_screenoverlay \"\"");
	}
}

public bool Chaos_Blur_Conditions(bool EffectRunRandomly){
	return blurMaterials;
}