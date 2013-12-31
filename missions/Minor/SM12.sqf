//ural wreck Mission Created by TheSzerdi Edited by Falcyn [QF]

private ["_coords","_itemType","_itemChance","_weights","_index","_iArray","_num","_nearby","_checking","_people","_wait","_dummymarker"];
[] execVM "\z\addons\dayz_server\Missions\SMGoMinor.sqf";
WaitUntil {MissionGoMinor == 1};

_coords = [getMarkerPos "center",0,7000,10,0,2000,0] call BIS_fnc_findSafePos;

//Mission start
[nil,nil,rTitleText,"A truck has crashed! Kill any survivors and secure the loot!", "PLAIN",6] call RE;
[nil,nil,rGlobalRadio,"A truck has crashed! Kill any survivors and secure the loot!"] call RE;
[nil,nil,rHINT,"A truck has crashed! Kill any survivors and secure the loot!"] call RE;

MCoords = _coords;
publicVariable "MCoords";
[] execVM "debug\addmarkers75.sqf";

uralcrash = createVehicle ["uralwreck",_coords,[], 0, "CAN_COLLIDE"];
uralcrash setVariable ["Mission",1,true];

	_this = createMarker ["DZAI_marker_Minor", _coords];
	_this setMarkerShape "ELLIPSE";
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [80, 80];
	_this setMarkerAlpha 0;
    DZAI_marker_Minor = _this;
	diag_log("Mission-DEBUG - MISSION AI MARKER DONE");
sleep 1;
	["DZAI_marker_Minor",4,2,False] call DZAI_spawn;
	diag_log("Mission-DEBUG - SPAWNED MISSION DZAI AI");

if (isDedicated) then {

	_num = round(random 5) + 3;
	_itemType =		[["SCAR_H_LNG_Sniper","magazine"], ["SCAR_H_LNG_Sniper_SD","magazine"], ["FN_FAL", "weapon"], ["bizon_silenced", "weapon"], ["M14_EP1", "weapon"], ["BAF_AS50_scoped", "weapon"], ["MakarovSD", "weapon"], ["Mk_48_DZ", "weapon"], ["M249_DZ", "weapon"], ["DMR", "weapon"], ["", "military"], ["", "medical"], ["MedBox0", "object"], ["NVGoggles", "weapon"], ["AmmoBoxSmall_556", "object"], ["AmmoBoxSmall_762", "object"], ["Skin_Sniper1_DZ", "magazine"]];
	_itemChance =	[0.08, 									0.08,										0.02,					 0.05,							 0.05, 					0.01, 				0.03, 						0.02, 					0.03, 				0.05, 				0.1, 				0.1, 			0.2, 						0.07, 					0.01, 							0.01, 							0.05];
	
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

_checking = 1;
while {_checking == 1} do {
_people =  nearestObjects [_coords,["Man"],30];
if ({isPlayer _x} count _people > 0) then {_checking = 0};
sleep 1;
};

//Mission completed
[nil,nil,rTitleText,"Crashed Truck secured by survivors!", "PLAIN",6] call RE;
[nil,nil,rGlobalRadio,"Crashed Truck secured by survivors!"] call RE;
[nil,nil,rHINT,"Crashed Truck secured by survivors!"] call RE;

deleteMarker "DZAI_marker_Minor";

[] execVM "debug\remmarkers75.sqf";
MissionGoMinor = 0;
MCoords = 0;
publicVariable "MCoords";

SM1 = 5;
[0] execVM "\z\addons\dayz_server\missions\Minor\SMfinder.sqf";
