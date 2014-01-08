_crate3 = _this select 0;

clearWeaponCargoGlobal _crate3;
clearMagazineCargoGlobal _crate3;

private ["_crate3","_amount","_lootTable","_index","_itemType","_config","_itemTypes","_weights","_cntWeights","_num"];

_lootTable = "Crate5";

crate_add_loot = {

	private ["_iItem","_iClass","_itemTypes","_index","_weights","_cntWeights","_qty","_max","_tQty","_canType","_mags","_amount","_crate3"];



	_iItem = 	_this select 0;

	_iClass = 	_this select 1;

	_crate3 =    _this select 2;



	switch (_iClass) do

	{

		default

		{

			_itemTypes = [] + ((getArray (missionconfigFile >> "cfgLoot" >> _iClass)) select 0);

			_index = dayz_CLBase find _iClass;

			_weights = dayz_CLChances select _index;

			_cntWeights = count _weights;

			_qty = 3;

			_max = 1 + round(random 3);

			while {_qty < _max} do

			{

				_tQty = 1 + round(random 1);

				_index = floor(random _cntWeights);

				_index = _weights select _index;

				_canType = _itemTypes select _index;

				_crate3 addMagazineCargoGlobal [_canType,_tQty];

				_qty = _qty + _tQty;

			};

			if (_iItem != "") then

			{

				_crate3 addWeaponCargoGlobal [_iItem,random(4)];

			};

		};

		case "single":

		{

			_amount = round(random 5);

			_itemTypes = [] + ((getArray (missionconfigFile >> "cfgLoot" >> _iItem)) select 0);

			_index = dayz_CLBase find _iItem;

			_weights = dayz_CLChances select _index;

			_cntWeights = count _weights;

				

			_index = floor(random _cntWeights);

			_index = _weights select _index;

			_canType = _itemTypes select _index;

			

			_crate3 addMagazineCargoGlobal [_canType,_amount];

			_crate3 addMagazineCargoGlobal ["ItemSilverBar",_amount];

			

		};

		case "backpack":

		{

			_amount = round(random 2);

			_itemTypes = [] + ((getArray (missionconfigFile >> "cfgLoot" >> _iItem)) select 0);

			_index = dayz_CLBase find _iItem;

			_weights = dayz_CLChances select _index;

			_cntWeights = count _weights;

			_index = floor(random _cntWeights);

			_index = _weights select _index;

			_iItem = _itemTypes select _index;

			

			_crate3 addBackpackCargoGlobal [_iItem,1];

		};

		case "cfglootweapon":

		{

			_amount = round(random 3);

			_itemTypes = [] + ((getArray (missionConfigFile >> "cfgLoot" >> _iItem)) select 0);

			_index = dayz_CLBase find _iItem;

			_weights = dayz_CLChances select _index;

			_cntWeights = count _weights;

				

			_index = floor(random _cntWeights);

			_index = _weights select _index;

			_iItem = _itemTypes select _index;



			if (_iItem == "Chainsaw") then {

				_iItem = ["ChainSaw","ChainSawB","ChainSawG","ChainSawP","ChainSawR"] call BIS_fnc_selectRandom;

			};



			//Item is a weapon, add it and a random quantity of magazines

			_crate3 addWeaponCargoGlobal [_iItem,_amount];

			_mags = [] + getArray (configFile >> "cfgWeapons" >> _iItem >> "magazines");

			if ((count _mags) > 0) then

			{

				if (_mags select 0 == "Quiver") then { _mags set [0, "WoodenArrow"] }; // Prevent spawning a Quiver

				if (_mags select 0 == "20Rnd_556x45_Stanag") then { _mags set [0, "30Rnd_556x45_Stanag"] };

				_crate3 addMagazineCargoGlobal [(_mags select 0), (_amount*(round(random 5)))];

			};

			

		};

		

		case "weapon":

		{

			_amount = round(random 3);

			_crate3 addWeaponCargoGlobal [_iItem,_amount];

			_mags = [] + getArray (configFile >> "cfgWeapons" >> _iItem >> "magazines");

			if ((count _mags) > 0) then

			{

				if (_mags select 0 == "Quiver") then { 

					_mags set [0, "WoodenArrow"] 

				};

				_crate3 addMagazineCargoGlobal [(_mags select 0), (_amount*(round(random 5)))];

			};

		};

		case "weaponnomags":

		{

			//_crate3 addWeaponCargoGlobal [_iItem,1];

			_amount = round(random 6);

			_crate3 addMagazineCargoGlobal [_iItem, _amount];

		};

		case "magazine":

		{

			_amount = round(random 6);

			_crate3 addMagazineCargoGlobal [_iItem,_amount];

		};

		case "object":

		{

			_amount = round(random 5);

			_crate3 addMagazineCargoGlobal ["ItemGoldBar", _amount];

		};

	};

};

_config = 		missionConfigFile >> "CfgBuildingLoot" >> _lootTable;
_itemTypes =	[] + getArray (_config >> "itemType");
_index =        dayz_CBLBase find toLower(_lootTable);
_weights =		dayz_CBLChances select _index;
_cntWeights = count _weights;


_num = 35;
_amount = round(random 8);


for "_x" from 1 to (_num + _amount) do {
	//create loot
	sleep 1;
	_index = floor(random _cntWeights);
	_index = _weights select _index;
	_itemType = _itemTypes select _index;
	[_itemType select 0, _itemType select 1, _crate3] spawn crate_add_loot;
};