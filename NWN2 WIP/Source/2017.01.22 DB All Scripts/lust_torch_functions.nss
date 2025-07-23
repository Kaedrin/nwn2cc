 /////////////////////////////////////////////////////////////////////////////////
//This function prepares and destroy the oTarget
//--------------------------------------------------------------------------------
//Written by Esteban Manuel
//Date: 01-12-2011 [DDMMYYYY]
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
void lust_destroyobject(object oTarget)
{
	SetPlotFlag(oTarget,FALSE);
    SetImmortal(oTarget,FALSE);
    AssignCommand(oTarget,SetIsDestroyable(TRUE,FALSE,FALSE));
    DestroyObject (oTarget, 0.0);
}
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//This function inscribes a variable with the location for the light and the fx.
//The variables are called: loc_fx and loc_light .
//--------------------------------------------------------------------------------
//Written by Esteban Manuel
//Date: 01-12-2011 [DDMMYYYY]
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------

void lust_writelocations(object oTarget)
{
	if(!GetLocalInt(oTarget, "WritedLocations"))
	{
		location loc = GetLocation(oTarget);
		float facing = GetFacing(oTarget)+GetLocalInt(oTarget,"Rotation");
		float reverse = IntToFloat(FloatToInt(facing + 180.0f) % 360);
		vector Posicion = GetPositionFromLocation(loc);
		Posicion.x += GetLocalFloat(oTarget,"FX_Length") * cos(reverse);
		Posicion.y += GetLocalFloat(oTarget,"FX_Length") * sin(reverse);
		Posicion.z += GetLocalFloat(oTarget,"FX_Heigth");
		loc = Location(GetArea(oTarget), Posicion, facing);
		Posicion.x += (GetLocalFloat(oTarget,"FX_Length") 
		                             + GetLocalFloat(oTarget,"Ligth_Length")) * cos(reverse);
		Posicion.y += (GetLocalFloat(oTarget,"FX_Length") 
		                             + GetLocalFloat(oTarget,"Ligth_Length")) * sin(reverse);
		Posicion.z +=  GetLocalFloat(oTarget,"FX_Heigth") 
		                             + GetLocalFloat(oTarget,"Ligth_Heigth");
		location loc2 = Location(GetArea(oTarget), Posicion, facing);
		SetLocalLocation(oTarget,"loc_fx",loc);
		SetLocalLocation(oTarget,"loc_light",loc2);
		SetLocalInt(oTarget, "WritedLocations", 1); //This one forces to write the locations only once
	}
}
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//This function reviews if a variable is empty and writes a default one if it's
//true, if the user wishes to do not use a light, sound, or FX, must to write on 
//the variable the word NONE.
//--------------------------------------------------------------------------------
//Written by Esteban Manuel
//Date: 01-12-2011 [DDMMYYYY]
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
void lust_verifyvariablenames(object oTarget)
{
	if(!GetLocalInt(oTarget, "VerifiedVariableNames"))
	{
		if (GetLocalString(oTarget,"FX_Name")=="")
			SetLocalString(oTarget,"FX_Name","n2_fx_torchglow" );
		if (GetLocalString(oTarget,"Light_Name")=="")
			SetLocalString(oTarget,"Light_Name","torchlight");
		if (GetLocalString(oTarget,"Sound_Name" )=="")
			SetLocalString(oTarget,"Sound_Name" ,"al_en_firesml_02");
		if (GetLocalString(oTarget,"LitObject_Tag" )=="")
			SetLocalString(oTarget,"LitObject_Tag" ,"FLINT");
		if (GetLocalString(oTarget,"LitWeapon_Tag" )=="")
			SetLocalString(oTarget,"LitWeapon_Tag" ,"NW_IT_TORCH001");
			SetLocalInt(oTarget,"NigthAndDay",GetLocalInt(GetNearestObjectByTag(GetTag(oTarget),oTarget),"NigthAndDay"));
			SetLocalInt(oTarget,"LitChances",GetLocalInt(GetNearestObjectByTag(GetTag(oTarget),oTarget),"LitChances" ));
		SetLocalInt(oTarget, "VerifiedVariableNames", 1); //This one forces to write the locations only once
	}	
}
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//This function creates a light and a FX on the written possition on the variable.
//--------------------------------------------------------------------------------
//Written by Esteban Manuel
//Date: 01-12-2011 [DDMMYYYY]
//Edited: 03-06-2013 Child effects are now treated as child and not only possitional
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
void lust_createfxandlight(object oTarget)
{
	if(!GetLocalInt(oTarget, "Created_LightFX"))
	{
		if (GetLocalInt(oTarget,"Active")==0)
		{
			SetLocalInt(oTarget,"Active",1);
				SetLocalObject(oTarget, "my_VFX", CreateObject(OBJECT_TYPE_PLACED_EFFECT,GetLocalString(oTarget,"FX_Name"), GetLocalLocation(oTarget,"loc_fx"),-1,"MyOwnFX"));
				SetLocalObject(oTarget, "my_Light", CreateObject(OBJECT_TYPE_LIGHT, GetLocalString(oTarget,"Light_Name"),  GetLocalLocation(oTarget,"loc_light"), -1, "MyOwnLight"));
			AssignCommand(oTarget, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
		}
		SetLocalInt(oTarget, "Created_LightFX", 1);
	}
	else
	{
		if (GetLocalInt(oTarget,"Active")==0)
		{
			SetLocalInt(oTarget,"Active",1);
			if (!GetIsObjectValid(GetLocalObject(oTarget, "my_VFX")))
				SetLocalObject(oTarget, "my_VFX", CreateObject(OBJECT_TYPE_PLACED_EFFECT,GetLocalString(oTarget,"FX_Name"), GetLocalLocation(oTarget,"loc_fx"),-1,"MyOwnFX"));
			SetLightActive(GetLocalObject(oTarget, "my_Light"), TRUE);
			AssignCommand(oTarget, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
		}
	}
}
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//This function destroys a light and FX at the position written on the variables.
//--------------------------------------------------------------------------------
//Written by Esteban Manuel
//Date: 01-12-2011 [DDMMYYYY]
//Edited: 03-06-2013 Child effects are now treated as child and not only possitional
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
void lust_destroyfxandlight(object oTarget)
{
	SetLocalInt(oTarget,"Active",0);	
	lust_destroyobject(GetLocalObject(oTarget, "my_VFX"));
	DeleteLocalObject(oTarget, "my_VFX");
	SetLightActive(GetLocalObject(oTarget, "my_Light"), FALSE);
	AssignCommand(oTarget, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//This function plays a sound from the variable.
//--------------------------------------------------------------------------------
//Written by Esteban Manuel
//Date: 01-12-2011 [DDMMYYYY]
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
void lust_playsound(object oTarget)
{
	if (GetLocalInt(oTarget,"Active")==1)
	{
		AssignCommand(oTarget, PlaySound(GetLocalString(oTarget,"Sound_Name")));
		SoundObjectStop(oTarget);
	}
} 

void lust_continuesound(object oTarget)
{	
	if (GetLocalInt(oTarget,"Active")==1)
	{
		int ilength = GetSoundFileDuration(GetLocalString(oTarget,"Sound_Name"));
		float fLength = ilength/1000.0;
		if (fLength>0.5)
		{
			DelayCommand(fLength,lust_playsound(oTarget));
			DelayCommand(fLength,lust_continuesound(oTarget));
		}
	}
}
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//This function initializes the main variables filling them, it happens only once.
//--------------------------------------------------------------------------------
//Written by Esteban Manuel
//Date: 01-12-2011 [DDMMYYYY]
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
void lust_initialize(object oTarget)
{
	if (GetLocalInt(oTarget, "Initialized")==0){
		lust_writelocations(oTarget);
		lust_verifyvariablenames(oTarget);
		SetLocalInt(oTarget,"Initialized",1);
	}
}
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//This function searches for a item, if it finds it then returns 1
//--------------------------------------------------------------------------------
//Written by Esteban Manuel
//Date: 01-12-2011 [DDMMYYYY]
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
int lust_HasEnlightItem(int bCheckParty, object oTorchTarget)
{
	lust_initialize(oTorchTarget);
	string ObjectToUse = GetLocalString(oTorchTarget,"LitObject_Tag");
    object oPlayer = GetLastUsedBy();
	object oFaction;
    if (!bCheckParty){return GetIsObjectValid(GetItemPossessedBy(GetLastUsedBy(),ObjectToUse));}
    else
    { oFaction =  GetFirstFactionMember(oPlayer, FALSE);
        while(GetIsObjectValid(oFaction))
        {	if(GetIsObjectValid(GetItemPossessedBy(oFaction,ObjectToUse)) ) return TRUE;
            oFaction = GetNextFactionMember(oPlayer, FALSE);}
    }
    return FALSE;
}
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//This function inspects the hands of the character looking for a weapon or torch.
//--------------------------------------------------------------------------------
//Written by Esteban Manuel; Date: 01-12-2011 [DDMMYYYY]
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
int lust_IsTorchEquipped(object oTarget)
{
	string LitWeapon_Tag = GetLocalString(oTarget,"LitWeapon_Tag");
	
	
	// Hyper-V :: allow torch/lanterns
	string tag = GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, GetLastUsedBy()));
	if (tag == "NW_IT_TORCH001" 
		|| tag == "AMR_IT_BRASS_LANTERN" 
		|| tag == "AMR_IT_BURNING_STICK"
		|| tag == "AMR_IT_LANTERN02"
		|| tag == "AMR_IT_CANDLES01"
		|| tag == "AMR_IT_LANTERN03")
	{
		return TRUE;
	}
	else {
		tag = GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetLastUsedBy()));
		if (tag == "NW_IT_TORCH001" 
			|| tag == "AMR_IT_BRASS_LANTERN" 
			|| tag == "AMR_IT_BURNING_STICK"
			|| tag == "AMR_IT_LANTERN02"
			|| tag == "AMR_IT_CANDLES01"
			|| tag == "AMR_IT_LANTERN03")
		{
			return TRUE;
		}
		else {
			return FALSE;
		}	
	}
	
	
	return FALSE;
	
	
	//return (GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetLastUsedBy())) == LitWeapon_Tag ||
	//        GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, GetLastUsedBy())) == LitWeapon_Tag);
}
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//This function heals an object or creature.
//--------------------------------------------------------------------------------
//Written by Esteban Manuel; Date: 01-12-2011 [DDMMYYYY]
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
void lust_heal(object oTarget)
{
	effect eHeal = EffectHeal(GetMaxHitPoints(oTarget));
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
}
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//This functions gives true if recives the elemental damage.
//--------------------------------------------------------------------------------
//Written by Esteban Manuel; Date: 01-12-2011 [DDMMYYYY]
//Edited on 03-06-2013 adding the support to all elemental sources [Lustabel's Sub-Engine]
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
int lust_cortantedamage()
{
	int nTypeDamage = GetLocalInt(OBJECT_SELF, "omg_cortante");
	if(nTypeDamage+GetDamageDealtByType(DAMAGE_TYPE_SLASHING) > 0) return TRUE; else return FALSE;
}
  
int lust_contundentedamage()
{
	int nTypeDamage = GetLocalInt(OBJECT_SELF, "omg_contundente");
	if(nTypeDamage+GetDamageDealtByType(DAMAGE_TYPE_BLUDGEONING) > 0) return TRUE; else return FALSE;
}
  
int lust_perforantedamage()
{
	int nTypeDamage = GetLocalInt(OBJECT_SELF, "omg_perforante");
	if(nTypeDamage+GetDamageDealtByType(DAMAGE_TYPE_PIERCING) > 0) return TRUE; else return FALSE;
}
  
int lust_fuegodamage()
{
	int nTypeDamage = GetLocalInt(OBJECT_SELF, "omg_fuego");
	if(nTypeDamage+GetDamageDealtByType(DAMAGE_TYPE_FIRE) > 0) return TRUE; else return FALSE;
}
  
int lust_aguadamage()
{
	int nTypeDamage = GetLocalInt(OBJECT_SELF, "omg_agua");
	if(nTypeDamage+GetDamageDealtByType(DAMAGE_TYPE_COLD) > 0) return TRUE; else return FALSE;
}
  
int lust_vientodamage()
{
	int nTypeDamage = GetLocalInt(OBJECT_SELF, "omg_viento");
	if(nTypeDamage+GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL) > 0) return TRUE; else return FALSE;
}
  
int lust_tierradamage()
{
	int nTypeDamage = GetLocalInt(OBJECT_SELF, "omg_tierra");
	if(nTypeDamage > 0) return TRUE; else return FALSE;
}
  
int lust_divinodamage()
{
	int nTypeDamage = GetLocalInt(OBJECT_SELF, "omg_divino");
	if(nTypeDamage+GetDamageDealtByType(DAMAGE_TYPE_DIVINE) > 0) return TRUE; else return FALSE;
}
  
int lust_malditodamage()
{
	int nTypeDamage = GetLocalInt(OBJECT_SELF, "omg_maldito");
	if(nTypeDamage+GetDamageDealtByType(DAMAGE_TYPE_NEGATIVE) > 0) return TRUE; else return FALSE;
}
  
int lust_positivodamage()
{
	int nTypeDamage = GetLocalInt(OBJECT_SELF, "omg_positivo");
	if(nTypeDamage+GetDamageDealtByType(DAMAGE_TYPE_POSITIVE) > 0) return TRUE; else return FALSE;
}

int lust_negativodamage()
{
	int nTypeDamage = GetLocalInt(OBJECT_SELF, "omg_negativo");
	if(nTypeDamage+GetDamageDealtByType(DAMAGE_TYPE_NEGATIVE) > 0) return TRUE; else return FALSE;
}
  
int lust_magicodamage()
{
	int nTypeDamage = GetLocalInt(OBJECT_SELF, "omg_magico");
	if(nTypeDamage+GetDamageDealtByType(DAMAGE_TYPE_MAGICAL) > 0) return TRUE; else return FALSE;
}
  
int lust_acidodamage()
{
	int nTypeDamage = GetLocalInt(OBJECT_SELF, "omg_acido");
	if(nTypeDamage+GetDamageDealtByType(DAMAGE_TYPE_ACID) > 0) return TRUE; else return FALSE;
}
  
int lust_fantasmadamage()
{
	int nTypeDamage = GetLocalInt(OBJECT_SELF, "omg_fantasma");
	if(nTypeDamage+GetDamageDealtByType(DAMAGE_TYPE_SONIC) > 0) return TRUE; else return FALSE;
}
  
int lust_transmutadodamage()
{
	int nTypeDamage = GetLocalInt(OBJECT_SELF, "omg_transmutado");
	if(nTypeDamage+GetDamageDealtByType(DAMAGE_TYPE_ALL) > 0) return TRUE; else return FALSE;
}
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//This function switches between on and off.
//--------------------------------------------------------------------------------
//Written by Esteban Manuel; Date: 01-12-2011 [DDMMYYYY]
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
void lust_switch(object oTarget)
{
	lust_initialize(oTarget);
	if (GetLocalInt(oTarget,"Active")==0){
		lust_createfxandlight(oTarget);
		//lust_playsound(oTarget);
		//lust_continuesound(oTarget);
	}else{
		lust_destroyfxandlight(oTarget);
	}
	SetLocalInt(oTarget,"looping" ,3);
}
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//This function switches between on and off when using the strength.
//--------------------------------------------------------------------------------
//Written by Esteban Manuel; Date: 01-12-2011 [DDMMYYYY]
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
void lust_switch_ondamage(object oTarget)
{
	lust_initialize(oTarget);
	if (GetLocalInt(oTarget,"Active")==0)
	{
		if((lust_fuegodamage())||(lust_magicodamage()))
		{
			AssignCommand(oTarget,SpeakString(GetLocalString(oTarget,"MSG_Activate"),TALKVOLUME_TALK));
			lust_switch(OBJECT_SELF);
		}
		else AssignCommand(oTarget,SpeakString(GetLocalString(oTarget,"MSG_Error"),TALKVOLUME_TALK));
	} else{
		if((lust_fuegodamage()==0)&&(lust_magicodamage())==0)
		{
			lust_switch(OBJECT_SELF);
			AssignCommand(oTarget,SpeakString(GetLocalString(oTarget,"MSG_Deactivate"),TALKVOLUME_TALK));
		}
	}
	lust_heal(oTarget);
}
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//This function switches between on and off when using a FLINT or Torch.
//--------------------------------------------------------------------------------
//Written by Esteban Manuel; Date: 01-12-2011 [DDMMYYYY]
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
void lust_switch_onuse(object oTarget)
{
	lust_initialize(OBJECT_SELF);
	if(GetLocalInt(OBJECT_SELF,"Active")==0)
	{
		if ((lust_IsTorchEquipped(OBJECT_SELF))||(lust_HasEnlightItem(0,OBJECT_SELF)))
		{
			AssignCommand(oTarget,SpeakString(GetLocalString(oTarget,"MSG_Activate"),TALKVOLUME_TALK));
			lust_switch(OBJECT_SELF);
		}
		else AssignCommand(oTarget,SpeakString("You cannot light this torch." ,TALKVOLUME_TALK));
	} else {
		lust_switch(OBJECT_SELF);
		AssignCommand(oTarget,SpeakString(GetLocalString(oTarget,"MSG_Deactivate"),TALKVOLUME_TALK));
	}
}
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//This function switches to off when it's destroyed.
//--------------------------------------------------------------------------------
//Written by Esteban Manuel; Date: 01-12-2011 [DDMMYYYY]
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
void lust_switch_ondeath(object oTarget)
{
	lust_initialize(OBJECT_SELF);
	if(GetLocalInt(OBJECT_SELF,"Active")==1)
	{
		lust_switch(OBJECT_SELF);
	}
	AssignCommand(oTarget,SpeakString(GetLocalString(oTarget,"MSG_Death"),TALKVOLUME_TALK));
}
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//This function returns TRUE at the begining and after every full lap.
//--------------------------------------------------------------------------------
//Written by Esteban Manuel; Date: 01-12-2011 [DDMMYYYY]
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
int lust_heartbeatlooping(object oTarget, int loops)
{
//		AssignCommand(oTarget,SpeakString("Makes a loop: #"+IntToString(GetLocalInt(oTarget,"looping")),TALKVOLUME_TALK));
		if (GetLocalInt(oTarget,"looping")<=loops)
		{
			SetLocalInt(oTarget,"looping",GetLocalInt(oTarget,"looping")+1);
		}else{
			SetLocalInt(oTarget,"looping",0);
		}
		if (GetLocalInt(oTarget,"looping")==1) return TRUE; else return FALSE;
}
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//This function switches to on based on a random chance it can be used on the
//onheartbeat event because it only is runned one time.
//--------------------------------------------------------------------------------
//Written by Esteban Manuel; Date: 01-12-2011 [DDMMYYYY]
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
/*void lust_swith_onspawn(object oTarget)
{
	if (GetLocalInt(oTarget, "Initialized")==0)
	{
		lust_initialize(oTarget);
		if (Random(100)<GetLocalInt(oTarget,"LitChances" ))
		{
			lust_switch(oTarget);
		}
	}
}*/
//------------------------------------------------------------------------------//

 /////////////////////////////////////////////////////////////////////////////////
//It will change to lit on night, and off on day.
//--------------------------------------------------------------------------------
//Written by Esteban Manuel; Date: 01-12-2011 [DDMMYYYY]
//Webpage: www.lustabel.eu
//--------------------------------------------------------------------------------
/*void lust_switch_onheartbeat(object oTarget, int heartbeats)
{
	int iHour = GetTimeHour();
	int iIsDay;
	if ((iHour>5)&&(iHour<18)) iIsDay = 1; else iIsDay = 0;

	lust_swith_onspawn(oTarget);
	if (lust_heartbeatlooping(oTarget,heartbeats)==TRUE)
	{
		if(GetLocalInt(oTarget,"NigthAndDay")>=1)
		{
			if(!iIsDay) if(GetLocalInt(OBJECT_SELF,"Active")==0) lust_switch(oTarget);
			if( iIsDay) if(GetLocalInt(OBJECT_SELF,"Active")==1) lust_switch(oTarget);
		}
	}
}*/
//------------------------------------------------------------------------------//