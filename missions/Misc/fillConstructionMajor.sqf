//Created by TheSzerdi edited by MimiC
_crate = _this select 0;

clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;

// CONSTRUCTION MATERIALS
_crate addMagazineCargoGlobal ["bulk_empty", 25];
_crate addMagazineCargoGlobal ["CinderBlocks", 25];
_crate addMagazineCargoGlobal ["MortarBucket", 25];
_crate addMagazineCargoGlobal ["PartPlywoodPack", 10];
_crate addMagazineCargoGlobal ["PartLumberPack", 10];
_crate addMagazineCargoGlobal ["ItemCanvas", 25];
_crate addMagazineCargoGlobal ["PartGeneric", 25];
_crate addMagazineCargoGlobal ["ItemSandbag", 15];
_crate addMagazineCargoGlobal ["ItemTankTrap", 15];
_crate addMagazineCargoGlobal ["PartWoodPile", 20];

// TOOLS
_crate addWeaponCargoGlobal ["ItemToolbox", 2];
_crate addWeaponCargoGlobal ["ItemEtool", 2];
_crate addWeaponCargoGlobal ["ItemCrowbar", 2];
_crate addWeaponCargoGlobal ["ItemKnife", 2];