/*
	DZAI User-Specified Settings File
	
	Description: 	Use this file to store your preferred settings. The variables stored in this file will override DZAI's default settings in DZAI\init\dzai_config.sqf.
					
	Instructions:	Copy over the lines from DZAI\init\dzai_config.sqf containing the setting(s) that you wish to keep after each DZAI update.
					Whenever you update to a newer version of DZAI, overwrite the default DZAI_settings_override file with your edited copy.
	
	Reminder: Remember to check if anything has changed in the dzai_config.sqf file after each update to DZAI.
	
	Example: If you always want your server to have helicopters enabled with a maximum of 5 helicopters, and using the UH1H and Mi17, then the contents of this file would look like this:
	
	-------------------------(Begin Example File)-------------------------
	

	//Add your preferred settings below this line.
	
	DZAI_maxHeliPatrols = 5;									//Maximum number of active AI helicopters patrols. (Default: 0).
	DZAI_heliTypes = ["UH1H_DZ","Mi17_DZ"];						//Classnames of helicopter types to use. (Default: "UH1H_DZ").

	-------------------------(End of Example File)-------------------------
*/

//Add your preferred settings below this line.
DZAI_objPatch = true;
DZAI_cleanupDelay = 600;
DZAI_modName = "epoch";
DZAI_passiveAggro = true;
DZAI_humanityGain = 100;
DZAI_useRadioAddon = false;
DZAI_respawnTimeMin = 1600;
DZAI_respawnTimeMax = 1900;
DZAI_dynAISpawns = false;
DZAI_maxHeliPatrols = 10;
DZAI_respawnTMinA = 1600;
DZAI_respawnTMaxA = 1900;
DZAI_heliTypes = ["UH1H_DZ","UH1H_TK_EP1","UH1H_TK_GUE_EP1","CH_47F_EP1_DZ","Mi17_DZ"];
DZAI_maxLandPatrols = 30;
DZAI_respawnTMinL = 1600;
DZAI_respawnTMaxL = 1900;
DZAI_vehTypes = ["UAZ_Unarmed_TK_EP1","UAZ_Unarmed_TK_CIV_EP1","UAZ_Unarmed_UN_EP1","UAZ_CDF","UAZ_INS","UAZ_MG_TK_EP1","UAZ_RU"];
DZAI_launcherTypes = ["RPG7V"];
DZAI_launcherLevels = [3];
DZAI_skill0 = [
	["aimingAccuracy",0.125,0.15],
	["aimingShake",0.60,0.70],
	["aimingSpeed",0.60,0.70],
	["endurance",0.55,0.75],
	["spotDistance",0.45,0.60],
	["spotTime",0.45,0.75],
	["courage",0.55,0.75],
	["reloadSpeed",0.55,0.75],
	["commanding",0.55,0.75],
	["general",0.55,0.75]
];
DZAI_skill1 = [
	["aimingAccuracy",0.125,0.15],
	["aimingShake",0.60,0.70],
	["aimingSpeed",0.60,0.70],
	["endurance",0.55,0.75],
	["spotDistance",0.45,0.60],
	["spotTime",0.45,0.75],
	["courage",0.55,0.75],
	["reloadSpeed",0.55,0.75],
	["commanding",0.55,0.75],
	["general",0.55,0.75]
];
DZAI_skill2 = [
	["aimingAccuracy",0.125,0.15],
	["aimingShake",0.60,0.70],
	["aimingSpeed",0.60,0.70],
	["endurance",0.55,0.75],
	["spotDistance",0.45,0.60],
	["spotTime",0.45,0.75],
	["courage",0.55,0.75],
	["reloadSpeed",0.55,0.75],
	["commanding",0.55,0.75],
	["general",0.55,0.75]
];
DZAI_skill3 = [
	["aimingAccuracy",0.125,0.15],
	["aimingShake",0.60,0.70],
	["aimingSpeed",0.60,0.70],
	["endurance",0.55,0.75],
	["spotDistance",0.45,0.60],
	["spotTime",0.45,0.75],
	["courage",0.55,0.75],
	["reloadSpeed",0.55,0.75],
	["commanding",0.55,0.75],
	["general",0.55,0.75]
];
DZAI_heliCrewSkills = [
	["aimingAccuracy",0.125,0.15],
	["aimingShake",0.60,0.70],
	["aimingSpeed",0.60,0.70],
	["endurance",0.55,0.75],
	["spotDistance",0.45,0.60],
	["spotTime",0.45,0.75],
	["courage",0.55,0.75],
	["reloadSpeed",0.55,0.75],
	["commanding",0.55,0.75],
	["general",0.55,0.75]
];