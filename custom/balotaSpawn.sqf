
sleep 60;
	_this = createMarker ["bases_spawn_balota1", [4696.2378, 2571.1697]];
	_this setMarkerShape "ELLIPSE";
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [40, 40];
	_this setMarkerAlpha 0;
    bases_spawn_balota1 = _this;
sleep 1;
	["bases_spawn_balota1",6,1,False] call DZAI_spawn;

	_this = createMarker ["bases_spawn_balota2", [4784.4551, 2517.7869]];
	_this setMarkerShape "ELLIPSE";
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [40, 40];
	_this setMarkerAlpha 0;
    bases_spawn_balota2 = _this;
sleep 1;
	["bases_spawn_balota2",6,1,False] call DZAI_spawn;

	_this = createMarker ["bases_spawn_balota3", [4747.1172, 2561.6042]];
	_this setMarkerShape "ELLIPSE";
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [80, 80];
	_this setMarkerAlpha 0;
    bases_spawn_balota3 = _this;
sleep 1;
	["bases_spawn_balota3",8,0,False] call DZAI_spawn;

	_this = createMarker ["bases_spawn_balota4", [4858.6045, 2256.2139]];
	_this setMarkerShape "ELLIPSE";
	_this setMarkerType "Flag";
	_this setMarkerBrush "Solid";
	_this setMarkerSize [20, 20];
	_this setMarkerAlpha 0;
    bases_spawn_balota4 = _this;
sleep 1;
	["bases_spawn_balota4",4,0,False] call DZAI_spawn;

	_cratebb = createVehicle ["USVehicleBox", [4812.8901, 2559.4473, 0.056986809],[], 0, "CAN_COLLIDE"];
	[_cratebb] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesL.sqf";
	_cratebb setVariable ["permaLoot",true];

	_cratebb2 = createVehicle ["USVehicleBox", [4792.6621, 2598.8276, 0.056986809],[], 0, "CAN_COLLIDE"];
	[_cratebb2] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesAL.sqf";
	_cratebb2 setVariable ["permaLoot",true];

	_cratebb3 = createVehicle ["USVehicleBox", [4812.0166, 2587.8662, 0.056986809],[], 0, "CAN_COLLIDE"];
	[_cratebb3] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesC.sqf";
	_cratebb3 setVariable ["permaLoot",true];