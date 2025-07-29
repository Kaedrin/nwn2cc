/*

	Do 2d8 Fire damage to all PCs in the trigger area
	
*/

#include "spawn_main"

void DoFireDamage(object oArea)
{
	// Create the effect to apply
    effect eDamage = EffectDamage((Random(8)+Random(8)+Random(8)), DAMAGE_TYPE_FIRE);

    // Create the visual portion of the effect.
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);

	// Loop all objects in us, an area
    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject))
    {
     	if (GetIsPC(oObject) && GetLocalInt(oObject, "alex_lavafire_damage")==1) 
		{
	    	// Apply the visual effect to the target
    		ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oObject);
    		// Apply the effect to the object   
    		ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oObject);
		}	
				    
         oObject = GetNextObjectInArea(oArea);
    }
}

void main()
{
	object oArea = GetArea(OBJECT_SELF);
	//int nDoDamage = GetLocalInt(OBJECT_SELF, "alex_lavafire_damage");
	//if (nDoDamage == 2) {
	DoFireDamage(oArea);
	//ExecuteScript("alex_oldskulldepths_firedamage", OBJECT_SELF);
	//	SetLocalInt(OBJECT_SELF, "alex_lavafire_damage", 0);
	//}
	//else {
	//	SetLocalInt(OBJECT_SELF, "alex_lavafire_damage", nDoDamage + 1);
	//}
	Spawn();
}