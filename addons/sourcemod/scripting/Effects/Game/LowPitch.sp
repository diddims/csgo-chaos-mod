/*
	Thankyou! https://github.com/Mikusch
*/

bool LowPitch = false;
public void Chaos_LowPitch(EffectData effect){
	effect.Title = "Low Pitch";
	effect.Duration = 30;
	effect.AddFlag("pitch");

	AddNormalSoundHook(Chaos_LowPitch_NormalSoundHook);
	AddAmbientSoundHook(Chaos_LowPitch_AmbientSoundHook);
}

public void Chaos_LowPitch_START(){
	LowPitch = true;
}

public void Chaos_LowPitch_RESET(int ResetType){
	LowPitch = false;
}


Action Chaos_LowPitch_NormalSoundHook(int clients[MAXPLAYERS], int &numClients, char sample[PLATFORM_MAX_PATH], int &entity, int &channel, float &volume, int &level, int &pitch, int &flags, char soundEntry[PLATFORM_MAX_PATH], int &seed){
	if(!LowPitch) return Plugin_Continue;
	pitch = 50;
	return Plugin_Changed;
}


Action Chaos_LowPitch_AmbientSoundHook(char sample[PLATFORM_MAX_PATH], int& entity, float& volume, int& level, int& pitch, float pos[3], int& flags, float& delay){
	if(!LowPitch) return Plugin_Continue;
	pitch = 50;
	return Plugin_Changed;
}