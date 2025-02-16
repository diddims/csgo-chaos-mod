#pragma semicolon 1

/*
	Thanks!
	https://forums.alliedmods.net/showthread.php?t=254258
*/

bool PunishMisfire = false;
bool PlayerShot[MAXPLAYERS+1];

public void Chaos_PunishMisfire(EffectData effect){
	// effect.Title = "Take Damage For Missed Shots";
	effect.Title = "Don't miss or you lose HP";
	effect.Duration = 30;

	HookEvent("player_hurt", PunishMisfire_Event_PlayerHurt);
	HookEvent("weapon_fire", PunishMisfire_Event_WeaponFire);
}

public void PunishMisfire_Event_WeaponFire(Event event, const char[] name, bool dontBroadcast){
	if(!PunishMisfire) return;
	
	int client = GetClientOfUserId(event.GetInt("userid"));
	if(ValidAndAlive(client)){
		int weapon = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");

		// filter knife and grenades
		if(GetEntProp(weapon, Prop_Send, "m_iPrimaryAmmoType") != -1 && GetEntProp(weapon, Prop_Send, "m_iClip1") != 255){
			PlayerShot[client] = true;
			RequestFrame(CheckFire, client);	
		}
	}
}


public void PunishMisfire_Event_PlayerHurt(Event event, const char[] name, bool dontBroadcast){
	if(!PunishMisfire) return;

	int victim = GetClientOfUserId(event.GetInt("userid"));
	int attacker = GetClientOfUserId(event.GetInt("attacker"));

	// shot wasn't missed, reset state
	if(ValidAndAlive(attacker) && ValidAndAlive(victim)){
		PlayerShot[attacker] = false;
	}
}


public void CheckFire(int client){
	if(!ValidAndAlive(client)) return;
	if(PlayerShot[client]){
		int health = GetEntProp(client, Prop_Send, "m_iHealth");
		health -= 1;
		if(GetRandomInt(0, 1) == 0){
			ClientCommand(client, "playgamesound player/damage3.wav");
		}else{
			ClientCommand(client, "playgamesound player/damage1.wav");
		}
		ClientCommand(client, "playgamesound player/pl_pain5.wav");
		if(health <= 0){
			ForcePlayerSuicide(client);
		}else{
			SetEntityHealth(client, health );
		}
	}
	PlayerShot[client] = false;
}


public void Chaos_PunishMisfire_START(){
	PunishMisfire = true;
}

public void Chaos_PunishMisfire_RESET(){
	PunishMisfire = false;
}