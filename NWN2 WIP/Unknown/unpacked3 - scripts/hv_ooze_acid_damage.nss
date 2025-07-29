/*

	Do 1 point of acid damage to all PCs in area.
	
*/

void main()
{
	// Create the effect to apply
    effect eDamage = EffectDamage(1, DAMAGE_TYPE_ACID);

    // Create the visual portion of the effect.
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);

	// Loop all objects in us, an area
    object oArea = OBJECT_SELF;
    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject))
    {
     	if (GetIsPC(oObject)) {
	    	// Apply the visual effect to the target
    		ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oObject);
    		// Apply the effect to the object   
    		ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oObject);
		}	
				    
         oObject = GetNextObjectInArea(oArea);
    }
}