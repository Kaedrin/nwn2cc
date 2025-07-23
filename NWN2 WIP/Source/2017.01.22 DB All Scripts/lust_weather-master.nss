void rain_increase(object oArea);
void rain_decrease(object oArea);
int verify_rounds();
void show_raininfo();
void adjust_sound();
void create_ray();

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

void main()
{
	int LightiningChances = GetLocalInt(OBJECT_SELF, "Lightining_Frecuence_Adjust"); //100 duplicates the waiting time
	int RainChances = GetLocalInt(OBJECT_SELF, "Rain_Frecuence");
	int RainMaxPower = GetLocalInt(OBJECT_SELF, "Rain_MaxPower");
	if (RainChances==0) RainChances=1;
	if (RainMaxPower==0) RainMaxPower=5;
	SetLocalInt(OBJECT_SELF, "Fallen_Ray", 0);
	object oArea = GetArea(OBJECT_SELF);
	int iRainPower = GetWeather(oArea, WEATHER_TYPE_RAIN);
	
	if (verify_rounds() == 1)
	{
		if (iRainPower !=0) //If it's raining
		{
			if (d100() <= RainChances) //Then there's some chances to change to bigger
			{
				if (iRainPower !=RainMaxPower) //If the rain ist's not extreme then
					{
					rain_increase(oArea); //increases
					}
				else //else, if the rain is not extreme, then
					{
					rain_decrease(oArea); //decrease
					}
			} 
			else //if the chance is not given to rain stronger, then
				rain_decrease(oArea); //it means it must to decrease
		}
		else //Else, if Rainpower is 1
			rain_increase(oArea);
		adjust_sound();
	}

	int iRainPower_factor;
	switch(iRainPower)
	{
		case 0:                          break;
		case 1: iRainPower_factor = 240; break;
		case 2: iRainPower_factor = 160; break;
		case 3: iRainPower_factor = 80;  break;
		case 4: iRainPower_factor = 40;  break;
		case 5: iRainPower_factor = 20;  break;
		default: 						 break; 	
	}
	if ((iRainPower>0)&&(Random(iRainPower_factor+(LightiningChances/iRainPower))<2)) create_ray();	
	//SendMessageToPC(GetFirstPC(), "Wheather time for... "+IntToString(GetLocalInt(OBJECT_SELF, "WeatherRounds")/10)+" minutes.");
}

void rain_increase(object oArea)
{
	int iRainPower = GetWeather(oArea, WEATHER_TYPE_RAIN);
	if (iRainPower < 5)
		SetWeather(oArea, WEATHER_TYPE_RAIN, iRainPower + 1);
}

void rain_decrease(object oArea)
{
	int SunMultiplier = GetLocalInt(OBJECT_SELF, "Sun_Multiplier_Time");
	if (SunMultiplier == 0) SunMultiplier = 3;
	int iRainPower = GetWeather(oArea, WEATHER_TYPE_RAIN);
	if (iRainPower > 0)
		SetWeather(oArea, WEATHER_TYPE_RAIN, iRainPower - 1);
	if (GetWeather(oArea, WEATHER_TYPE_RAIN) == 0)
		SetLocalInt(OBJECT_SELF, "WeatherRounds", GetLocalInt(OBJECT_SELF, "WeatherRounds") * SunMultiplier);
}

int verify_rounds()
{
	int WeatherStability = GetLocalInt(OBJECT_SELF, "Weather_Stability");
	if (WeatherStability <3) WeatherStability = 3;
	int WeatherRounds = GetLocalInt(OBJECT_SELF, "WeatherRounds");
	if (WeatherRounds == 0) 
		{
		int NewWeatherRounds = Random(WeatherStability)+5;
		SetLocalInt(OBJECT_SELF, "WeatherRounds", NewWeatherRounds);
		return TRUE;
		}
	else{
		SetLocalInt(OBJECT_SELF, "WeatherRounds", WeatherRounds - 1);
		return FALSE;
		}
}

void adjust_sound()
{
	object oArea = GetArea(OBJECT_SELF);
	int iRainPower = GetWeather(oArea, WEATHER_TYPE_RAIN);
	object oSoundObject = GetNearestObjectByTag("RainSound");
	
	if (iRainPower>0)
		{
		SoundObjectPlay(oSoundObject);
		SoundObjectSetVolume(oSoundObject, iRainPower * 10 + 7);
		}
	else
		SoundObjectStop(oSoundObject);
}

void create_ray()
{
	object oArea = GetArea(OBJECT_SELF);
	location lLocation = RandomLoc(oArea);
	DelayCommand(1.2, SoundObjectPlay(GetNearestObjectByTag("RaySound")));
	object oStorm_Light = CreateObject(OBJECT_TYPE_LIGHT,"lust_storm", lLocation);
	DestroyObject(oStorm_Light, 0.8);	
	SetLocalInt(OBJECT_SELF, "Fallen_Ray", 1); //This variable will be null in 6 seconds, but will give time
											   //To be readed by the slave.
}