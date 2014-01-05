//Hillbilly mission  Created by TheSzerdi Edited by Falcyn [QF]

private ["_coords","_iArray","_nearby","_index","_num","_itemType","_itemChance","_weights","_wait","_dummymarker"];
[] execVM "\z\addons\dayz_server\Missions\SMGoMinor.sqf";
WaitUntil {MissionGoMinor == 1};
publicVariable "MissionGoMinor";

_coords =  [getMarkerPos "center",0,7000,10,0,20,0] call BIS_fnc_findSafePos;

//Mission start
[nil,nil,rTitleText,"Bandits have moved into the area!", "PLAIN",6] call RE;
[nil,nil,rGlobalRadio,"Bandits have moved into the area!"] call RE;
[nil,nil,rHINT,"Bandits have moved into the area!"] call RE;

MCoords = _coords;
publicVariable "MCoords";
[] execVM "debug\addmarkers75.sqf";

baserunover = createVehicle ["land_housev_1i4",[(_coords select 0) +2, (_coords select 1)+5,-0.3],[], 0, "CAN_COLLIDE"];
baserunover2 = createVehicle ["land_kbud",[(_coords select 0) - 10, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];
baserunover3 = createVehicle ["land_kbud",[(_coords select 0) - 7, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];

	_this = createMarker ["DZAI_marker_Minor", _coords];
	_this setMarkerShape "ELLIPSE";
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [100, 100];
	_this setMarkerAlpha 0;
    DZAI_marker_Minor = _this;
	diag_log("Mission-DEBUG - MISSION AI MARKER DONE");
sleep 1;
	["DZAI_marker_Minor",15,2,False] call DZAI_spawn;
	diag_log("Mission-DEBUG - SPAWNED MISSION DZAI AI");

if (isDedicated) then {

	_num = round(random 5) + 3;
	_itemType =		[["SCAR_H_LNG_Sniper","weapon"], ["SCAR_H_LNG_Sniper_SD","weapon"], ["FN_FAL", "weapon"], ["bizon_silenced", "weapon"], ["M14_EP1", "weapon"], ["BAF_AS50_scoped", "weapon"], ["MakarovSD", "weapon"], ["Mk_48_DZ", "weapon"], ["M249_DZ", "weapon"], ["DMR", "weapon"], ["", "military"], ["", "medical"], ["MedBox0", "object"], ["NVGoggles", "weapon"], ["AmmoBoxSmall_556", "object"], ["AmmoBoxSmall_762", "object"], ["Skin_Sniper1_DZ", "magazine"]];
	_itemChance =	[0.08, 									0.08,										0.02,					 0.05,							 0.05, 					0.01, 				0.03, 						0.02, 					0.03, 				0.05, 				0.1, 				0.1, 			0.2, 						0.07, 					0.01, 							0.08, 							 0.05];
	
	waituntil {!isnil "fnc_buildWeightedArray"};
	
	_weights = [];
	_weights = 		[_itemType,_itemChance] call fnc_buildWeightedArray;
	//diag_log ("DW_DEBUG: _weights: " + str(_weights));	
	for "_x" from 1 to _num do {
		//create loot
		_index = _weights call BIS_fnc_selectRandom;
		sleep 1;
		if (count _itemType > _index) then {
			//diag_log ("DW_DEBUG: " + str(count (_itemType)) + " select " + str(_index));
			_iArray = _itemType select _index;
			_iArray set [2,_coords];
			_iArray set [3,5];
			_iArray call spawn_loot;
			_nearby = _coords nearObjects ["WeaponHolder",20];
			{
				_x setVariable ["permaLoot",true];
			} forEach _nearBy;
		};
	};
};

waitUntil{{isPlayer _x && _x distance baserunover < 10  } count playableunits > 0}; 

//Mission completed
[nil,nil,rTitleText,"Survivors killed all Bandits! Loot their corpses!", "PLAIN",6] call RE;
[nil,nil,rGlobalRadio,"Survivors killed all Bandits! Loot their corpses!"] call RE;
[nil,nil,rHINT,"Survivors killed all Bandits! Loot their corpses!"] call RE;

deleteMarker "DZAI_marker_Minor";

[] execVM "debug\remmarkers75.sqf";
MissionGoMinor = 0;
publicVariable "MissionGoMinor";
MCoords = 0;
publicVariable "MCoords";

SM1 = 1;
[0] execVM "\z\addons\dayz_server\missions\minor\SMfinder.sqf";
