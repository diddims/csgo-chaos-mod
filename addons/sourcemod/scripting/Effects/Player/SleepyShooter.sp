int SleepShooter_LastShot[MAXPLAYERS + 1]; 
bool g_SleepyShooter = false;

public void Chaos_SleepyShooter(effect_data effect){
	effect.title = "Shoot To Stay Awake";
	effect.duration = 30;

	effect.AddAlias("Sleepy");
	effect.AddAlias("Shooter");
	effect.AddAlias("Blind");
	effect.AddAlias("Awake");

	effect.IncompatibleWith("Chaos_Blind");
}

public void Chaos_SleepyShooter_INIT(){
	HookEvent("weapon_fire", Chaos_SleepyShooter_Event_OnWeaponFire);
}

public void Chaos_SleepyShooter_Event_OnWeaponFire(Event event, const char[] name, bool dontBroadcast){
	if(!g_SleepyShooter) return;
	int client = GetClientOfUserId(event.GetInt("userid"));
	PerformBlind(client, 0);
	SleepShooter_LastShot[client] = 0;
}

public void Chaos_SleepyShooter_START(){
	g_SleepyShooter = true;
	CreateTimer(1.0, Timer_CheckBlindStatus, _, TIMER_REPEAT | TIMER_FLAG_NO_MAPCHANGE);
}

public Action Timer_CheckBlindStatus(Handle timer){
	if(g_SleepyShooter){
		LoopAlivePlayers(i){
			SleepShooter_LastShot[i]++;
			if(SleepShooter_LastShot[i] >= 2){
				PerformBlind(i, 255, 500);
			}else{
				PerformBlind(i, 0);
			}
		}
	}else{
		if(!g_SleepyShooter) return Plugin_Stop;
	}

	return Plugin_Continue;
}

public void Chaos_SleepyShooter_RESET(bool HasTimerEnded){
	g_SleepyShooter = false;
	LoopAlivePlayers(i){
		PerformBlind(i, 0);
	}
}