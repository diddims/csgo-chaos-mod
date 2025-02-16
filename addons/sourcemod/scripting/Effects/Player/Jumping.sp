#pragma semicolon 1

bool ForceJump[MAXPLAYERS+1];
public void Chaos_Jumping(EffectData effect){
	effect.Title = "Jump Jump!";
	effect.Duration = 30;
}

public void Chaos_Jumping_OnPlayerRunCmd(int client, int &buttons, int &impulse, float vel[3], float angles[3], int &weapon, int &iSubType, int &cmdnum, int &tickcount, int &seed, int mouse[2]){
	ForceJump[client] = !ForceJump[client];
	if(ForceJump[client]){
		buttons |= IN_JUMP;
	}else{
		buttons &= ~IN_JUMP;
	}
}

// once upon a time...

// public Action Timer_ForceJump(Handle timer){
// 	if(g_bJumping){
// 		for(int i = 1; i <= MaxClients; i++){
// 			if(ValidAndAlive(i)){
// 				float vec[3];
// 				GetEntPropVector(i, Prop_Data, "m_vecVelocity", vec);
// 				if(vec[2] == 0.0) { //ensure player isnt mid jump or falling down
// 					vec[0] = 0.0;
// 					vec[1] = 0.0;
// 					vec[2] = 300.0;
// 					SetEntPropVector(i, Prop_Data, "m_vecBaseVelocity", vec);
// 				}
// 			}
// 		}
// 	}else{
// 		StopTimer(g_Jumping_Timer_Repeat);
// 	}
// }
