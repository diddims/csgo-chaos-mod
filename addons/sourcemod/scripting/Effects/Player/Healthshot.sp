#pragma semicolon 1

public void Chaos_Healthshot(EffectData effect){
	effect.Title = "Healthshot";
	effect.HasNoDuration = true;
}

public void Chaos_Healthshot_START(){
	int amount = GetRandomInt(1,3);
	LoopAlivePlayers(i){
			for(int j = 1; j <= amount; j++){
			GivePlayerItem(i, "weapon_healthshot");
		}
	}
}