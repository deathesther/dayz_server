/*
	Description: 	Basic tables containing AI equipment classnames and skin models used by AI units. Some settings may be overridden by map-specific configuration files in the world_classname_configs folder.
					To make changes for a specific DayZ mod, edit the appropriate config file in for the map/mod being used.

	MAI will first load default classnames defined by default_classnames.sqf, then load the map/mod-specific file to modify default settings.

	Example: MAI will always first load default_classnames.sqf, then if DayZ Overwatch is detected, MAI will overwrite settings specified by chernarus\dayz_overwatch.sqf.

	Last upated: 2:41 AM 11/9/2013
*/

if !(MAI_dynamicWeaponList) then {
	//If dynamic weapon list is disabled, then use preset tables. This method is faster than dynamic generation, but compatibility issues may arise.
	//If using any DayZ map other than Chernarus, it is *highly* recommended to set MAI_verifyTables = true; to avoid compatibility issues.
	diag_log "[MAI] Loading preset weapon list...";
	MAI_Pistols0 = ["Makarov","Colt1911","revolver_EP1"]; //Weapongrade 0 pistols
	MAI_Pistols1 = ["M9","M9SD","MakarovSD","UZI_EP1","glock17_EP1"]; //Weapongrade 1 pistols
	MAI_Pistols2 = ["M9SD","MakarovSD","UZI_EP1","glock17_EP1"]; //Weapongrade 2 pistols
	MAI_Pistols3 = ["M9SD","MakarovSD","UZI_EP1","glock17_EP1"]; //Weapongrade 3 pistols
	MAI_Rifles0 = ["LeeEnfield","Winchester1866","MR43","huntingrifle","LeeEnfield","Winchester1866","MR43","Makarov","Colt1911","revolver_EP1"]; //Weapongrade 0 rifles
	MAI_Rifles1 = ["M16A2","M16A2GL","AK_74","M4A1_Aim","AKS_74_kobra","AKS_74_U","AK_47_M","M24","M1014","DMR_DZ","M4A1","M14_EP1","Remington870_lamp","MP5A5","MP5SD","M4A3_CCO_EP1"]; //Weapongrade 1 rifles
	MAI_Rifles2 = ["M16A2","M16A2GL","M249_DZ","AK_74","M4A1_Aim","AKS_74_kobra","AKS_74_U","AK_47_M","M24","SVD_CAMO","M1014","DMR_DZ","M4A1","M14_EP1","Remington870_lamp","M240_DZ","M4A1_AIM_SD_camo","M16A4_ACG","M4A1_HWS_GL_camo","Mk_48_DZ","M4A3_CCO_EP1","Sa58V_RCO_EP1","Sa58V_CCO_EP1","M40A3","Sa58P_EP1","Sa58V_EP1"]; //Weapongrade 2 rifles
	MAI_Rifles3 = ["FN_FAL","FN_FAL_ANPVS4","Mk_48_DZ","M249_DZ","BAF_L85A2_RIS_Holo","G36C","G36C_camo","G36A_camo","G36K_camo","AK_47_M","AKS_74_U","M14_EP1","bizon_silenced","DMR_DZ","RPK_74"]; //Weapongrade 3 rifles
	MAI_weaponsInitialized = true;
};

	MAI_militaryTypes = ["FR_Miles","FR_Cooper","FR_Ohara","FR_Rodriguez","FR_Sykes","FR_AC","FR_AR","FR_Assault_GL","FR_Assault_R","FR_Commander","FR_Corpsman","FR_GL","FR_Light","FR_Marksman","FR_R","FR_Sapper","FR_TL","USMC_Soldier","USMC_Soldier2","USMC_SoldierM","USMC_SoldierS","USMC_SoldierS_Engineer","USMC_SoldierS_Sniper","USMC_SoldierS_SniperH","USMC_SoldierS_Spotter","USMC_Soldier_AA","USMC_Soldier_AR","USMC_Soldier_AT","USMC_Soldier_Crew","USMC_Soldier_GL","USMC_Soldier_HAT","USMC_Soldier_LAT","USMC_Soldier_Light","USMC_Soldier_MG","USMC_Soldier_Medic","USMC_Soldier_Officer","USMC_Soldier_Pilot","USMC_Soldier_SL","USMC_Soldier_TL","CDF_Soldier","CDF_Commander","CDF_Soldier_AR","CDF_Soldier_Engineer","CDF_Soldier_GL","CDF_Soldier_Light","CDF_Soldier_MG","CDF_Soldier_Marksman","CDF_Soldier_Medic","CDF_Soldier_Militia","CDF_Soldier_Officer","CDF_Soldier_RPG","CDF_Soldier_Sniper","CDF_Soldier_Spotter","CDF_Soldier_Strela","CDF_Soldier_TL"]; //List of skins for AI units to use

MAI_Backpacks0 = ["DZ_Patrol_Pack_EP1","DZ_Czech_Vest_Puch","DZ_Assault_Pack_EP1"];
MAI_Backpacks1 = ["DZ_Patrol_Pack_EP1","DZ_Czech_Vest_Puch","DZ_Assault_Pack_EP1","DZ_British_ACU","DZ_TK_Assault_Pack_EP1","DZ_CivilBackpack_EP1","DZ_ALICE_Pack_EP1"];
MAI_Backpacks2 = ["DZ_CivilBackpack_EP1","DZ_British_ACU","DZ_Backpack_EP1"];
MAI_Backpacks3 = ["DZ_CivilBackpack_EP1","DZ_Backpack_EP1"];

MAI_Edibles = ["ItemSodaCoke", "ItemSodaPepsi", "ItemWaterbottle", "FoodCanSardines", "FoodCanBakedBeans", "FoodCanFrankBeans", "FoodCanPasta", "ItemWaterbottleUnfilled","ItemWaterbottleBoiled","FoodmuttonCooked","FoodchickenCooked","FoodBaconCooked","FoodRabbitCooked","FoodbaconRaw","FoodchickenRaw","FoodmuttonRaw","foodrabbitRaw","FoodCanUnlabeled","FoodPistachio","FoodNutmix","FoodMRE"]; //List of all edible items
MAI_Medicals1 = ["ItemBandage", "ItemPainkiller"]; //List of common medical items
MAI_Medicals2 = ["ItemPainkiller", "ItemMorphine", "ItemBandage", "ItemBloodbag", "ItemAntibiotic","ItemEpinephrine"]; //List of all medical items

MAI_MiscItemS = ["ItemHeatpack", "HandRoadFlare", "HandChemBlue", "HandChemRed", "HandChemGreen","SmokeShell","SmokeShellGreen","SmokeShellGreen","FlareGreen_M203","FlareWhite_M203","1Rnd_Smoke_M203","FlareGreen_M203","FlareWhite_M203","1Rnd_Smoke_M203"]; //List of random miscellaneous items (1 inventory space)
MAI_MiscItemL = ["ItemJerrycan", "PartWheel", "PartEngine", "PartFueltank", "PartGlass", "PartVRotor","PartWoodPile"]; //List of random miscellaneous items (>1 inventory space)

//Tool items are added to AI inventory upon death
//NOTE: To remove an item, set its chance to 0, don't delete it from the array. To add an item, add it to the end of the array.
MAI_tools0 = [["ItemFlashlight",0.65],["ItemWatch",0.65],["ItemKnife",0.50],["ItemHatchet",0.40],["ItemCompass",0.35],["ItemMap",0.25],["ItemToolbox",0.10],["ItemMatchbox",0.10],["ItemFlashlightRed",0.05],["ItemGPS",0.005],["ItemRadio",0.005]];
MAI_tools1 = [["ItemFlashlight",0.90],["ItemWatch",0.90],["ItemKnife",0.75],["ItemHatchet",0.70],["ItemCompass",0.60],["ItemMap",0.50],["ItemToolbox",0.20],["ItemMatchbox",0.20],["ItemFlashlightRed",0.10],["ItemGPS",0.125],["ItemRadio",0.05]];

//Gadget items are added to AI inventory at unit creation
MAI_gadgets0 = [["binocular",0.40],["NVGoggles",0.00]];
MAI_gadgets1 = [["binocular",0.60],["NVGoggles",0.05]];

diag_log "[MAI] Base classname tables loaded.";
