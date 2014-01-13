
sleep 60;
_this = createMarker ["bandit_main_base_E1", [13712.281, 2899.5767, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_E1 = _this;
sleep 1;
	["bandit_main_base_E1",3,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_E2", [13686.005, 2947.0752, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_E2 = _this;
sleep 1;
	["bandit_main_base_E2",3,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_E3", [13679.041, 2860.1494, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_E3 = _this;
sleep 1;
	["bandit_main_base_E3",3,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_E4", [13785.826, 2926.9546, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_E4 = _this;
sleep 1;
	["bandit_main_base_E4",3,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_E5", [13733.723, 2872.5303, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_E5 = _this;
sleep 1;
	["bandit_main_base_E5",3,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_E6", [13548.166, 2854.4138, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_E6 = _this;
sleep 1;
	["bandit_main_base_E6",3,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_E7", [13325.62, 2748.0781, 2.8175964]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_E7 = _this;
sleep 1;
	["bandit_main_base_E7",3,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_E8", [14116.157, 2784.4346, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_E8 = _this;
sleep 1;
	["bandit_main_base_E8",3,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_E9", [14056.646, 2828.7212, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_E9 = _this;
sleep 1;
	["bandit_main_base_E9",3,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_E10", [13957, 3003.1028, 0]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [50, 50];
_this setMarkerAlpha 0;
bandit_main_base_E10 = _this;
sleep 1;
	["bandit_main_base_E10",3,2,False] call DZAI_spawn;

_this = createMarker ["bandit_main_base_E11", [12449.68, 3341.6812, 0.28902721]];
_this setMarkerShape "ELLIPSE";
_this setMarkerType "Flag";
_this setMarkerBrush "Solid";
_this setMarkerSize [30, 30];
_this setMarkerAlpha 0;
bandit_main_base_E11 = _this;
sleep 1;
	["bandit_main_base_E11",3,2,False] call DZAI_spawn;

	_crateeb = createVehicle ["USVehicleBox", [14106.058, 2779.4338],[], 0, "CAN_COLLIDE"];
	[_crateeb] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesL.sqf";
	_crateeb setVariable ["permaLoot",true];

	_crateeb2 = createVehicle ["USVehicleBox", [14060.682, 2827.8772],[], 0, "CAN_COLLIDE"];
	[_crateeb2] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesC.sqf";
	_crateeb2 setVariable ["permaLoot",true];

	_crateeb3 = createVehicle ["USVehicleBox", [13755.894, 2928.9348],[], 0, "CAN_COLLIDE"];
	[_crateeb3] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesM.sqf";
	_crateeb3 setVariable ["permaLoot",true];

	_crateeb4 = createVehicle ["USVehicleBox", [13775.356, 2888.8081],[], 0, "CAN_COLLIDE"];
	[_crateeb4] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesAM.sqf";
	_crateeb4 setVariable ["permaLoot",true];

	_crateeb5 = createVehicle ["USVehicleBox", [13770.146, 2884.4961, 0],[], 0, "CAN_COLLIDE"];
	[_crateeb5] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesMED.sqf";
	_crateeb5 setVariable ["permaLoot",true];

	_crateeb6 = createVehicle ["USVehicleBox", [13315.475, 2739.9775],[], 0, "CAN_COLLIDE"];
	[_crateeb6] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesL.sqf";
	_crateeb6 setVariable ["permaLoot",true];

	_crateeb7 = createVehicle ["USVehicleBox", [13952.901, 3006.7383],[], 0, "CAN_COLLIDE"];
	[_crateeb7] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesAL.sqf";
	_crateeb7 setVariable ["permaLoot",true];