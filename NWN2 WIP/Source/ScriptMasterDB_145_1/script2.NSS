/*
Do 2d8 damage on PC inside trigger.
*/

void main()
{
	// Create the effect to apply
    effect eDamage = EffectDamage((Random(8)+Random(8)), DAMAGE_TYPE_FIRE);

    // Create the visual portion of the effect.
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
	
	// Loop all objects in us, an area
	object oArea = OBJECT_SELF;
    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject))
    {
     	if (GetIsPC(oObject) && GetLocalInt(oObject, "alex_fire_damage")!=0) 
		{
	    	// Apply the visual effect to the target
    		ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oObject);
    		// Apply the effect to the object   
    		ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oObject);
		}	
				    
         oObject = GetNextObjectInArea(oArea);
    }
}