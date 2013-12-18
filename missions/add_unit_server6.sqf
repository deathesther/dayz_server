//Created by Axeman Edited by TheSzerdi
private ["_aiunit","_xpos","_ypos","_unitpos","_aiGroup","_levelnum","_numunits","_rndLOut","_ailoadout","_aispawnpos","_aiwep1","_aiammo1","_aiwep2","_aiammo2"];
 
    _aiunit = objNull;
    _aiGroup = createGroup EAST;
    _aispawnpos =_this select 0;
    _numunits = _this select 1;
    _levelnum = _this select 2;
	LandingParty = createGroup EAST;
	publicVariable "LandingParty";
 
    _xpos = _aispawnpos select 0;
    _ypos = _aispawnpos select 1;
 
    diag_log format ["AIUNIT: Spawn initiated: Centre:%1 | WeaponLevel:%2",_aispawnpos,_levelnum];
 
    for [{ x=1 },{ x < _numunits+1 },{ x = x + 1; }] do
    {
        _unitpos = [_xpos+x,_ypos+x,51];
 
        if (_levelnum==0) then // in_sityes troops
        {
            if ((x == 1) || (x == 3) || (x == 5)) then //troop soldiers
            {
                "TK_INS_Soldier_EP1" createUnit [_unitpos, _aiGroup, "_aiunit=this;",1,"PRIVATE"];
                _rndLOut=floor(random 4);
                _ailoadout=
                switch (_rndLOut) do
                {
                  case 0: {["M1014","8Rnd_B_Beneli_74Slug"]};
                  case 1: {["M1014","8Rnd_B_Beneli_Pellets"]};
                  case 2: {["Remington870_lamp","8Rnd_B_Beneli_74Slug"]};
                  case 3: {["Remington870_lamp","8Rnd_B_Beneli_Pellets"]};
                };
            };
            if ((x == 2) || (x == 4) || (x >= 6)) then //troops snipers
            {
                "TK_INS_Soldier_EP1" createUnit [_unitpos, _aiGroup, "_aiunit=this;",1,"PRIVATE"];
                _rndLOut=floor(random 3);
                _ailoadout=
                switch (_rndLOut) do
                {
                  case 0: {["LeeEnfield","10x_303"]};
                  case 1: {["Huntingrifle","5x_22_LR_17_HMR"]};
                  case 2: {["M14_EP1","20Rnd_762x51_DMR"]};
                };
            };
        };
        if (_levelnum==1) then //in_military troops
        {
            if (x == 1) then //one troops comander
            {
                "Ins_Soldier_1" createUnit [_unitpos, LandingParty, "_aiunit=this;",1,"LIEUTENANT"];
                _rndLOut=floor(random 7);
                _ailoadout=
                switch (_rndLOut) do
                {
                  case 0: {["AK_47_M","30Rnd_762x39_AK47"]};
                  case 1: {["AK_47_S","30Rnd_762x39_AK47"]};
                  case 2: {["Sa58P_EP1","30Rnd_762x39_SA58"]};
                  case 3: {["Sa58V_CCO_EP1","30Rnd_762x39_SA58"]};
                  case 4: {["Sa58V_EP1","30Rnd_762x39_SA58"]};
                  case 5: {["FN_FAL","20Rnd_762x51_FNFAL"]};
                  case 6: {["FN_FAL_ANPVS4","20Rnd_762x51_FNFAL"]};
                };
            };
            if ((x == 2) || (x == 3)) then //troops sergeant
            {
                "Ins_Soldier_1" createUnit [_unitpos, LandingParty, "_aiunit=this;",1,"SERGEANT"];
                _rndLOut=floor(random 3);
                _ailoadout=
                switch (_rndLOut) do
                {
                  case 0: {["M249_DZ","200Rnd_556x45_M249"]};
                  case 1: {["G36_C_SD_camo","30Rnd_556x45_StanagSD"]};
                  case 2: {["G36_C_SD_camo","30Rnd_556x45_StanagSD"]};
                };
            };
            if (x > 3) then //troops soldiers
            {
                "Ins_Soldier_1" createUnit [_unitpos, LandingParty, "_aiunit=this;",1,"CORPORAL"];
         
                _rndLOut=floor(random 4);
                _ailoadout=
                switch (_rndLOut) do
                {
                  case 0: {["SVD_CAMO","10Rnd_762x54_SVD","Sa61_EP1","20Rnd_B_765x17_Ball"]};
                  case 1: {["M24","5Rnd_762x51_M24","Sa61_EP1","20Rnd_B_765x17_Ball"]};
                  case 2: {["M40A3","5Rnd_762x51_M24","Sa61_EP1","20Rnd_B_765x17_Ball"]};
                  case 3: {["G36_C_SD_camo","30Rnd_556x45_StanagSD""Sa61_EP1","20Rnd_B_765x17_Ball"]};
                };
            };
        };
        diag_log format ["AIUNIT: Creating NVGoggles by %1 at %2. Result:%3 | Loadout:%4 / Num:%5",player,_unitpos,_aiunit,_ailoadout,_rndLOut];
 
        _aiunit enableAI "TARGET";
        _aiunit enableAI "AUTOTARGET";
        _aiunit enableAI "MOVE";
        _aiunit enableAI "ANIM";
        _aiunit enableAI "FSM";
        _aiunit allowDammage true;
		
		_aiunit addEventHandler ['killed',{_this execVM "\z\addons\dayz_server\Missions\bodyclean.sqf"}]; //Body disappear time
 
        _aiunit setCombatMode "RED";
        _aiunit setBehaviour "COMBAT";
 
        //clear default weapons / ammo
        removeAllWeapons _aiunit;
        //add random selection
        _aiwep1 = _ailoadout select 0;
        _aiammo1 = _ailoadout select 1;
        _aiwep2 = _ailoadout select 2;
        _aiammo2 = _ailoadout select 3;
        _aiunit addweapon _aiwep1;
        _aiunit addMagazine _aiammo1;
        _aiunit addMagazine _aiammo1;
        _aiunit addMagazine _aiammo1;
        _aiunit addweapon _aiwep2;
        _aiunit addMagazine _aiammo2;
        _aiunit addMagazine _aiammo2;
      //add some garbage
        if (x == 1) then {
        _aiunit addMagazine "SmokeShellGreen";
        _aiunit addMagazine "HandGrenade_West";
        _aiunit addMagazine "FoodCanBakedBeans";
        _aiunit addMagazine "ItemSodaCoke";
        _aiunit addMagazine "ItemPainkiller";
        _aiunit addMagazine "ItemHeatPack";
        _aiunit addMagazine "ItemEpinephrine";
        _aiunit addMagazine "ItemMorphine";
        };
        if (x == 2) then {
        _aiunit addMagazine "ItemHeatPack";
        _aiunit addMagazine "ItemPainkiller";
        _aiunit addMagazine "ItemEpinephrine";
        _aiunit addMagazine "ItemMorphine";
        };
        if (x >= 3) then {
        _aiunit addMagazine "ItemHeatPack";
        _aiunit addMagazine "ItemBandage";
        };
        //set skills
        _aiunit setSkill ["aimingAccuracy",0.6];
        _aiunit setSkill ["aimingShake",0.7];
        _aiunit setSkill ["aimingSpeed",0.8];
        _aiunit setSkill ["endurance",0.9];
        _aiunit setSkill ["spotDistance",0.8];
        _aiunit setSkill ["spotTime",0.7];
        _aiunit setSkill ["courage",0.9];
        _aiunit setSkill ["reloadSpeed",1];
        _aiunit setSkill ["commanding",1];
        _aiunit setSkill ["general",1];
        //sleep 0.5;
    };
