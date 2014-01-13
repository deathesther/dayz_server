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
DZAI_debugLevel = 0;
DZAI_debugMarkers = 1;
DZAI_monitorRate = 300;
DZAI_verifyTables = true;
DZAI_objPatch = true;
DZAI_cleanupDelay = 1800;
DZAI_modName = "epoch";
DZAI_weaponNoise = false;
DZAI_passiveAggro = true;
DZAI_refreshRate = 15;
DZAI_zDetectRange = 200;
DZAI_zombieEnemy = true;
DZAI_freeForAll = false;
DZAI_findKiller = true;
DZAI_tempNVGs = false;
DZAI_humanityGain = 100;
DZAI_radioMsgs = true;
DZAI_useRadioAddon = false;
DZAI_staticAI = false;
DZAI_respawnTimeMin = 1800;
DZAI_respawnTimeMax = 3600;
DZAI_despawnWait = 120;
DZAI_dynAISpawns = false;
DZAI_dynAreaBlacklist = [];
DZAI_dynRemoveDeadWait = 300;
DZAI_dynDespawnWait = 120;
DZAI_maxHeliPatrols = 8;
DZAI_respawnTMinA = 1800;
DZAI_respawnTMaxA = 3600;
DZAI_heliTypes = ["UH1H_DZE","UH1H_TK_EP1","UH1H_TK_GUE_EP1","CH_47F_EP1_DZE"];
DZAI_airWeapons = [
	[
		//Air vehicle classnames (Remember: no comma for last entry! Otherwise, separate each string with commas)
		"Helicopter1_ExampleClassname",
		"Helicopter2_ExampleClassname"
	]
	,
	[
		//Corresponding weapon classnames (Remember: no comma for last entry! Otherwise, separate each string with commas)
		"Helicopter1_ExampleWeapon",
		"Helicopter2_ExampleWeapon"
	]
];
DZAI_maxLandPatrols = 15;
DZAI_respawnTMinL = 1800;
DZAI_respawnTMaxL = 3600;
DZAI_vehTypes = ["UAZ_Unarmed_TK_EP1"];
DZAI_dynamicWeaponList = true;
DZAI_banAIWeapons = [];
DZAI_launcherTypes = ["RPG7V"];
DZAI_launcherLevels = [3];
DZAI_invmedicals = 3;
DZAI_invedibles = 2;
DZAI_bpmedicals = 3;
DZAI_bpedibles = 2;
DZAI_numMiscItemS = 3;
DZAI_numMiscItemL = 3;
DZAI_chanceMedicals = 0.70;
DZAI_chanceEdibles = 0.70;
DZAI_chanceMiscItemS = 0.60;
DZAI_chanceMiscItemL = 0.10;
DZAI_gradeChancesNewbie = [0.90,0.10,0.00,0.00,0.00];
DZAI_gradeChances0 = [0.00,0.90,0.20,0.00,0.00];
DZAI_gradeChances1 = [0.00,0.60,0.40,0.00,0.00];
DZAI_gradeChances2 = [0.00,0.00,0.00,0.90,0.00];
DZAI_gradeChances3 = [0.00,0.00,0.00,0.40,0.20];
DZAI_gradeChancesDyn = [0.00,0.00,0.40,0.30,0.30];
DZAI_gradeChancesHeli = [0.00,0.00,0.00,0.50,0.50];
DZAI_skill0 = [
	["aimingAccuracy",0.125,0.15],
	["aimingShake",0.60,0.70],
	["aimingSpeed",0.60,0.70],
	["endurance",0.55,0.65],
	["spotDistance",0.45,0.60],
	["spotTime",0.45,0.60],
	["courage",0.55,0.75],
	["reloadSpeed",0.60,0.70],
	["commanding",0.55,0.65],
	["general",0.55,0.75]
];
DZAI_skill1 = [
	["aimingAccuracy",0.125,0.15],
	["aimingShake",0.60,0.70],
	["aimingSpeed",0.60,0.70],
	["endurance",0.55,0.65],
	["spotDistance",0.45,0.60],
	["spotTime",0.45,0.60],
	["courage",0.55,0.75],
	["reloadSpeed",0.60,0.70],
	["commanding",0.55,0.65],
	["general",0.55,0.75]
];
DZAI_skill2 = [
	["aimingAccuracy",0.125,0.15],
	["aimingShake",0.60,0.70],
	["aimingSpeed",0.60,0.70],
	["endurance",0.55,0.65],
	["spotDistance",0.45,0.60],
	["spotTime",0.45,0.60],
	["courage",0.55,0.75],
	["reloadSpeed",0.60,0.70],
	["commanding",0.55,0.65],
	["general",0.55,0.75]
];
DZAI_skill3 = [
	["aimingAccuracy",0.125,0.15],
	["aimingShake",0.60,0.70],
	["aimingSpeed",0.60,0.70],
	["endurance",0.55,0.65],
	["spotDistance",0.45,0.60],
	["spotTime",0.45,0.60],
	["courage",0.55,0.75],
	["reloadSpeed",0.60,0.70],
	["commanding",0.55,0.65],
	["general",0.55,0.75]
];
DZAI_skill4 = nil;
DZAI_skill5 = nil;
DZAI_skill6 = nil;
DZAI_skill7 = nil;
DZAI_skill8 = nil;
DZAI_skill9 = nil;
DZAI_heliCrewSkills = [
	["aimingAccuracy",0.125,0.15],
	["aimingShake",0.60,0.70],
	["aimingSpeed",0.60,0.70],
	["endurance",0.55,0.65],
	["spotDistance",0.45,0.60],
	["spotTime",0.45,0.60],
	["courage",0.55,0.75],
	["reloadSpeed",0.60,0.70],
	["commanding",0.55,0.65],
	["general",0.55,0.75]
];