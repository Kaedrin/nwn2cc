void rain_set(object oAreaMaster, object oAreaSlave, int iRainPower);
void adjust_sound(object oAreaMaster);
void create_ray();

void main()
{
	object oMaster = GetObjectByTag(GetLocalString(OBJECT_SELF, "MasterTag"));
	object oAreaMaster = GetArea(oMaster);
	object oAreaSlave = GetArea(OBJECT_SELF);
	int iRainPower = GetWeather(oAreaMaster, WEATHER_TYPE_RAIN);
	rain_set(oAreaMaster, oAreaSlave, iRainPower);
	adjust_sound(oAreaMaster);
	if (GetLocalInt(oMaster, "Fallen_Ray")==1) create_ray();
}

void rain_set(object oAreaMaster, object oAreaSlave, int iRainPower)
{
	int iRainPower = GetWeather(oAreaMaster, WEATHER_TYPE_RAIN);
	SetWeather(oAreaSlave, WEATHER_TYPE_RAIN, iRainPower);
}

void adjust_sound(object oAreaMaster)
{
	object oArea = GetArea(OBJECT_SELF);
	int iRainPower = GetWeather(oAreaMaster, WEATHER_TYPE_RAIN);
	object oSoundObject = GetNearestObjectByTag("RainSound");
	
	if (!GetIsAreaInterior(oArea))
	{
		if (iRainPower>0)
			{
			SoundObjectPlay(oSoundObject);
			SoundObjectSetVolume(oSoundObject, iRainPower * 15 + 10);
			}
		else
			SoundObjectStop(oSoundObject);
	} else
	{
		if (iRainPower>0)
			{
			SoundObjectPlay(oSoundObject);
			SoundObjectSetVolume(oSoundObject, iRainPower * 7 + 5);
			}
		else
			SoundObjectStop(oSoundObject);	
	}
}

location RandomLoc(object oArea)
{
   float fAreaH = IntToFloat(GetAreaSize(AREA_HEIGHT, oArea));
   float fAreaW = IntToFloat(GetAreaSize(AREA_WIDTH, oArea));
   float fMaxAreaSizeH = 32.0;
   float fMaxAreaSizeW = 32.0;
   float fScaleAreaH = fMaxAreaSizeH/fAreaH;
   float fScaleAreaW = fMaxAreaSizeW/fAreaW;
   float fXLoc32 = IntToFloat( ((d8()-1)*4 + (d4()-1))*10 + d10() );
   float fYLoc32 = IntToFloat( ((d8()-1)*4 + (d4()-1))*10 + d10() );
   float fXLoc = fXLoc32/fScaleAreaW;
   float fYLoc = fYLoc32/fScaleAreaH;
   vector vPosition = Vector(fXLoc, fYLoc, 150.0f);
   float fOrientation = IntToFloat( ((d6()-1)*6 +(d6()-1))*10 + (d10()-1) );
   return Location(oArea, vPosition , fOrientation);
}

void create_ray()
{
	object oArea = GetArea(OBJECT_SELF);
	location lLocation = RandomLoc(oArea);
	object oSoundObject = GetNearestObjectByTag("RaySound");
	object oStorm_Light;
	if (!GetIsAreaInterior(oArea))
	{
		oStorm_Light = CreateObject(OBJECT_TYPE_LIGHT,"lust_storm", lLocation);
		SoundObjectSetVolume(oSoundObject, 127);
	} else
	{
		oStorm_Light = CreateObject(OBJECT_TYPE_LIGHT,"lust_storm_soft", lLocation);
		SoundObjectSetVolume(oSoundObject, 50);
	}
	DestroyObject(oStorm_Light, 0.8);
	DelayCommand(1.2, SoundObjectPlay(oSoundObject));
}