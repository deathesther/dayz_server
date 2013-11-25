/*
	Sahrani Classname Configuration
	
	Last updated: 1:14 PM 6/3/2013
	
*/

private ["_craftingBooks","_newAISkins"];

_newAISkins = ["Rocket_DZ","militarykin_DZ","SniperBandit_DZ","SniperBanditW_DZ","Sniper1W_DZ","militarykinW_DZ"];
_craftingBooks = [["ItemCraftingBook",0.10],["ItemCraftingBook2",0.10],["ItemCraftingBook3",0.05]];

for "_i" from 0 to ((count _newAISkins) - 1) do {MAI_militaryTypes set [(count MAI_militaryTypes),(_newAISkins select _i)];};
MAI_Edibles = MAI_Edibles - ["FoodCanUnlabeled","FoodPistachio","FoodNutmix","FoodMRE"];
MAI_MiscItemS set [(count MAI_MiscItemS),"ItemNails"];
 
for "_i" from 0 to ((count _craftingBooks) - 1) do {MAI_tools0 set [(count MAI_tools0),(_craftingBooks select _i)];};
for "_i" from 0 to ((count _craftingBooks) - 1) do {MAI_tools1 set [(count MAI_tools1),(_craftingBooks select _i)];};

diag_log "Sahrani classnames loaded.";
