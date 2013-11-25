/*
	Namalsk Classname Configuration
	
	Last updated: 1:14 PM 6/3/2013
	
*/

private ["_modname","_newItems"];
_modname = toLower format ["%1",MAI_modName];

//Setting common between Namalsk and Namalsk 2017
MAI_invmedicals = 1; 	//Number of selections of medical items (Inventory)
MAI_invedibles = 1;	//Number of selections of edible items (Inventory)
MAI_bpmedicals = 1; 	//Number of selections of medical items (Backpack)
MAI_bpedibles = 0;		//Number of selections of edible items (Backpack)

MAI_militaryTypes = MAI_militaryTypes + ["CamoWinterW_DZN", "CamoWinter_DZN", "Sniper1W_DZN"];
if (MAI_tempNVGs) then {MAI_tempNVGs = false};	//Disable temporary NVG chance for DayZ Namalsk.

switch (MAI_modName) do {
	case "epoch":
	{
		#include "epoch\dayz_epoch.sqf"
	};
	case "2017":
	{
		#include "namalsk\namalsk2017.sqf"
	};
	case default 
	{
		#include "namalsk\default.sqf"
	};
};
