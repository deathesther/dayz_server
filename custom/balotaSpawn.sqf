
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
diefastbase = ["bases_spawn_balota3",8,0,False] call DZAI_spawn;

	_crate = createVehicle ["USVehicleBox", [4812.8901, 2559.4473, 0.056986809],[], 0, "CAN_COLLIDE"];
	[_crate] execVM "\z\addons\dayz_server\custom\Misc\BasefillboxesL";
	_crate setVariable ["permaLoot",true];

	_crate2 = createVehicle ["USVehicleBox", [4792.6621, 2598.8276, 0.056986809],[], 0, "CAN_COLLIDE"];
	[_crate2] execVM "\z\addons\dayz_server\missions\misc\fillBoxesC.sqf";
	_crate2 setVariable ["permaLoot",true];

	_crate3 = createVehicle ["USVehicleBox", [4812.0166, 2587.8662, 0.056986809],[], 0, "CAN_COLLIDE"];
	[_crate3] execVM "\z\addons\dayz_server\missions\misc\fillBoxesM.sqf";
	_crate3 setVariable ["permaLoot",true];