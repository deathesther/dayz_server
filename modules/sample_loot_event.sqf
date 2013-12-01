private ["_spawnChance", "_spawnMarker", "_spawnRadius", "_markerRadius", "_item", "_debug", "_start_time", "_loot", "_loot_amount", "_loot_box", "_wait_time", "_spawnRoll", "_position", "_event_marker", "_loot_pos", "_debug_marker","_loot_box", "_hint"];

_spawnChance =  1; // Percentage chance of event happening
_markerRadius = 300; // Radius the loot can spawn and used for the marker
_debug = false; // Puts a marker exactly were the loot spawns

_loot_box = "RUBasicWeaponsBox";
_loot_lists = [
[
["M9SD","MakarovSD","UZI_SD_EP1","revolver_gold_EP1","G36_C_SD_eotech","G36K","M4SPR","M4A1_AIM_SD_camo","M16A4_ACG","BAF_L85A2_RIS_Holo"],
["6Rnd_45ACP","6Rnd_45ACP","6Rnd_45ACP","6Rnd_45ACP","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","ItemAntibiotic","ItemAntibiotic","ItemAntibiotic","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBloodbag","ItemBloodbag","ItemBloodbag","ItemEpinephrine","ItemEpinephrine","ItemEpinephrine","ItemHeatPack","ItemHeatPack","ItemHeatPack","ItemMorphine","ItemMorphine","ItemMorphine","ItemPainkiller","ItemPainkiller","ItemPainkiller","ItemGoldBar10oz","ItemGoldBar10oz","ItemBriefcaseEmpty","HandGrenade_East","HandGrenade_West","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","ItemSandbag","ItemSandbag","ItemSandbag","ItemSandbag","ItemSandbag","ItemWire","ItemWire","ItemWire","ItemWire","ItemWire","PartGeneric","PartGeneric","PartGeneric","PartGeneric","PartGeneric","CinderBlocks","CinderBlocks","CinderBlocks","CinderBlocks","CinderBlocks","CinderBlocks","CinderBlocks","CinderBlocks","CinderBlocks","CinderBlocks","Bulk_empty","Bulk_empty","Bulk_empty","Bulk_empty","Bulk_empty","metal_floor_kit","metal_floor_kit","metal_floor_kit","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallLg"]
],
[
["M9SD","MakarovSD","UZI_SD_EP1","revolver_gold_EP1","DMR","M14_EP1","M24","M40A3","SVD"], 
["6Rnd_45ACP","6Rnd_45ACP","6Rnd_45ACP","6Rnd_45ACP","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","ItemAntibiotic","ItemAntibiotic","ItemAntibiotic","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBloodbag","ItemBloodbag","ItemBloodbag","ItemEpinephrine","ItemEpinephrine","ItemEpinephrine","ItemHeatPack","ItemHeatPack","ItemHeatPack","ItemMorphine","ItemMorphine","ItemMorphine","ItemPainkiller","ItemPainkiller","ItemPainkiller","ItemGoldBar10oz","ItemGoldBar10oz","ItemBriefcaseEmpty","HandGrenade_East","HandGrenade_West","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","20Rnd_762x51_DMR","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","5Rnd_762x51_M24","10Rnd_762x54_SVD","10Rnd_762x54_SVD","10Rnd_762x54_SVD","10Rnd_762x54_SVD","10Rnd_762x54_SVD","10Rnd_762x54_SVD","10Rnd_762x54_SVD","10Rnd_762x54_SVD","10Rnd_762x54_SVD","10Rnd_762x54_SVD","ItemTankTrap","ItemTankTrap","ItemTankTrap","ItemTankTrap","ItemTankTrap","PartEngine","PartEngine","PartEngine","PartEngine","PartEngine","PartGlass","PartGlass","PartGlass","PartGlass","PartGlass","MortarBucket","MortarBucket","MortarBucket","MortarBucket","MortarBucket","Bulk_empty","Bulk_empty","Bulk_empty","Bulk_empty","Bulk_empty","ItemFuelBarrel","ItemWoodWallWithDoorLgLocked","ItemWoodWallLg","ItemWoodWallLg"]
],
[
["M9SD","MakarovSD","UZI_SD_EP1","revolver_gold_EP1","M240_DZ","Mk_48_DZ","M249_DZ"], 
["6Rnd_45ACP","6Rnd_45ACP","6Rnd_45ACP","6Rnd_45ACP","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","temWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","ItemAntibiotic","ItemAntibiotic","ItemAntibiotic","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBloodbag","ItemBloodbag","ItemBloodbag","ItemEpinephrine","ItemEpinephrine","ItemEpinephrine","ItemHeatPack","ItemHeatPack","ItemHeatPack","ItemMorphine","ItemMorphine","ItemMorphine","ItemPainkiller","ItemPainkiller","ItemPainkiller","ItemGoldBar10oz","ItemGoldBar10oz","ItemBriefcaseEmpty","HandGrenade_East","HandGrenade_West","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","100Rnd_762x51_M240","200Rnd_556x45_M249","200Rnd_556x45_M249","200Rnd_556x45_M249","200Rnd_556x45_M249","200Rnd_556x45_M249","200Rnd_556x45_M249","200Rnd_556x45_M249","200Rnd_556x45_M249","200Rnd_556x45_M249","200Rnd_556x45_M249","ItemJerrycan","ItemJerrycan","ItemJerrycan","ItemJerrycan","ItemJerrycan","PartPlankPack","PartPlankPack","PartPlankPack","PartPlankPack","PartPlankPack","PartPlankPack","PartPlankPack","PartPlankPack","PartPlankPack","PartPlankPack","PartVRotor","PartVRotor","PartVRotor","PartVRotor","PartVRotor","ItemPole","ItemPole","ItemPole","ItemPole","ItemPole","30m_plot_kit","ItemComboLock","deer_stand_kit","ItemWoodFloorHalf","ItemWoodFloorHalf","ItemWoodFloorHalf","ItemWoodFloorHalf","ItemFuelBarrel","fuel_pump_kit","ItemWoodWallLg","ItemLockbox","ItemWoodWallThird","ItemWoodWallThird","ItemWoodWallThird","ItemWoodWallThird","ItemWoodWallThird","ItemWoodWallThird","ItemWoodWallThird","ItemWoodWallThird","ItemWoodWallThird"]
],
[
["M9SD","MakarovSD","UZI_SD_EP1","revolver_gold_EP1","FN_FAL","FN_FAL_ANPVS4","bizon_silenced","huntingrifle"], 
["6Rnd_45ACP","6Rnd_45ACP","6Rnd_45ACP","6Rnd_45ACP","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","ItemAntibiotic","ItemAntibiotic","ItemAntibiotic","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBloodbag","ItemBloodbag","ItemBloodbag","ItemEpinephrine","ItemEpinephrine","ItemEpinephrine","ItemHeatPack","ItemHeatPack","ItemHeatPack","ItemMorphine","ItemMorphine","ItemMorphine","ItemPainkiller","ItemPainkiller","ItemPainkiller","ItemGoldBar10oz","ItemGoldBar10oz","ItemBriefcaseEmpty","HandGrenade_East","HandGrenade_West","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","20Rnd_762x51_FNFAL","64Rnd_9x19_SD_Bizon","64Rnd_9x19_SD_Bizon","64Rnd_9x19_SD_Bizon","64Rnd_9x19_SD_Bizon","64Rnd_9x19_SD_Bizon","64Rnd_9x19_SD_Bizon","64Rnd_9x19_SD_Bizon","64Rnd_9x19_SD_Bizon","64Rnd_9x19_SD_Bizon","64Rnd_9x19_SD_Bizon","5x_22_LR_17_HMR","5x_22_LR_17_HMR","5x_22_LR_17_HMR","5x_22_LR_17_HMR","5x_22_LR_17_HMR","5x_22_LR_17_HMR","5x_22_LR_17_HMR","5x_22_LR_17_HMR","5x_22_LR_17_HMR","5x_22_LR_17_HMR","PartFueltank","PartFueltank","PartFueltank","PartFueltank","PartFueltank","PartVRotor","PartVRotor","PartVRotor","PartVRotor","PartVRotor","PartPlywoodPack","PartPlywoodPack","PartPlywoodPack","PartPlywoodPack","PartPlywoodPack","PartPlywoodPack","PartPlywoodPack","PartPlywoodPack","PartPlywoodPack","PartPlywoodPack","30m_plot_kit","ItemWoodFloorHalf","ItemWoodFloorHalf","ItemFuelBarrel","ItemWoodWallWithDoorLgLocked","ItemWoodWallWindowLg","ItemWoodWallWindowLg","ItemWoodWallWindowLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallThird","ItemWoodWallThird","ItemWoodWallThird"]
],
[
["M9SD","MakarovSD","UZI_SD_EP1","revolver_gold_EP1","AKS_74_UN_kobra"], 
["6Rnd_45ACP","6Rnd_45ACP","6Rnd_45ACP","6Rnd_45ACP","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","ItemAntibiotic","ItemAntibiotic","ItemAntibiotic","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBloodbag","ItemBloodbag","ItemBloodbag","ItemEpinephrine","ItemEpinephrine","ItemEpinephrine","ItemHeatPack","ItemHeatPack","ItemHeatPack","ItemMorphine","ItemMorphine","ItemMorphine","ItemPainkiller","ItemPainkiller","ItemPainkiller","ItemGoldBar10oz","ItemGoldBar10oz","ItemBriefcaseEmpty","HandGrenade_East","HandGrenade_West","30Rnd_545x39_AKSD","30Rnd_545x39_AKSD","30Rnd_545x39_AKSD","30Rnd_545x39_AKSD","30Rnd_545x39_AKSD","30Rnd_545x39_AKSD","30Rnd_545x39_AKSD","30Rnd_545x39_AKSD","30Rnd_545x39_AKSD","30Rnd_545x39_AKSD","ItemGoldBar10oz","ItemGoldBar10oz","ItemGoldBar10oz","ItemGoldBar10oz","ItemGoldBar10oz","ItemWoodFloor","ItemWoodFloor","ItemWoodFloor","ItemSandbagExLarge","ItemSandbagExLarge","ItemSandbagExLarge","ItemSandbagExLarge","ItemSandbagExLarge","ItemComboLock","ItemComboLock","deer_stand_kit","ItemWoodFloorQuarter","ItemWoodFloorQuarter","ItemWoodFloorQuarter","ItemWoodFloorQuarter","ItemWoodFloorQuarter","ItemWoodFloorQuarter","ItemWoodFloorQuarter","ItemWoodFloorQuarter","ItemWoodFloorQuarter","ItemFuelBarrel","fuel_pump_kit","ItemSandbagLarge","ItemSandbagLarge","ItemSandbagLarge","ItemSandbagLarge","ItemSandbagLarge","ItemWoodWallWithDoorLg","ItemWoodWallWithDoorLg","ItemWoodWallWithDoorLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallLg","light_pole_kit","light_pole_kit","light_pole_kit","ItemLightBulb","ItemLightBulb","ItemLightBulb","ItemLightBulb","ItemLightBulb","ItemLockbox","metal_panel_kit","wooden_shed_kit","outhouse_kit","ItemWoodWallThird","ItemWoodWallThird","ItemWoodWallThird","ItemWoodWallThird","ItemWoodWallThird","ItemWoodWallThird"]
],
[
["M9SD","MakarovSD","UZI_SD_EP1","revolver_gold_EP1"], 
["6Rnd_45ACP","6Rnd_45ACP","6Rnd_45ACP","6Rnd_45ACP","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","8Rnd_9x18_Makarov","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","30Rnd_9x19_UZI_SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","ItemWaterbottle","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","FoodSteakCooked","ItemAntibiotic","ItemAntibiotic","ItemAntibiotic","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemBloodbag","ItemBloodbag","ItemBloodbag","ItemEpinephrine","ItemEpinephrine","ItemEpinephrine","ItemHeatPack","ItemHeatPack","ItemHeatPack","ItemMorphine","ItemMorphine","ItemMorphine","ItemPainkiller","ItemPainkiller","ItemPainkiller","ItemGoldBar10oz","ItemGoldBar10oz","ItemBriefcaseEmpty","HandGrenade_East","HandGrenade_West","ItemVault","storage_shed_kit","ItemWoodWallGarageDoorLocked","ItemWoodWallGarageDoorLocked","ItemWoodWallWithDoorLocked","ItemWoodWallWithDoorLocked","ItemWoodLadder","ItemWoodLadder","ItemWoodLadder","ItemWoodLadder","ItemWoodLadder","ItemWoodStairs","ItemWoodStairs","ItemWoodStairs","ItemWoodStairs","ItemWoodStairs","ItemGoldBar10oz","ItemGoldBar10oz","ItemGoldBar10oz","ItemGoldBar10oz","ItemGoldBar10oz","ItemSilverBar10oz","ItemSilverBar10oz","ItemSilverBar10oz","ItemSilverBar10oz","ItemSilverBar10oz","ItemGenerator","ItemGenerator","ItemGenerator","ItemGenerator","ItemGenerator","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_garage_kit","cinder_garage_kit","cinder_garage_kit","ItemLockbox","ItemWoodFloor","ItemWoodFloor","ItemWoodFloor","ItemWoodFloor","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallThird","ItemWoodWallThird","ItemWoodWallThird","ItemWoodWallDoor","metal_floor_kit","metal_floor_kit","metal_floor_kit"]
]
];
_loot = _loot_lists call BIS_fnc_selectRandom;

_loot_amount = 75;
_wait_time = 1500; 

// Dont mess with theses unless u know what yours doing
_start_time = time;
_spawnRadius = 5000;
_spawnMarker = 'center';

if (isNil "EPOCH_EVENT_RUNNING") then {
	EPOCH_EVENT_RUNNING = false;
};

// Check for another event running
if (EPOCH_EVENT_RUNNING) exitWith {
	diag_log("Event already running");
};

// Random chance of event happening
_spawnRoll = random 1;
if (_spawnRoll > _spawnChance and !_debug) exitWith {};

// Random location
_position = [getMarkerPos _spawnMarker,0,_spawnRadius,10,0,2000,0] call BIS_fnc_findSafePos;

diag_log(format["Spawning loot event at %1", _position]);

_event_marker = createMarker [ format ["loot_event_marker_%1", _start_time], _position];
_event_marker setMarkerShape "ELLIPSE";
_event_marker setMarkerColor "ColorRed";
_event_marker setMarkerAlpha 0.5;
_event_marker setMarkerSize [(_markerRadius + 50), (_markerRadius + 50)];

_loot_pos = [_position,0,(_markerRadius - 100),10,0,2000,0] call BIS_fnc_findSafePos;

if (_debug) then {
	_debug_marker = createMarker [ format ["loot_event_debug_marker_%1", _start_time], _loot_pos];
	_debug_marker setMarkerShape "ICON";
	_debug_marker setMarkerType "mil_dot";
	_debug_marker setMarkerColor "ColorBlue";
	_debug_marker setMarkerAlpha 1;
};

diag_log(format["Creating ammo box at %1", _loot_pos]);

// Create ammo box
_loot_box = createVehicle [_loot_box,_loot_pos,[], 0, "NONE"];
clearMagazineCargoGlobal _loot_box;
clearWeaponCargoGlobal _loot_box;

	_this = createTrigger ["EmptyDetector", _loot_pos];
	_this setTriggerArea [600, 600, 0, false];
	_this setTriggerActivation ["ANY", "PRESENT", true];
	_this setTriggerTimeout [10, 15, 20, true];
	_this setTriggerText "loot_event";
	_this setTriggerStatements ["{isPlayer _x} count thisList > 0;", "0 = [5,5,200,thisTrigger,[],3] call fnc_spawnBandits;", "0 = [thisTrigger] spawn fnc_despawnBandits;"];
	_trigger_251 = _this;

// Cut the grass around the loot position
_clutter = createVehicle ["ClutterCutter_small_2_EP1", _loot_pos, [], 0, "CAN_COLLIDE"];
_clutter setPos _loot_pos;
// cut the grass    end

// Add loot
{
_loot_box addWeaponCargoGlobal [_x,1];
} forEach (_loot select 0);
{
_loot_box addMagazineCargoGlobal [_x,1];
} forEach (_loot select 1);

// Send message to users
[nil,nil,rTitleText,"A PVP Area With A Supply Crate Has Spawned Check Your Map For Location!", "PLAIN",10] call RE;

diag_log(format["Loot event setup, waiting for %1 seconds", _wait_time]);

// Wait
sleep _wait_time;

// Clean up
EPOCH_EVENT_RUNNING = false;
deleteVehicle _trigger_251
deleteVehicle _loot_box;
deleteMarker _event_marker;
if (_debug) then {
	deleteMarker _debug_marker;
};
