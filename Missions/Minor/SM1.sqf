//Bandit Hunting Party by lazyink (Full credit to TheSzerdi & TAW_Tonic for the code)

private ["_coords","_wait","_MainMarker75"];
[] execVM "\z\addons\dayz_server\Missions\SMGoMinor.sqf";
WaitUntil {MissionGoMinor == 1};

_coords = [getMarkerPos "center",0,5500,2,0,2000,0] call BIS_fnc_findSafePos;

//Mission start
[nil,nil,rTitleText,"A bandit hunting party has been spotted! Check your map for the location!", "PLAIN",10] call RE;
[nil,nil,rGlobalRadio,"A bandit hunting party has been spotted! Check your map for the location!"] call RE;
[nil,nil,rHINT,"A bandit hunting party has been spotted! Check your map for the location!"] call RE;


MCoords = _coords;
publicVariable "MCoords";
[] execVM "debug\addmarkers75.sqf";

_hummer = createVehicle ["UAZ_Unarmed_UN_EP1",[(_coords select 0) + 10, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];
_hummer setVariable ["Mission",1,true];

	_this = createMarker ["DZAI_marker_Minor", _coords];
	_this setMarkerShape "ELLIPSE";
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [100, 100];
	_this setMarkerAlpha 0;
    DZAI_marker_Minor = _this;
	diag_log("Mission-DEBUG - MISSION AI MARKER DONE");
sleep 1;
	["DZAI_marker_Minor",4,2,False] call DZAI_spawn;
	diag_log("Mission-DEBUG - SPAWNED MISSION DZAI AI");

waitUntil{{isPlayer _x && _x distance _hummer < 10  } count playableunits > 0};

//Mission completed
[nil,nil,rTitleText,"The hunting party has been wiped out!", "PLAIN",6] call RE;
[nil,nil,rGlobalRadio,"The hunting party has been wiped out!"] call RE;
[nil,nil,rHINT,"The hunting party has been wiped out!"] call RE;

deleteMarker "DZAI_marker_Minor";

[] execVM "debug\remmarkers75.sqf";
MissionGoMinor = 0;
MCoords = 0;
publicVariable "MCoords";

SM1 = 1;
[0] execVM "\z\addons\dayz_server\missions\minor\SMfinder.sqf";
