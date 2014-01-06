//Weapons Cache by lazyink (Full credit for original code to TheSzerdi & TAW_Tonic)

private ["_coords","_MainMarker","_wait"];
[] execVM "\z\addons\dayz_server\Missions\SMGoMajor.sqf";
WaitUntil {MissionGo == 1};

_coords = [getMarkerPos "center",0,50,5,0,2000,0] call BIS_fnc_findSafePos;

//Mission start
[nil,nil,rTitleText,"Bandits have discovered a weapons cache! Check your map for the location!", "PLAIN",10] call RE;
[nil,nil,rGlobalRadio,"Bandits have discovered a weapons cache! Check your map for the location!"] call RE;
[nil,nil,rHINT,"Bandits have discovered a weapons cache! Check your map for the location!"] call RE;

Ccoords = _coords;
publicVariable "Ccoords";
[] execVM "debug\addmarkers.sqf";

_hummer = createVehicle ["UAZ_Unarmed_UN_EP1",[(_coords select 0) + 10, (_coords select 1) - 20,0],[], 0, "CAN_COLLIDE"];
_hummer1 = createVehicle ["UAZ_Unarmed_UN_EP1",[(_coords select 0) + 20, (_coords select 1) - 10,0],[], 0, "CAN_COLLIDE"];

_hummer setVariable ["Mission",1,true];
_hummer1 setVariable ["Mission",1,true];

_crate = createVehicle ["USVehicleBox",_coords,[], 0, "CAN_COLLIDE"];
[_crate] execVM "\z\addons\dayz_server\missions\misc\fillBoxesS.sqf";
_crate setVariable ["permaLoot",true];

	_this = createMarker ["DZAI_marker_major", _coords];
	_this setMarkerShape "ELLIPSE";
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [150, 150];
	_this setMarkerAlpha 0;
    DZAI_marker_major = _this;
	diag_log("Mission-DEBUG - MISSION AI MARKER DONE");
sleep 1;
	["DZAI_marker_major",12,2,False] call DZAI_spawn;
	diag_log("Mission-DEBUG - SPAWNED MISSION DZAI AI");

waitUntil{{isPlayer _x && _x distance _crate < 10  } count playableunits > 0}; 

//Mission completed
[nil,nil,rTitleText,"The weapons cache is under survivor control!", "PLAIN",6] call RE;
[nil,nil,rGlobalRadio,"The weapons cache is under survivor control!"] call RE;
[nil,nil,rHINT,"The weapons cache is under survivor control!"] call RE;

deleteMarker "DZAI_marker_major";

[] execVM "debug\remmarkers.sqf";
MissionGo = 0;
Ccoords = 0;
publicVariable "Ccoords";

SM1 = 1;
[0] execVM "\z\addons\dayz_server\missions\major\SMfinder.sqf";
