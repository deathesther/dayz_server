/*
	Chernarus Classname Configuration
	
	Last updated: 11:13 AM 9/14/2013
	
*/

switch (DZAI_modName) do {
	case "2017":
	{
		#include "chernarus\dayz_2017.sqf"
	};
	case "epoch":
	{
		#include "epoch\dayz_epoch.sqf"
	};
	case "civilian":
	{
		#include "chernarus\dayz_civilian.sqf"
	};
	case "overwatch":
	{
		#include "chernarus\dayz_overwatch.sqf"
	};
	case default 
	{
		#include "chernarus\default.sqf"
	};
};
