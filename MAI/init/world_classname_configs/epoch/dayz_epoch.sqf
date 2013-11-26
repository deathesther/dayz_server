/*
	DayZ Epoch configuration
	
	Description: Adds DayZ Epoch-specific items to MAI loot tables if Epoch mode is on.
	
	Last updated: 5:10 PM 9/8/2013
	
*/

MAI_metalBars = [["ItemSilverBar",0.20],["ItemSilverBar10oz",0.10],["ItemGoldBar",0.03],["ItemGoldBar10oz",0.015]];
MAI_metalBarNum = 2;		//Maximum number of metal bars to generate

MAI_edibles = [MAI_edibles,["ItemSodaRabbit","ItemSodaMtngreen","ItemSodaR4z0r","ItemSodaClays","ItemSodaSmasht","ItemSodaDrwaste","ItemSodaLemonade","ItemSodaLvg","ItemSodaMzly","FoodBioMeat","FoodCanGriff","FoodCanBadguy","FoodCanBoneboy","FoodCanCorn","FoodCanCurgon","FoodCanDemon","FoodCanFraggleos","FoodCanHerpy","FoodCanOrlok","FoodCanPowell","FoodCanTylers","FoodPumpkin","FoodSunFlowerSeed"]] call MAI_append;
MAI_MiscItemS = [MAI_MiscItemS,["ItemZombieParts"]] call MAI_append;

//Replace hatchet and matchbox items with Epoch versions.
(MAI_tools0 select 3) set [0,"ItemHatchet_DZE"];
(MAI_tools0 select 7) set [0,"ItemMatchbox_DZE"];
(MAI_tools1 select 3) set [0,"ItemHatchet_DZE"];
(MAI_tools1 select 7) set [0,"ItemMatchbox_DZE"];

diag_log "DayZ Epoch loot tables loaded.";
