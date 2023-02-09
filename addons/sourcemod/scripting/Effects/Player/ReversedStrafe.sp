#pragma semicolon 1

bool ReversedStrafe = false;
public void Chaos_ReversedStrafe(EffectData effect){
	effect.Title = "Reversed Strafe";
	effect.Duration = 30;
}

public void Chaos_ReversedStrafe_START(){
	ReversedStrafe = true;
}

public void Chaos_ReversedStrafe_RESET(int ResetType){
	ReversedStrafe = false;
}

public void Chaos_ReversedStrafe_OnPlayerRunCmd(int client, int &buttons, int &iImpulse, float fVel[3], float fAngles[3], int &iWeapon, int &iSubType, int &iCmdNum, int &iTickCount, int &iSeed, int mouse[2]){
	if(ReversedStrafe){
		fVel[1] = -fVel[1];
	}
}