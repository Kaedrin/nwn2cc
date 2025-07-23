//::
//:: Created by Reeron on 1-24-08
//:: 
//:: Work-around for items losing their Spell Resistance on the first spell hit.
//:: 



//Calculate Spell Resistance bonuses on equipment
int EquipCalculateSRBonuses(object oPC, object oItem)
{
    effect eEffect = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEffect))
        {
        //if (eEffect== )
            {
            if(GetEffectType(eEffect) == EFFECT_TYPE_SPELL_RESISTANCE_INCREASE)
                {
                if(GetEffectSubType(eEffect) == SUBTYPE_SUPERNATURAL) // set to supernatural so spell effects
                                                                      // don't have their bonuses removed.
                    {
                    RemoveEffect(oPC, eEffect);
                    }
                }
            //RemoveEffect(oPC, eEffect);
            }
        eEffect = GetNextEffect(oPC);
        }

    int nSR=0;
    int nSR2;
    object oItem2;
    int nBonus = 0;
    int nBonus2;
    int nCrap;
    int nCrap2;
    //iterate through equipped items and get bonus	
    int n;
    for(n = 0; n < NUM_INVENTORY_SLOTS; n++)
    {
        oItem2 = GetItemInSlot(n, oPC);
        //if(oItem2==oItem) continue; //skip
        //SendMessageToPC(GetFirstPC(), "inside loop for n...");
        if(GetIsObjectValid(oItem2))
        {
        //SendMessageToPC(GetFirstPC(), "inside loop for a valid object...");
        itemproperty iProp = GetFirstItemProperty(oItem2);
        while (GetIsItemPropertyValid(iProp))
            {
            nCrap = GetItemPropertyCostTable(iProp);
            //SendMessageToPC(GetFirstPC(), "ItemPropertyCostTable = "+IntToString(nCrap));
            nCrap2 = GetItemPropertyCostTableValue(iProp);
            if (nCrap == 11) // Spell Resistance on creature hide.
                {
                //SendMessageToPC(GetFirstPC(), "ItemPropertyCostTable = 11 means SR");
                string nSRValue = Get2DAString("iprp_srcost", "Value", nCrap2);
                nSR = StringToInt(nSRValue);
                //int nSRValue = Get2DAString("iprp_srcost", "Value", nCrap2);
                //SendMessageToPC(GetFirstPC(), "SR = "+(nSRValue));
                }
            if (nSR2 < nSR)
                {
                nSR2 = nSR;
                }

            iProp = GetNextItemProperty(oItem2);
            }

        }
        
    }
    if (nSR2 > 0)
        {
        effect eSR2 = EffectSpellResistanceIncrease(nSR2, -1);
        eSR2 = SupernaturalEffect(eSR2);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSR2, oPC);
        //SendMessageToPC(GetFirstPC(), "SR applied = "+IntToString(nSR2));
        }
        
	//SendMessageToPC(GetFirstPC(), "SR is: " + IntToString(nSR2));
	
	return nBonus2;
}


int UnequipCalculateSRBonuses(object oPC, object oItem)
{
    effect eEffect = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEffect))
        {
        //if (eEffect== )
            {
            if(GetEffectType(eEffect) == EFFECT_TYPE_SPELL_RESISTANCE_INCREASE)
                {
                if(GetEffectSubType(eEffect) == SUBTYPE_SUPERNATURAL) // set to supernatural so spell effects
                                                                      // don't have their bonuses removed.
                    {
                    RemoveEffect(oPC, eEffect);
                    }
                }
            //RemoveEffect(oPC, eEffect);
            }
        eEffect = GetNextEffect(oPC);
        }
    
    
    
    
    
    
    
    int nSR=0;
    int nSR2;
    object oItem2;
    int nBonus = 0;
    int nBonus2;
    int nCrap;
    int nCrap2;
    //iterate through equipped items and get bonus	
    int n;
    for(n = 0; n < NUM_INVENTORY_SLOTS; n++)
    {
        oItem2 = GetItemInSlot(n, oPC);
        if(oItem2==oItem) continue; //skip
        //SendMessageToPC(GetFirstPC(), "inside loop for n...");
        if(GetIsObjectValid(oItem2))
        {
        //SendMessageToPC(GetFirstPC(), "inside loop for a valid object...");
        itemproperty iProp = GetFirstItemProperty(oItem2);
        while (GetIsItemPropertyValid(iProp))
            {
            nCrap = GetItemPropertyCostTable(iProp);
            //SendMessageToPC(GetFirstPC(), "ItemPropertyCostTable = "+IntToString(nCrap));
            nCrap2 = GetItemPropertyCostTableValue(iProp);
            if (nCrap == 11) // Spell Resistance on creature hide.
                {
                //SendMessageToPC(GetFirstPC(), "ItemPropertyCostTable = 11 means SR");
                string nSRValue = Get2DAString("iprp_srcost", "Value", nCrap2);
                nSR = StringToInt(nSRValue);
                //int nSRValue = Get2DAString("iprp_srcost", "Value", nCrap2);
                //SendMessageToPC(GetFirstPC(), "SR = "+(nSRValue));
                }
            if (nSR2 < nSR)
                {
                nSR2 = nSR;
                }

            iProp = GetNextItemProperty(oItem2);
            }

        }
        
    }
    if (nSR2 > 0)
        {
        effect eSR2 = EffectSpellResistanceIncrease(nSR2, -1);
        eSR2 = SupernaturalEffect(eSR2);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSR2, oPC);
        //SendMessageToPC(GetFirstPC(), "SR applied = "+IntToString(nSR2));
        }
        
	//SendMessageToPC(GetFirstPC(), "SR is: " + IntToString(nSR2));
	
	return nBonus2;
}