#pragma semicolon 1

Handle 	g_SimonSays_Timer = INVALID_HANDLE;

bool 	Simon_Active = false;
bool 	SimonSays = false; // whether to say simon says or not

char 	SimonActionText[64];
int 	SimonSaysTime = -1;
bool SimonSaysPlayersToDamage[MAXPLAYERS+1];


enum SimonAction {
	HOLD_LEFT,
	HOLD_RIGHT,
	HOLD_FORWARD,
	HOLD_BACKWARD,
	HOLD_CROUCH,
	SIMONSAYS_COUNT
};

SimonAction currentAction;

public void Chaos_SimonSays(EffectData effect){
	effect.Title = "Simon Says";
	effect.HasNoDuration = true;
	effect.IncompatibleWith("Chaos_Jumping");
	effect.IncompatibleWith("Chaos_KeyStuckA");
	effect.IncompatibleWith("Chaos_KeyStuckS");
	effect.IncompatibleWith("Chaos_KeyStuckD");
	effect.IncompatibleWith("Chaos_KeyStuckW");
	effect.IncompatibleWith("Chaos_BreakTime");
	effect.IncompatibleWith("Chaos_DisableStrafe");
	effect.IncompatibleWith("Chaos_DisableForwardBack");
}

public void Chaos_SimonSays_START(){
	float duration = 10.0;
	GenerateSimonOrder(duration);
	StartMessageTimer();
	
	LoopAllClients(i){
		SimonSaysPlayersToDamage[i] = false;
	}
	
	Simon_Active = true;
}

public void Chaos_SimonSays_RESET(int ResetType){
	Simon_Active = false;
	KillMessageTimer();
}


void GenerateSimonOrder(float duration){
	int rand = GetRandomInt(0, view_as<int>(SIMONSAYS_COUNT) - 1);
	currentAction = view_as<SimonAction>(rand);
	SimonSays = true;
	
	if(GetRandomInt(0, 100) <= 25){
		SimonSays = false;
	}

	if(currentAction == HOLD_LEFT) 		Format(SimonActionText, sizeof(SimonActionText), "Hold A Key.%s(Move Left)", SimonSays ? "\n" : " ");
	if(currentAction == HOLD_RIGHT) 	Format(SimonActionText, sizeof(SimonActionText), "Hold D Key.%s(Move Right)", SimonSays ? "\n" : " ");
	if(currentAction == HOLD_FORWARD) 	Format(SimonActionText, sizeof(SimonActionText), "Hold W Key.%s(Move Forward)", SimonSays ? "\n" : " ");
	if(currentAction == HOLD_BACKWARD) 	Format(SimonActionText, sizeof(SimonActionText), "Hold S Key.%s(Move Backwards)", SimonSays ? "\n" : " ");
	if(currentAction == HOLD_CROUCH) 	SimonActionText = "Hold Crouch";

	if(SimonSays){
		Format(SimonActionText, sizeof(SimonActionText), "Simon Says %s", SimonActionText);
	}

	SimonSaysTime = RoundToFloor(duration) + 5;
}

public void Chaos_SimonSays_OnPlayerRunCmd(int client, int &buttons, int &iImpulse, float fVel[3], float fAngles[3], int &iWeapon, int &iSubType, int &iCmdNum, int &iTickCount, int &iSeed, int mouse[2]){
	if(SimonSaysTime >= 10) return;
	if(!Simon_Active) return;
	
	bool ShouldHurtPlayer = SimonSays;
	if(currentAction == HOLD_LEFT && buttons & IN_MOVELEFT) 	ShouldHurtPlayer = !SimonSays;
	if(currentAction == HOLD_RIGHT && buttons & IN_MOVERIGHT) 	ShouldHurtPlayer = !SimonSays;
	if(currentAction == HOLD_FORWARD && buttons & IN_FORWARD) 	ShouldHurtPlayer = !SimonSays;
	if(currentAction == HOLD_BACKWARD && buttons & IN_BACK) 	ShouldHurtPlayer = !SimonSays;
	if(currentAction == HOLD_CROUCH && buttons & IN_DUCK) 		ShouldHurtPlayer = !SimonSays;

	if(ShouldHurtPlayer){
		SimonSaysPlayersToDamage[client] = true;
	}else{
		SimonSaysPlayersToDamage[client] = false;
	}

}

void DamagePlayer(int client, int amount = 5){
	int original = GetClientHealth(client);
	SetEntityHealth(client, original - amount);
	if(GetRandomInt(0, 1) == 0){
		ClientCommand(client, "playgamesound player/damage3.wav");
	}else{
		ClientCommand(client, "playgamesound player/damage1.wav");
	}
	ClientCommand(client, "playgamesound player/pl_pain5.wav");
	if((original - amount) <= 0){
		ForcePlayerSuicide(client);
	}
}

void StartMessageTimer(){
	g_SimonSays_Timer = CreateTimer(1.0, Timer_ShowAction, _, TIMER_REPEAT);
}

Action Timer_ShowAction(Handle timer){
	SimonSaysTime--;
	char message[128];
	if(SimonSaysTime > 11){
		int countdown = SimonSaysTime - 10;
		FormatEx(message, sizeof(message), "Simon says starting in \n%i...", countdown);
		DisplayCenterTextToAll(message);
	}else{
		if(SimonSaysTime >= 0){
			
			LoopAlivePlayers(i){
				if(SimonSaysPlayersToDamage[i]){
					DamagePlayer(i);
					SimonSaysPlayersToDamage[i] = false;
				}
			}
			
			Format(message, sizeof(message), "%s\n(%i)", SimonActionText, SimonSaysTime);
			DisplayCenterTextToAll(message);
			//TODO: forgot to remove this from v0.4.1
			// PrintHintTextToAll(message);
		}else{
			Simon_Active = false;
			KillMessageTimer();
		}
	}
	return Plugin_Continue;
}

void KillMessageTimer(){
	if(g_SimonSays_Timer != INVALID_HANDLE){
		KillTimer(g_SimonSays_Timer);
		g_SimonSays_Timer = INVALID_HANDLE;
	}
}