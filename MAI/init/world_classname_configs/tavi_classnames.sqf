/*
	Taviana Classname Configuration
	
	Last updated: 11:22 AM 9/14/2013
	
*/

switch (MAI_modName) do {
	case "epoch":
	{
		#include "epoch\dayz_epoch.sqf"
	};
	case default 
	{
		#include "taviana\default.sqf"
	};
};
