/*
	DayZ 2017 Classname Configuration
	
	Last updated: 10:45 AM 9/14/2013
	
*/

MAI_invmedicals = 0; 										//Number of selections of medical items (Inventory)
MAI_invedibles = 0;										//Number of selections of edible items (Inventory)
MAI_bpmedicals = 0; 										//Number of selections of medical items (Backpack)
MAI_bpedibles = 1;											//Number of selections of edible items (Backpack)
MAI_militaryTypes = MAI_militaryTypes - ["Bandit1_DZ", "BanditW1_DZ", "Camo1_DZ", "Sniper1_DZ"];
MAI_militaryTypes = [MAI_militaryTypes,["Beard_DZ","Dimitry_DZ","Alexej_DZ","Stanislav_DZ","Czech_Norris"]] call MAI_append;
MAI_Edibles = MAI_Edibles - ["FoodCanPasta","ItemWaterbottleBoiled","FoodmuttonCooked","FoodchickenCooked","FoodBaconCooked","FoodRabbitCooked","FoodbaconRaw","FoodchickenRaw","FoodmuttonRaw","foodrabbitRaw","FoodCanUnlabeled","FoodPistachio","FoodNutmix","FoodMRE"] + ["HumanFleshCooked","RawHumanFlesh","RawInfectedFlesh","InfectedFleshCooked","FoodSteakCooked","FoodSteakRaw","FoodCanDogFood"];
MAI_MiscItemS = MAI_MiscItemS - ["HandGrenade_West","FlareGreen_M203","HandGrenade_West","FlareGreen_M203"];
MAI_gradeChances0 = [0.90,0.10,0.00,0.00];
MAI_gradeChances1 = [0.65,0.30,0.05,0.00];
MAI_gradeChances2 = [0.30,0.45,0.15,0.00];
MAI_gradeChances3 = [0.25,0.55,0.20,0.00];
//Reduce tool probabilities (both tiers)
MAI_gadgets0 set [1,["NVGoggles",0.00]];
MAI_gadgets1 set [1,["NVGoggles",0.00]];
MAI_tools0 set [0,["ItemFlashlight",0.60]];
MAI_tools0 set [2,["ItemKnife",0.65]];
MAI_tools0 set [3,["ItemHatchet",0.60]];
MAI_tools0 set [4,["ItemCompass",0.40]];
MAI_tools0 set [5,["ItemMap",0.30]];
MAI_tools0 set [7,["ItemFlint",0.20]];		//Replace ItemMatchbox with ItemFlint
MAI_tools0 set [8,["ItemFlashlightRed",0.10]];
MAI_tools0 set [9,["ItemGPS",0.000]];		//Reduce probability of functional GPS
MAI_tools1 set [0,["ItemFlashlight",0.60]];
MAI_tools1 set [2,["ItemKnife",0.65]];
MAI_tools1 set [3,["ItemHatchet",0.60]];
MAI_tools1 set [4,["ItemCompass",0.40]];
MAI_tools1 set [5,["ItemMap",0.30]];
MAI_tools1 set [7,["ItemFlint",0.20]];		//Replace ItemMatchbox with ItemFlint
MAI_tools1 set [8,["ItemFlashlightRed",0.10]];
MAI_tools1 set [9,["ItemGPS",0.000]];		//Reduce probability of functional GPS
MAI_Backpacks0 = ["ice_apo_pack3"];
MAI_Backpacks1 = ["ice_apo_pack3","ice_apo_pack1"];
MAI_Backpacks2 = ["ice_apo_pack1","ice_apo_pack4","ice_apo_pack2"];
MAI_Backpacks3 = ["ice_apo_pack4","ice_apo_pack2"];
if (MAI_tempNVGs) then {MAI_tempNVGs = false;};	//Disable temporary NVG chance for DayZ 2017.
diag_log "DayZ 2017 classnames loaded.";
