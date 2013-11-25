/*
	DayZ Epoch configuration
	
	Description: Adds DayZ Epoch-specific items to MAI loot tables if Epoch mode is on.
	
	Last updated: 5:10 PM 9/8/2013
	
*/

MAI_metalBars = [["ItemSilverBar",0.20],["ItemSilverBar10oz",0.10],["ItemGoldBar",0.03],["ItemGoldBar10oz",0.015]];
MAI_metalBarNum = 2;		//Maximum number of metal bars to generate

MAI_MiscItemS = [MAI_MiscItemS,["ItemZombieParts"]] call MAI_append;

diag_log "DayZ Epoch loot tables loaded.";
