#include "ipi_constants"
#include "ipi_defaults"
#include "pf_facade"

void main()
{
    string sInnPrefix = GetStringRight(GetTag(OBJECT_SELF),2);
    object myInn = GetObjectByTag(sPREFIX + sInnPrefix);
    int roomNum = GetLocalInt(OBJECT_SELF, CURRENTROOM_VAR);
    // Give any refund
    int refund = GetLocalInt(OBJECT_SELF, REFUNDAMOUNT_VAR);
    if (refund > 0 && refund < 200) GiveGoldToCreature(GetPCSpeaker(), refund);
	if (refund >= 200) GiveGoldToCreature(GetPCSpeaker(), 200);

    // Remove the relevant varables
    string sTenantVar = "Rm" + IntToStringPad3(roomNum) + "Tenant";
    string sExpireVar = "Rm" + IntToStringPad3(roomNum) + "Expire";
    DeletePFCampaignVariable(sCampaignName, sTenantVar, myInn);
    DeletePFCampaignVariable(sCampaignName, sExpireVar, myInn);

    string msg = "Expiring contract for "+ GetName(GetPCSpeaker()) +
        " on room " + IntToString(roomNum);
    WriteTimestampedLogEntry(msg);

}