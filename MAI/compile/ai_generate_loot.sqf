private ["_unit","_pistol","_pistols","_weapongrade","_magazine","_currentWeapon","_toolselect","_chance","_tool","_toolsArray"];
_unit = _this select 0;
_weapongrade = _this select 1;

if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: AI killed by player at %1. Generating loot with weapongrade %2 (fn_militaryAIKilled).",mapGridPosition _unit,_weapongrade];};

if (_unit getVariable ["CanGivePistol",true]) then {
	_pistols = switch (_weapongrade) do {
		case 0: {MAI_Pistols0};
		case 1: {MAI_Pistols1};
		case 2: {MAI_Pistols2};
		case 3: {MAI_Pistols3};
		case default {[MAI_Pistols0,MAI_Pistols1,MAI_Pistols2,MAI_Pistols3] call BIS_fnc_selectRandom2};
	};

	_pistol = _pistols call BIS_fnc_selectRandom2;
	_magazine = getArray (configFile >> "CfgWeapons" >> _pistol >> "magazines") select 0;
	_unit addMagazine _magazine;	
	_unit addWeapon _pistol;
	
	if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Generated pistol weapon: %1 for AI.",_pistol];};
	sleep 0.001;
};

//Add consumables, medical items, and miscellaneous items
////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Add one guaranteed Bandage to inventory
_unit addMagazine "ItemBandage";

//Add edible items to inventory
for "_i" from 1 to MAI_invedibles do {
	if ((random 1) < MAI_chanceEdibles) then{
		private["_invedible"];
		_invedible = MAI_Edibles call BIS_fnc_selectRandom2;
		_unit addMagazine _invedible;
		if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Generated Inventory Edible Item: %1 for AI.",_invedible];};
	};
};

//Add edible items to backpack
for "_i" from 1 to MAI_bpedibles do {
	if ((random 1) < MAI_chanceEdibles) then {
		private["_bpedible"];
		_bpedible = MAI_Edibles call BIS_fnc_selectRandom2;
		(unitBackpack _unit) addMagazineCargoGlobal [_bpedible, 1];
		if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Generated Backpack Edible Item: %1 for AI.",_bpedible];};
	};
};

if (_weapongrade > 0) then {
	//Chance to add miscellaneous item (Small) to backpack
	for "_i" from 1 to MAI_numMiscItemS do {
		if ((random 1) < MAI_chanceMiscItemS) then {
			private ["_miscItemS"];
			_miscItemS = MAI_MiscItemS call BIS_fnc_selectRandom2;
			(unitBackpack _unit) addMagazineCargoGlobal [_miscItemS,1];
			if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Generated Misc Item (Small): %1 for AI.",_miscItemS];};
		};
	};
	
	//Chance to add miscellaneous item (Large) to backpack
	for "_i" from 1 to MAI_numMiscItemL do {
		if ((random 1) < MAI_chanceMiscItemL) then {
			private["_miscItemL"];
			_miscItemL = MAI_MiscItemL call BIS_fnc_selectRandom2;
			(unitBackpack _unit) addMagazineCargoGlobal [_miscItemL,1];
			if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Generated Misc Item (Large): %1 for AI.",_miscItemL];};
		};
	};

	//Add medical items to backpack
	for "_i" from 1 to MAI_bpmedicals do {
		if ((random 1) < MAI_chanceMedicals) then {
			private["_bpmedical"];
			_bpmedical = MAI_Medicals2 call BIS_fnc_selectRandom2;
			(unitBackpack _unit) addMagazineCargoGlobal [_bpmedical, 1];
			if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Generated Backpack Medical Item: %1 for AI.",_bpmedical];};
		};
	};

	//Add medical items to inventory
	for "_i" from 1 to MAI_invmedicals do {
		if ((random 1) < MAI_chanceMedicals) then {
			private["_invmedical"];
			_invmedical = MAI_Medicals1 call BIS_fnc_selectRandom2;
			_unit addMagazine _invmedical;
			if (MAI_debugLevel > 1) then {diag_log format["MAI Extended Debug: Generated Inventory Medical Item: %1 for AI.",_invmedical];};
		};
	};
	
	if (MAI_modName == "epoch") then {
		private ["_itemBar","_index","_chance","_metalBarCount"];
		_metalBarCount = (count MAI_metalBars);
		//diag_log format ["DEBUG :: Counted %1 bars in MAI_metalBars.",_metalBarCount];
		for "_i" from 0 to MAI_metalBarNum do {
			_index = floor (random _metalBarCount);
			_chance = ((MAI_metalBars select _index) select 1);
			//diag_log format ["DEBUG :: %1 chance to add bar.",_chance];
			if ((random 1) < _chance) then {
				_itemBar = ((MAI_metalBars select _index) select 0);
				_unit addMagazine _itemBar;
				//diag_log format ["DEBUG :: Added bar %1 as loot to AI corpse.",_itemBar];
			};
		};
	};
};

sleep 0.001;

//Add tool items
////////////////////////////////////////////////////////////////////////////////////////////////////////////

_toolsArray = if (_weapongrade < 2) then {MAI_tools0} else {MAI_tools1};

//diag_log format ["DEBUG :: Counted %1 tools in _toolsArray.",(count _toolsArray)];
for "_i" from 0 to ((count _toolsArray) - 1) do {
	_chance = ((_toolsArray select _i) select 1);
	//diag_log format ["DEBUG :: %1 chance to add tool.",_chance];
	if ((random 1) < _chance) then {
		_tool = ((_toolsArray select _i) select 0);
		_unit addWeapon _tool;
		//diag_log format ["DEBUG :: Added tool %1 as loot to AI corpse.",_tool];
	};
};