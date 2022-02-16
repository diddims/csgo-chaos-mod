void RegisterCommands(){
	RegAdminCmd("chaos_refreshconfig", 	Command_RefreshConfig, 	ADMFLAG_GENERIC);
	RegAdminCmd("chaos_debug", 			Command_ChaosDebug, 	ADMFLAG_GENERIC);
	RegAdminCmd("chaos_help", 			Command_ChaosHelp, 		ADMFLAG_GENERIC);

	RegAdminCmd("sm_chaos", 			Command_NewChaosEffect,	ADMFLAG_GENERIC);
	RegAdminCmd("sm_startchaos", 		Command_StartChaos, 	ADMFLAG_GENERIC);
	RegAdminCmd("sm_startchaos", 		Command_StartChaos, 	ADMFLAG_GENERIC);
}

//: multple effects still spawn if you do "!chaos aut", (funky, autoplant et, juggernaut)
/**
	^ No longer runs multiple effects, but another todo will be to add all effects that match the criteria to an array
	then show a menu of the array is more than 1, so make a global variable like g_SearchingChaos to find it but not run it.
	it'll only need to be edited within NotDecidingChaos();
 */

Handle Possible_Chaos_Effects = INVALID_HANDLE;
bool g_bFindingPotentialEffects = false;
public Action Command_NewChaosEffect(int client, int args){
	if(args > 1){
		ReplyToCommand(client, "Usage: sm_chaos <Effect Name (optional)>");
		return Plugin_Handled;
	}
	char effectName[64];
	GetCmdArg(1, effectName, sizeof(effectName));

	ClearArray(Possible_Chaos_Effects);
	
	g_bDisableRetryEffect = true;
	if(g_bCanSpawnEffect){
		if(args == 1){
			if(strlen(effectName) >=3){
					g_sSelectedChaosEffect = effectName;
					g_bDecidingChaos = true;
					g_bClearChaos = false;
					g_bFindingPotentialEffects = true;
					Chaos();
					g_bFindingPotentialEffects = false;
					if(GetArraySize(Possible_Chaos_Effects) <= 0){
						ReplyToCommand(client, "[Chaos] No effects found.");
						return Plugin_Handled;
					}else if(GetArraySize(Possible_Chaos_Effects) == 1){
						Chaos();
					}else{
						//todo show menu of array
						ReplyToCommand(client, "[Chaos] Multiple effects found under the term '%s'", effectName);
						ShowMenu(client);
					}
				
			}else{
				ReplyToCommand(client, "[Chaos] Please provide atleast 3 characters."); //todo, filter around random characters (NOT UNDERSCORES)
				return Plugin_Handled;
			}
		}else{
			ChooseEffect(null, true);
		}
	}else{
		ReplyToCommand(client, "[Chaos] You can't spawn new effects right now, please wait until the round starts.");
		return Plugin_Handled;
	}

	CreateTimer(1.0, Timer_ReEnableRetries);
	g_sSelectedChaosEffect = "";
	return Plugin_Handled;
}

void ShowMenu(int client){
	Menu menu = new Menu(Effect_Selection);
	menu.SetTitle("Select Chaos Effect");
	char title[64];
	for(int i = 0; i < GetArraySize(Possible_Chaos_Effects); i++){
		GetArrayString(Possible_Chaos_Effects, i, title, sizeof(title));
		menu.AddItem(title, title);
	}
	menu.ExitButton = true;
	menu.Display(client, 20);
}

public int Effect_Selection(Menu menu, MenuAction action, int param1, int param2)
{
    /* If an option was selected, tell the client about the item. */
    if (action == MenuAction_Select){
		char info[64];
		bool found = menu.GetItem(param2, info, sizeof(info));
		PrintToConsole(param1, "You selected item: %d (found? %d info: %s)", param2, found, info);
		if(found){
			g_sSelectedChaosEffect = info;
			g_bDecidingChaos = true;
			g_bClearChaos = false;
			Chaos();
		}
    }else if (action == MenuAction_Cancel){
        // PrintToServer("Client %d's menu was cancelled.  Reason: %d", param1, param2);
    }else if (action == MenuAction_End){
        delete menu;
    }
}






public Action Timer_ReEnableRetries(Handle timer){
	g_bDisableRetryEffect = false;
}

public Action Command_StopChaos(int client, int args){
	g_bChaos_Enabled = false;
	StopTimer(g_NewEffect_Timer);
	g_bClearChaos = true;
	g_bDecidingChaos = false;
	Chaos(true);
	AnnounceChaos("Chaos is Disabled!", -2.0, true);
	return Plugin_Handled;
}

public Action Command_StartChaos(int client, int args){
	if(g_NewEffect_Timer == INVALID_HANDLE){
		g_bClearChaos = true;
		g_bDecidingChaos = false;
		Chaos();
		CreateTimer(0.1, ChooseEffect, _, TIMER_FLAG_NO_MAPCHANGE);
		AnnounceChaos("Chaos is Enabled!", -2.0);
	}else{
		PrintToChat(client, "Chaos is already running!");
	}
	g_bChaos_Enabled = true;
	// StopTimer(g_NewEffect_Timer);
	return Plugin_Handled;
}

bool g_bChaos_Debug = false;
public Action Command_ChaosDebug(int client, int args){
	if(!g_bChaos_Debug){
		cvar("mp_freezetime", "2");
		cvar("mp_round_restart_delay", "2");
	}else{
		cvar("mp_freezetime", "15");
		cvar("mp_round_restart_delay", "7");
	}
	g_bChaos_Debug = !g_bChaos_Debug;
	return Plugin_Handled;
}

public Action Command_RefreshConfig(int client, int args){
	ParseChaosEffects();
	ParseMapCoordinates();

	return Plugin_Handled;
}


public Action Command_ChaosHelp(int client, int args){
	PrintToConsole(client, "todo...");
	return Plugin_Handled;
}
