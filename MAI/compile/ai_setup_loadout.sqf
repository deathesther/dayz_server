private ["_unit","_weapongrade","_weapons","_weapon","_magazine","_backpacks","_gadgetsArray","_backpack","_gadget"];
_unit = _this select 0;
_weapongrade = _this select 1;

if (_unit getVariable ["loadoutDone",false]) exitWith {diag_log "MAI Error :: Unit already has loadout!";};
if ((typeName _weapongrade) == "SCALAR") then {
	if ((count (weapons _unit)) > 0) then {
		removeAllWeapons _unit;
		_unit removeWeapon "ItemMap";
		_unit removeWeapon "ItemGPS";
		_unit removeWeapon "ItemCompass";
		_unit removeWeapon "ItemRadio";  
		_unit removeWeapon "ItemWatch";
	};
	
	switch (_weapongrade) do {
		case 0: {
			if ((random 1) < 0.25) then {
				_weapons = [MAI_Pistols0,MAI_Pistols1] call BIS_fnc_selectRandom2;
			} else {
				_weapons = MAI_rifles0;
			};
			_backpacks = MAI_Backpacks0;
			_gadgetsArray = MAI_gadgets0;
		};
		case 1: {
			_weapons = MAI_rifles1;
			_backpacks = MAI_Backpacks1;
			_gadgetsArray = MAI_gadgets0;
		};
		case 2: {
			_weapons = MAI_rifles2;
			_backpacks = MAI_Backpacks2;
			_gadgetsArray = MAI_gadgets1;
		};
		case 3: {
			_weapons = MAI_rifles3;
			_backpacks = MAI_Backpacks3;
			_gadgetsArray = MAI_gadgets1;
		};
		case 4: {
			_weapons = if (isNil "MAI_Rifles4") then {MAI_Rifles3} else {MAI_Rifles4};
			_backpacks = MAI_Backpacks3;
			_gadgetsArray = MAI_gadgets1;
		};
		case 5: {
			_weapons = if (isNil "MAI_Rifles5") then {MAI_Rifles3} else {MAI_Rifles5};
			_backpacks = MAI_Backpacks3;
			_gadgetsArray = MAI_gadgets1;
		};
		case 6: {
			_weapons = if (isNil "MAI_Rifles6") then {MAI_Rifles3} else {MAI_Rifles6};
			_backpacks = MAI_Backpacks3;
			_gadgetsArray = MAI_gadgets1;
		};
		case 7: {
			_weapons = if (isNil "MAI_Rifles7") then {MAI_Rifles3} else {MAI_Rifles7};
			_backpacks = MAI_Backpacks3;
			_gadgetsArray = MAI_gadgets1;
		};
		case 8: {
			_weapons = if (isNil "MAI_Rifles8") then {MAI_Rifles3} else {MAI_Rifles8};
			_backpacks = MAI_Backpacks3;
			_gadgetsArray = MAI_gadgets1;
		};
		case 9: {
			_weapons = if (isNil "MAI_Rifles9") then {MAI_Rifles3} else {MAI_Rifles9};
			_backpacks = MAI_Backpacks3;
			_gadgetsArray = MAI_gadgets1;
		};
		case default {
			_weapons = [MAI_rifles0,MAI_rifles1,MAI_rifles2,MAI_rifles3] call BIS_fnc_selectRandom2;
			_backpacks = [MAI_Backpacks0,MAI_Backpacks1,MAI_Backpacks2,MAI_Backpacks3] call BIS_fnc_selectRandom2;
			_gadgetsArray = [MAI_gadgets0,MAI_gadgets1] call BIS_fnc_selectRandom2;
		};
	};

	//Select weapon and backpack
	_weapon = _weapons call BIS_fnc_selectRandom2;
	_backpack = _backpacks call BIS_fnc_selectRandom2;
	
	//Add weapon, ammunition, and backpack
	_magazine = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
	_unit addMagazine _magazine;
	_unit addWeapon _weapon;
	_unit selectWeapon _weapon;
	_unit addBackpack _backpack;
	if ((getNumber (configFile >> "CfgWeapons" >> _weapon >> "type")) == 2) then {_unit setVariable ["CanGivePistol",false]};
	if (MAI_debugLevel > 1) then {diag_log format ["MAI Extended Debug: Created weapon %1 and backpack %3 for AI with weapongrade %2. (fn_unitSelectWeapon)",_weapon,_weapongrade,_backpack];};
	
	//diag_log format ["DEBUG :: Counted %1 tools in _gadgetsArray.",(count _gadgetsArray)];
	for "_i" from 0 to ((count _gadgetsArray) - 1) do {
		private["_chance"];
		_chance = ((_gadgetsArray select _i) select 1);
		//diag_log format ["DEBUG :: %1 chance to add gadget.",_chance];
		if ((random 1) < _chance) then {
			_gadget = ((_gadgetsArray select _i) select 0);
			_unit addWeapon _gadget;
			//diag_log format ["DEBUG :: Added gadget %1 as loot to AI inventory.",_gadget];
		};
	};
	
	//If unit has weapongrade 2 or 3 and was not given NVGs, give the unit temporary NVGs which will be removed at death. Set MAI_tempNVGs to true in variables config to enable temporary NVGs.
	if (MAI_tempNVGs) then {
		if (!(_unit hasWeapon "NVGoggles") && (_weapongrade > 0) && (daytime < 6 || daytime > 20)) then {
			_unit addWeapon "NVGoggles";
			_unit setVariable["removeNVG",1,false];
			if (MAI_debugLevel > 1) then {diag_log "MAI Extended Debug: Generated temporary NVGs for AI.";};
		};
	};
} else {
	diag_log format ["MAI Error :: Invalid weapongrade value provided: %1",_weapongrade];
};
_unit setVariable ["loadoutDone",true];