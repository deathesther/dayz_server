//Medical Outpost by lazyink (Full credit for code to TheSzerdi & TAW_Tonic)
//edited for [EMS] by Fuchs

private ["_coords","_wait","_MainMarker75"];
[] execVM "\z\addons\dayz_server\Missions\SMGoMinor.sqf";
WaitUntil {MissionGoMinor == 1};

_coords =  [getMarkerPos "center",0,5500,10,0,20,0] call BIS_fnc_findSafePos;

//Mission start
[nil,nil,rTitleText,"A group of bandits have taken over a Medical Outpost! Check your map for the location!", "PLAIN",10] call RE;
[nil,nil,rGlobalRadio,"A group of bandits have taken over a Medical Outpost! Check your map for the location!"] call RE;
[nil,nil,rHINT,"A group of bandits have taken over a Medical Outpost! Check your map for the location!"] call RE;


MCoords = _coords;
publicVariable "MCoords";
[] execVM "debug\addmarkers75.sqf";

_baserunover = createVehicle ["US_WarfareBFieldhHospital_Base_EP1",[(_coords select 0) +2, (_coords select 1)+5,-0.3],[], 0, "CAN_COLLIDE"];
_baserunover1 = createVehicle ["MASH_EP1",[(_coords select 0) - 24, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];
_baserunover2 = createVehicle ["MASH_EP1",[(_coords select 0) - 17, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];
_baserunover3 = createVehicle ["MASH_EP1",[(_coords select 0) - 10, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];
_baserunover4 = createVehicle ["UAZ_Unarmed_UN_EP1",[(_coords select 0) + 10, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];
_baserunover5 = createVehicle ["HMMWV",[(_coords select 0) + 15, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];

_baserunover setVariable ["Mission",1,true];
_baserunover1 setVariable ["Mission",1,true];
_baserunover2 setVariable ["Mission",1,true];
_baserunover3 setVariable ["Mission",1,true];
_baserunover4 setVariable ["Mission",1,true];
_baserunover5 setVariable ["Mission",1,true];

_crate = createVehicle ["USVehicleBox",[(_coords select 0) - 3, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate] execVM "\z\addons\dayz_server\missions\misc\fillBoxesM.sqf";
_crate setVariable ["permaLoot",true];

_crate2 = createVehicle ["USLaunchersBox",[(_coords select 0) - 8, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate2] execVM "\z\addons\dayz_server\missions\misc\fillBoxesS.sqf";
_crate2 setVariable ["permaLoot",true];

	_this = createMarker ["DZAI_marker_Minor", _coords];
	_this setMarkerShape "ELLIPSE";
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [150, 150];
	_this setMarkerAlpha 0;
    DZAI_marker_Minor = _this;
	diag_log("Mission-DEBUG - MISSION AI MARKER DONE");
sleep 1;
	["DZAI_marker_Minor",12,2,False] call DZAI_spawn;
	diag_log("Mission-DEBUG - SPAWNED MISSION DZAI AI");

waitUntil{{isPlayer _x && _x distance _crate < 10  } count playableunits > 0}; 

//Mission completed
[nil,nil,rTitleText,"The Medical Outpost is under survivor control!", "PLAIN",6] call RE;
[nil,nil,rGlobalRadio,"The Medical Outpost is under survivor control!"] call RE;
[nil,nil,rHINT,"The Medical Outpost is under survivor control!"] call RE;

deleteMarker "DZAI_marker_Minor";

[] execVM "debug\remmarkers75.sqf";
MissionGoMinor = 0;
MCoords = 0;
publicVariable "MCoords";



SM1 = 1;
[0] execVM "\z\addons\dayz_server\missions\minor\SMfinder.sqf";
