_coords = _this select 0;
_wait_time = 600;

_crashsitemark = createMarker ["crashsitemark", _coords];
_crashsitemark setMarkerShape "ICON";
_crashsitemark setMarkerType "mil_unknown";
_crashsitemark setMarkerColor "Colorblack";
_crashsitemark setMarkerAlpha 1;

_crashsitemarkAI = createMarker ["crashsitemarkAI", _coords];
_crashsitemarkAI setMarkerShape "ELLIPSE";
_crashsitemarkAI setMarkerType "Empty";
_crashsitemarkAI setMarkerBrush "Solid";
_crashsitemarkAI setMarkerSize [100, 100];
_crashsitemarkAI setMarkerAlpha 0;

["crashsitemarkAI",2,2,false] call DZAI_spawn;

_hint = parseText format["<t align='center' color='#0D00FF' shadow='2' size='1.75'>Heli Crash</t><br/><t align='center' color='#ffffff'>Survivors Have Spoted a Heli Crash better loot it befor bandits do, Check your Map for the Location!</t>"];
customRemoteMessage = ['hint', _hint];
publicVariable "customRemoteMessage";

sleep _wait_time;
deleteMarker _crashsitemark;
deleteMarker _crashsitemarkAI;
