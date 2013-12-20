
_areas = _this;

waitUntil {sleep 1; !isNil "MAI_locations_ready"};

for "_i" from 0 to ((count _areas) -1) do {
	private ["_area"];
	
	_area = _areas select _i;
	if ((getMarkerColor _area) != "") then {
		private ["_areaSize","_sizeX","_sizeY","_blacklist"];
		_areaSize = getMarkerSize _area;
		_sizeX = if ((_areaSize select 0) > 0) then {_areaSize select 0} else {100};
		_sizeY = if ((_areaSize select 1) > 0) then {_areaSize select 1} else {100};
		_blacklist = createLocation ["Strategic",getMarkerPos _area,_sizeX,_sizeY];
	};
	sleep 0.001;
};
