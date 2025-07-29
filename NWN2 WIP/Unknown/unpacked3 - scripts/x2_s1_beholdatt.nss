//::///////////////////////////////////////////////
//:: x2_s1_beholdatt
//:: Beholder Attack Spell Logic
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*

    This spellscript is the core of the beholder's
    attack logic.

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-08-28
//:://////////////////////////////////////////////


#include "x2_inc_beholder"



void main()
{
    int nApp = GetLocalInt(OBJECT_SELF,"beholder_mage");
    object oTarget = GetSpellTargetObject();
    // Only if we are beholders and not beholder mages
 /*
    //* GZ: cut whole immunity thing because it was causing too much trouble
     if (nApp == 472 ||nApp == 401 || nApp == 403)
    {
        CloseAntiMagicEye(oTarget);
    }
  */

    // need that to make them not drop out of combat
    SignalEvent(oTarget,EventSpellCastAt(OBJECT_SELF,GetSpellId()));

    struct beholder_target_struct stTargets = GetRayTargets(oTarget);
    int nRay;
    int nOdd;
	int nRacial = GetRacialType(oTarget);
    if (stTargets.nCount ==0)
    {
        //emergency fallback
            BehDoFireBeam(BEHOLDER_RAY_SLOW,stTargets.oTarget1);
            BehDoFireBeam(BEHOLDER_RAY_DEATH,stTargets.oTarget1);
            BehDoFireBeam(BEHOLDER_RAY_FEAR,stTargets.oTarget1);
            BehDoFireBeam(BEHOLDER_RAY_TK,stTargets.oTarget1);
    }
    else if (stTargets.nCount ==1) // AI for only one target
    {
        nOdd=d4();
        if (nOdd == 1)
        {
            BehDoFireBeam(BEHOLDER_RAY_SLOW,stTargets.oTarget1);
            BehDoFireBeam(BEHOLDER_RAY_DISINTIGRATE,stTargets.oTarget1);
            if (d2()==1)
                BehDoFireBeam(BEHOLDER_RAY_FEAR,stTargets.oTarget1);
        }
        if (nOdd == 2)
        {
            BehDoFireBeam(BEHOLDER_RAY_DEATH,stTargets.oTarget1);
            BehDoFireBeam(BEHOLDER_RAY_TK,stTargets.oTarget1);
            if (d2()==1)
                BehDoFireBeam(BEHOLDER_RAY_WOUND,stTargets.oTarget1);
        }
		if (nOdd == 3)
        {	
				BehDoFireBeam(BEHOLDER_RAY_WOUND,stTargets.oTarget1);
				BehDoFireBeam(BEHOLDER_RAY_DEATH,stTargets.oTarget1);
				if (d2()==1)
            		BehDoFireBeam(BEHOLDER_RAY_SLEEP,stTargets.oTarget1);
        }
		if (nOdd == 4)
        {
            BehDoFireBeam(BEHOLDER_RAY_PETRI,stTargets.oTarget1);
            BehDoFireBeam(BEHOLDER_RAY_DISINTIGRATE,stTargets.oTarget1);
            if (d2()==1)
                BehDoFireBeam(BEHOLDER_RAY_SLOW,stTargets.oTarget1);
        }
        if (d3()==1)
        {
            BehDoFireBeam(BEHOLDER_RAY_CHARM_MONSTER,stTargets.oTarget2);
			BehDoFireBeam(BEHOLDER_RAY_SLEEP,stTargets.oTarget2);
        }
    }
    else if (stTargets.nCount ==2)
    {
        if (nOdd)
        {
            BehDoFireBeam(BEHOLDER_RAY_DISINTIGRATE,stTargets.oTarget1);
            BehDoFireBeam(BEHOLDER_RAY_SLOW,stTargets.oTarget1);
            BehDoFireBeam(BEHOLDER_RAY_FEAR,stTargets.oTarget1);
            BehDoFireBeam(BEHOLDER_RAY_WOUND,stTargets.oTarget2);
            BehDoFireBeam(BEHOLDER_RAY_TK,stTargets.oTarget2);
            if (d2()==1)
                BehDoFireBeam(BEHOLDER_RAY_PETRI,stTargets.oTarget2);
            BehDoFireBeam(BEHOLDER_RAY_DEATH,stTargets.oTarget2);
        }
        else
        {
            BehDoFireBeam(BEHOLDER_RAY_WOUND,stTargets.oTarget1);
            BehDoFireBeam(BEHOLDER_RAY_TK,stTargets.oTarget1);
            if (d2()==1)
                BehDoFireBeam(BEHOLDER_RAY_DISINTIGRATE,stTargets.oTarget1);
            BehDoFireBeam(BEHOLDER_RAY_SLEEP,stTargets.oTarget2);
            BehDoFireBeam(BEHOLDER_RAY_SLOW,stTargets.oTarget2);
            BehDoFireBeam(BEHOLDER_RAY_FEAR,stTargets.oTarget2);
        }
		if (d3()==1)
        {
            BehDoFireBeam(BEHOLDER_RAY_CHARM_MONSTER,stTargets.oTarget3);
			BehDoFireBeam(BEHOLDER_RAY_SLEEP,stTargets.oTarget3);
        }
    }
    else if (stTargets.nCount ==3)
    {
       if (nOdd)
       {
            BehDoFireBeam(BEHOLDER_RAY_DISINTIGRATE,stTargets.oTarget1);
            BehDoFireBeam(BEHOLDER_RAY_DEATH,stTargets.oTarget1);
			BehDoFireBeam(BEHOLDER_RAY_FEAR,stTargets.oTarget1);
			BehDoFireBeam(BEHOLDER_RAY_CHARM_MONSTER,stTargets.oTarget2);
            BehDoFireBeam(BEHOLDER_RAY_SLEEP,stTargets.oTarget2);
			BehDoFireBeam(BEHOLDER_RAY_WOUND,stTargets.oTarget2);
            BehDoFireBeam(BEHOLDER_RAY_TK,stTargets.oTarget3);
            BehDoFireBeam(BEHOLDER_RAY_PETRI,stTargets.oTarget3);
       }
       else
       {
            BehDoFireBeam(BEHOLDER_RAY_DEATH,stTargets.oTarget2);
			BehDoFireBeam(BEHOLDER_RAY_DISINTIGRATE,stTargets.oTarget1);
			BehDoFireBeam(BEHOLDER_RAY_SLEEP,stTargets.oTarget3);
            BehDoFireBeam(BEHOLDER_RAY_SLOW,stTargets.oTarget2);
            BehDoFireBeam(BEHOLDER_RAY_FEAR,stTargets.oTarget1);
            BehDoFireBeam(BEHOLDER_RAY_WOUND,stTargets.oTarget2);
            BehDoFireBeam(BEHOLDER_RAY_TK,stTargets.oTarget1);
            BehDoFireBeam(BEHOLDER_RAY_PETRI,stTargets.oTarget3);
			BehDoFireBeam(BEHOLDER_RAY_CHARM_MONSTER,stTargets.oTarget3);
       }
    }




    // Only if we are beholders and not beholder mages
    if (nApp != 1)
    {
        OpenAntiMagicEye(oTarget);
    }
}



/*



*/