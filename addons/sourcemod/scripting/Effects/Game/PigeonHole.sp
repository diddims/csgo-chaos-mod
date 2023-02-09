#pragma semicolon 1

public void Chaos_PigeonHole(effect_data effect){
	effect.Title = "Pigeon Hole";
	effect.Duration = 30;
	effect.IncompatibleWith("Chaos_Binoculars");
	effect.AddAlias("Overlay");
	effect.AddAlias("Visual");
}

bool pigeonholeMaterials = true;

public void Chaos_PigeonHole_OnMapStart(){
	char pathname[PLATFORM_MAX_PATH];
	// Precache and download pg_1 - pg_7 both .vtf and .vmt
	for(int i = 1; i <= 7; i++){
		Format(pathname, sizeof(pathname), "ChaosMod/PigeonHole/pg_%i.vmt", i);
		PrecacheDecal(pathname, true);
		Format(pathname, sizeof(pathname), "ChaosMod/PigeonHole/pg_%i.vtf", i);
		PrecacheDecal(pathname, true);
		Format(pathname, sizeof(pathname), "materials/ChaosMod/PigeonHole/pg_%i.vtf", i);
		if(!FileExists(pathname)) pigeonholeMaterials = false;
		AddFileToDownloadsTable(pathname);
		Format(pathname, sizeof(pathname), "materials/ChaosMod/PigeonHole/pg_%i.vmt", i);
		if(!FileExists(pathname)) pigeonholeMaterials = false;
		AddFileToDownloadsTable(pathname);
	}
}

char lastPigeonHole[PLATFORM_MAX_PATH];
int lastPigeonHoleIndex = -1;
Handle PigeonHoleSpawnTimer;
public void Chaos_PigeonHole_START(){
	Timer_SpawnNewPigeonHole(null);
	PigeonHoleSpawnTimer = CreateTimer(5.0, Timer_SpawnNewPigeonHole, _, TIMER_REPEAT);
}

public Action Timer_SpawnNewPigeonHole(Handle timer){
	if(lastPigeonHole[0] != '\0'){
		Remove_Overlay(lastPigeonHole);
	}
	int randomPigeonHole = -1;
	do
	{
		randomPigeonHole = GetRandomInt(1, 7);
	}
	while(randomPigeonHole == lastPigeonHoleIndex);
	lastPigeonHoleIndex = randomPigeonHole;

	Format(lastPigeonHole, sizeof(lastPigeonHole), "/ChaosMod/PigeonHole/pg_%i.vtf", randomPigeonHole);
	Add_Overlay(lastPigeonHole);
	return Plugin_Continue;
}

public void Chaos_PigeonHole_RESET(bool EndChaos){
	StopTimer(PigeonHoleSpawnTimer);
	if(lastPigeonHole[0] != '\0'){
		Remove_Overlay(lastPigeonHole);
	}
}

public bool Chaos_PigeonHole_Conditions(bool EffectRunRandomly){
	if(!CanRunOverlayEffect() && EffectRunRandomly) return false;
	return pigeonholeMaterials;
}