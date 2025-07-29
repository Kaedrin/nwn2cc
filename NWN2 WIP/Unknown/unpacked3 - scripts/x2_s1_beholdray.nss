//::///////////////////////////////////////////////
//:: Beholder Ray Attacks
//:: x2_s2_beholdray
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Implementation for the new version of the
    beholder rays, using projectiles instead of
    rays
*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-16
//:://////////////////////////////////////////////


#include "x0_i0_spells"


void DoBeholderPetrify(int nDuration,object oSource, object oTarget, int nSpellID);

void main()
{

    int     nSpell = GetSpellId();
    object  oTarget = GetSpellTargetObject();
	int     nRacial = GetRacialType(oTarget);
    int     nSave, bSave;
    int     nSaveDC = GetLocalInt(OBJECT_SELF, "saveDC");// = 17;
	int 	nHD = GetHitDice(OBJECT_SELF);
    float   fDelay;
    effect  e1, eLink, eVis, eDur, eBeam;


    switch (nSpell)
    {
         case 776 :
                                  nSave = SAVING_THROW_FORT;      //BEHOLDER_RAY_DEATH
                                  break;

        case  777:
                                  nSave = SAVING_THROW_WILL;     //BEHOLDER_RAY_TK
                                  break;

        case 778 :                                              //BEHOLDER_RAY_PETRI
                                  nSave = SAVING_THROW_FORT;
                                  break;

        case 779:                                                   // BEHOLDER_RAY_CHARM_MONSTER
                                  nSave = SAVING_THROW_WILL;
                                  break;

        case 780:                                                   //BEHOLDER_RAY_SLOW
                                  nSave = SAVING_THROW_WILL;
                                  break;

       case 783:
                                  nSave = SAVING_THROW_FORT;        //BEHOLDER_RAY_WOUND
                                  break;

       case 784:                                                    // BEHOLDER_RAY_FEAR
                                  nSave = SAVING_THROW_WILL;
                                  break;

       case 785:				  nSave = SAVING_THROW_WILL;        //charm person
                                  break;
								  
       case 786:                  nSave = SAVING_THROW_WILL;        //sleep
                                  break;
								  
       case 787:                  nSave = SAVING_THROW_FORT;        //distintegrate
                                  break;
    }

    SignalEvent(oTarget,EventSpellCastAt(OBJECT_SELF,GetSpellId(),TRUE));
    fDelay  = 0.0f;  //old -- GetSpellEffectDelay(GetLocation(oTarget),OBJECT_SELF);
	
	if (nSpell == 785)
	{
		if  ((nRacial == RACIAL_TYPE_DWARF) ||
              (nRacial == RACIAL_TYPE_ELF) ||
              (nRacial == RACIAL_TYPE_GNOME) ||
              (nRacial == RACIAL_TYPE_HUMANOID_GOBLINOID) ||
              (nRacial == RACIAL_TYPE_HALFLING) ||
              (nRacial == RACIAL_TYPE_HUMAN) ||
              (nRacial == RACIAL_TYPE_HALFELF) ||
              (nRacial == RACIAL_TYPE_HALFORC) ||
              (nRacial == RACIAL_TYPE_HUMANOID_MONSTROUS) ||
              (nRacial == RACIAL_TYPE_HUMANOID_ORC) ||
              (nRacial == RACIAL_TYPE_HUMANOID_REPTILIAN))
		{
			if (nSave == SAVING_THROW_WILL)
    		{
        		bSave = WillSave(oTarget, nSaveDC, SAVING_THROW_TYPE_NONE);
    		}
    		else if (nSave == SAVING_THROW_FORT)
    		{
     			bSave = FortitudeSave(oTarget, nSaveDC, SAVING_THROW_TYPE_NONE);
    		}
		}
		else
		{
			bSave = SAVING_THROW_CHECK_IMMUNE;
		}
	}
    else
	{
	if (nSave == SAVING_THROW_WILL)
    {
        bSave = WillSave(oTarget, nSaveDC, SAVING_THROW_TYPE_NONE);
    }
    else if (nSave == SAVING_THROW_FORT)
    {
      bSave = FortitudeSave(oTarget, nSaveDC, SAVING_THROW_TYPE_NONE);
    }
	}

    if (bSave == SAVING_THROW_CHECK_FAILED)
    {

      switch (nSpell)
      {
         case 776:                 e1 = EffectDeath(TRUE);
                                   eVis = EffectVisualEffect(VFX_HIT_SPELL_NECROMANCY);
                                   eLink = EffectLinkEffects(e1,eVis);
                                   ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget);
								   eBeam = EffectBeam(5007, OBJECT_SELF, BODY_NODE_MONSTER_0, FALSE);
								   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;

          case 777:                e1 = ExtraordinaryEffect(EffectKnockdown());
                                   eVis = EffectVisualEffect(VFX_HIT_SPELL_BALAGARN_IRON_HORN);
                                   ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                                   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,e1,oTarget,6.0f);
								   eBeam = EffectBeam(5006, OBJECT_SELF, BODY_NODE_MONSTER_1, FALSE);
								   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;

          // Petrify for one round per SaveDC
          case 778:                eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
                                   ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                                   DoBeholderPetrify(nSaveDC,OBJECT_SELF,oTarget,GetSpellId());
								   eBeam = EffectBeam(5008, OBJECT_SELF, BODY_NODE_MONSTER_2, FALSE);
								   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;


          case 779:                e1 = EffectCharmed();
		  				 		   eLink = EffectVisualEffect(VFX_DUR_SPELL_CHARM_MONSTER);
								   eLink = EffectLinkEffects(e1, eLink);
								   eLink = SupernaturalEffect(eLink);
                                   eVis = EffectVisualEffect(VFX_HIT_SPELL_ENCHANTMENT);
                                   ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                                   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,24.0f);
								   eBeam = EffectBeam(5001, OBJECT_SELF, BODY_NODE_MONSTER_3, FALSE);
								   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;


          case 780:                e1 = EffectSlow();
                                   eLink = EffectVisualEffect(VFX_DUR_SPELL_SLOW);
								   eLink = EffectLinkEffects(e1, eLink);
								   eVis = EffectVisualEffect(VFX_HIT_SPELL_TRANSMUTATION);
                                   ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                                   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,RoundsToSeconds(6));
								   eBeam = EffectBeam(5003, OBJECT_SELF, BODY_NODE_MONSTER_4, FALSE);
								   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;

          case 783:                e1 = EffectDamage(d8(2)+10);
                                   eVis = EffectVisualEffect(VFX_HIT_SPELL_INFLICT_6);
                                   ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                                   ApplyEffectToObject(DURATION_TYPE_INSTANT,e1,oTarget);
								   eBeam = EffectBeam(5002, OBJECT_SELF, BODY_NODE_MONSTER_5, FALSE);
								   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;


          case 784:
                                   e1 = EffectFrightened();
                                   eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
                                   eDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
                                   e1 = EffectLinkEffects(eDur,e1);
                                   ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                                   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,e1,oTarget,RoundsToSeconds(1+d4()));
								   eBeam = EffectBeam(5004, OBJECT_SELF, BODY_NODE_MONSTER_6, FALSE);
								   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;
								  
		 case 785:
		 						   e1 = EffectCharmed();
		  				 		   eLink = EffectVisualEffect(VFX_DUR_SPELL_CHARM_PERSON);
								   eLink = EffectLinkEffects(e1, eLink);
								   eLink = SupernaturalEffect(eLink);
                                   eVis = EffectVisualEffect(VFX_HIT_SPELL_ENCHANTMENT);
                                   ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                                   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,24.0f);
								   eBeam = EffectBeam(5001, OBJECT_SELF, BODY_NODE_MONSTER_7, FALSE);
								   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;
										
		case 786:
		 						   e1 = ExtraordinaryEffect(EffectSleep());
		  				 		   eDur = EffectVisualEffect(VFX_DUR_SLEEP);
								   eLink = EffectLinkEffects(eDur, e1);
								   eVis = EffectVisualEffect(VFX_HIT_SPELL_ENCHANTMENT);
								   ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                                   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,RoundsToSeconds(13));
								   eBeam = EffectBeam(5005, OBJECT_SELF, BODY_NODE_MONSTER_8, FALSE);
								   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;
								   
		case 787:
		{
								   string nName = GetName(oTarget);
                					if (nName == "Mordenkainen's Sword")
                					{
                    					effect eKill = EffectDamage(GetCurrentHitPoints(oTarget),DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL,TRUE);
                    					ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget);
                    					ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDisintegrate( oTarget ), oTarget);
                    					return; 
                					}
									int nDamage = d6((nHD/3)+1);
									string sEventHandler = GetEventHandler(oTarget, CREATURE_SCRIPT_ON_DAMAGED);
									if (nDamage >= GetCurrentHitPoints(oTarget) && sEventHandler == "gb_troll_dmg")
									{
					    				SetEventHandler(oTarget,CREATURE_SCRIPT_ON_DAMAGED, SCRIPT_DEFAULT_DAMAGE);
 										SetImmortal(oTarget, FALSE);
									}
		 						   e1 = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
		  				 		   eVis = EffectVisualEffect(VFX_HIT_SPELL_TRANSMUTATION);
								   ApplyEffectToObject(DURATION_TYPE_INSTANT,e1,oTarget);
                                   ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
								   eBeam = EffectBeam(5000, OBJECT_SELF, BODY_NODE_CHEST, FALSE);
								   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;
		}								

       }

    }
    else
    {
         switch (nSpell)
         {
             case 776:			e1 = EffectDamage(d6(3)+8);
                                eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
                                eLink = EffectLinkEffects(e1,eVis);
                                ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget);
								eBeam = EffectBeam(5007, OBJECT_SELF, BODY_NODE_MONSTER_0, FALSE);
								ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
								break;
			
			case 777:              ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;

          
          case 778:                eBeam = EffectBeam(5008, OBJECT_SELF, BODY_NODE_MONSTER_2, FALSE);
								   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;


          case 779:                eBeam = EffectBeam(5001, OBJECT_SELF, BODY_NODE_MONSTER_3, FALSE);
								   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;


          case 780:                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;

          case 783:                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;


          case 784:
                                   eBeam = EffectBeam(5004, OBJECT_SELF, BODY_NODE_MONSTER_6, FALSE);
								   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;
								  
		 case 785:
		 						   eBeam = EffectBeam(5001, OBJECT_SELF, BODY_NODE_MONSTER_7, FALSE);
								   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;
										
		case 786:					eBeam = EffectBeam(5005, OBJECT_SELF, BODY_NODE_MONSTER_8, FALSE);
								   ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
                                   break;
								
			case 787:			e1 = EffectDamage(d6((nHD/3)-2), DAMAGE_TYPE_MAGICAL);
		  				 		eVis = EffectVisualEffect(VFX_HIT_SPELL_TRANSMUTATION);
								ApplyEffectToObject(DURATION_TYPE_INSTANT,e1,oTarget);
                                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
								eBeam = EffectBeam(5000, OBJECT_SELF, BODY_NODE_MONSTER_9, TRUE);
								ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
								break;
        }
    }
}



void DoBeholderPetrify(int nDuration,object oSource, object oTarget, int nSpellID)
{

    if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) && !GetIsDead(oTarget))
    {
        // * exit if creature is immune to petrification
        if (spellsIsImmuneToPetrification(oTarget) == TRUE)
        {
            return;
        }
        float fDifficulty = 0.0;
        int bIsPC = GetIsPC(oTarget);
        int bShowPopup = FALSE;

        // * calculate Duration based on difficulty settings
        int nGameDiff = GetGameDifficulty();
        switch (nGameDiff)
        {
            case GAME_DIFFICULTY_VERY_EASY:
            case GAME_DIFFICULTY_EASY:
            case GAME_DIFFICULTY_NORMAL:
                    fDifficulty = RoundsToSeconds(nDuration); // One Round per hit-die or caster level
                break;
            case GAME_DIFFICULTY_CORE_RULES:
            case GAME_DIFFICULTY_DIFFICULT:
                if (!GetPlotFlag(oTarget))
                {
                    bShowPopup = TRUE;
                }
            break;
        }

        effect ePetrify = EffectPetrify();
        effect eDur = EffectVisualEffect(VFX_DUR_SPELL_FLESH_TO_STONE);
        effect eLink = EffectLinkEffects(eDur, ePetrify);


                /// * The duration is permanent against NPCs but only temporary against PCs
                if (bIsPC == TRUE)
                {
                    if (bShowPopup == TRUE)
                    {
                        // * under hardcore rules or higher, this is an instant death
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
                        DelayCommand(2.75, PopUpDeathGUIPanel(oTarget, FALSE , TRUE, 40579));
                        // if in hardcore, treat the player as an NPC
                        bIsPC = FALSE;
                    }
                    else
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDifficulty);
                }
                else
                {
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
                    // * Feb 11 2003 BK I don't think this is necessary anymore
                    //if the target was an NPC - make him uncommandable until Stone to Flesh is cast
                    //SetCommandable(FALSE, oTarget);

                    // Feb 5 2004 - Jon
                    // Added kick-henchman-out-of-party code from generic petrify script
                    if (GetAssociateType(oTarget) == ASSOCIATE_TYPE_HENCHMAN)
                    {
                        FireHenchman(GetMaster(oTarget),oTarget);
                    }
                }
                // April 2003: Clearing actions to kick them out of conversation when petrified
                AssignCommand(oTarget, ClearAllActions());
    }
}