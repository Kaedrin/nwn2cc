#include "x2_inc_itemprop"
void main()
{
	object oNPC		= OBJECT_SELF;
	float fRandomScale = Random(10)/100.00 + 0.95;
	float fScaleX = GetScale(oNPC, SCALE_X); fScaleX = fScaleX * fRandomScale; 
	float fScaleY = GetScale(oNPC, SCALE_Y); fScaleY = fScaleY * fRandomScale; 
	float fScaleZ = GetScale(oNPC, SCALE_Z); fScaleZ = fScaleZ * fRandomScale; 
	SetScale(oNPC,fScaleX,fScaleY,fScaleZ);

//	string sLocalInt;

	SetFirstName(oNPC,"<C=Red>"+RandomName()+"</C>");
	SetLastName (oNPC,"<C=Red>"+"Training dummy"+"</C>");
//	SetFirstName(oNPC,"<C=Green>"+IntToString(GetLocalInt(oNPC,sLocalInt))+"</C>");
//	SetLastName (oNPC,"<C=Green>"+RandomName()+"</C>");

}