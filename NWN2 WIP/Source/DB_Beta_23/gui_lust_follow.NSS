int VerifyFreeSlot(object oFollowing, string sSlot, object oMaster);
void SetFollowerAndFollowing(string sSlot ,object oFollowing, object oFollower, object oMaster);
string ApplyOnFreeSlot(int iPosition, object oFollowing, object oFollower, object oMaster);
void RemoveFollowingOnFollower(object oFollowing, object oFollower, object oMaster);
void BattleIgnoreMode(object oFollower, object oMaster);
void ChangeFollower(object oFollower, object oMaster, object oFollowing);
void DeactivateHeartbeat(object oFollower);
location GetTargetLocation(object oFollower, int iRotation = 90, float fDistance = 2.0);
void MoveToTargetLocation(object oFollower, object oMaster);
int CanSeeTheTarget(object oFollower);
void CloseGUI( object oFollower, object oMaster, object oFollowing );

string sNoEnoughtSubSlots = "<C=red>::There's not enought <C=Yellow>Free Sub-Slots</C>, try to follow a follower::</C>";
string sApplyOnFreeSlotUnkown = "<C=red>::GUI Error, <C=Yellow>ApplyOnFreeSlot</C> got an unknown <C=Yellow>iPosition</C>::</C>";
string sUnknownFollowingSlot = "<C=red>::GUI Error, has been sent an <C=yellow>Unknown Following Slot</C> on the <C=yellow>main function</C>::</C>";
string sErrorNoTarget = "<C=red>::You must choose any target to start following::</C>";
string swFront = "front";
string swBehind = "behind";
string swLeft = "left";
string swRight = "right";
string swCenter = "center";
string swShortDistance = "(from a close distance)::";
string swMediumDistance = "(from an intermediate distance)::";
string swLongDistance = "(from a long distance)::";
string swPosition = "position";
string swFollows = "follows";
string sStopFollowing = "::The following command has been stopped for";
string sStartBattleIgoreMode = "::Following in BattleIgnore Mode Initiated for";
string sEndBattleIgoreMode = "::Following in BattleIgnore Mode Finalized for";
string sHasBeenSetAsFollower= "has been set as Follower::";
string sErrorAllTheSame = "<C=red>::The Master, Follower, and Following creatures are the same::</C>";
string sErrorCircle = "<C=red>::A follower cannot be follower by it's target::</C>";
string sCantControlOther = "<C=red>::You cannot control that creature, selecting";

//*/////////////////////////////////////////////////////////////////////////////////////////////////////*//
//This is the configuration area
float fHeartBeatTimmer = 0.5; // [Recomended: 0.1 to 1.5] This is the interval used start walking, works like a fast heartbeat
float fDistanceToRun = 2.5; //[Recomended: 1.5 to 5.0] After this distance the character will run
float fMinimunDistance = 0.75; //[Recomended: 0.5 to 1.0] A character far than this distance won't feel the need of moving
int UseClassicNWN2Perception = FALSE; //TRUE will use the NWN2 spot system, FALSE will use a "is the target invisible? Can I see the invisible?"
//*/////////////////////////////////////////////////////////////////////////////////////////////////////*//


////////////////////////////////////////////////////////////////////////////////////////////////////////
///	Este script permite algo más que la capacidad de seguir a un personaje de forma automática,
///	ya que el usuario que sigue, dispone de la posibilidad de seguir a su objetivo desde una
///	posición específica, pudiendo así desarrollar formaciones de combate, o simplemente para pasear.
///
/// Si el objeto a seguir abandona el mapa, entonces la función de seguir quedará deshabilitada, por
/// lo que no habrá exploits al utilizar las nuevas funciones de seguimiento.
///
/// Si el objetivo es invisible, y si el jugador no puede ver lo invisible, entonces no podrá seguir.
///
///			2		
///	   1		 3
///	
///	 4	ToFollow   5
///	
///	   6		 7
///			7		
///
/// 0=stop, 9=battleIgnore, 10=chooseFollower, 11=CloseWindow
///
////////////////////////////////////////////////////////////////////////////////////////////////////////
void main(int iPosition)
{
	object oMaster = GetControlledCharacter(OBJECT_SELF);
	object oFollowing = GetPlayerCurrentTarget(oMaster);
	object oFollower;
	if(GetIsObjectValid(GetLocalObject(oMaster, "SetAsFollower")))
		oFollower = GetLocalObject(oMaster, "SetAsFollower");
	else
		oFollower = oMaster;
		
	if((oFollower==oFollowing)&(oFollowing!=oMaster)) //si follower va a seguir a follower y si follower no es el master
		oFollowing=oMaster;							  //entonces follower tiene que seguir al master
		
	if((GetIsObjectValid(oFollowing))||(iPosition==0)||(iPosition==9)||(iPosition==10)) //Antes de empezar hay que estar seguros de que hay objetivo
		if (!((oFollowing==oFollower)&(oFollower==oMaster)))
			switch (iPosition)
			{
				case 0:		RemoveFollowingOnFollower(oFollowing, oFollower, oMaster);	break;
				case 1:		ApplyOnFreeSlot(1, oFollowing, oFollower, oMaster);			break;
				case 2:		ApplyOnFreeSlot(2, oFollowing, oFollower, oMaster);			break;
				case 3:		ApplyOnFreeSlot(3, oFollowing, oFollower, oMaster);			break;
				case 4:		ApplyOnFreeSlot(4, oFollowing, oFollower, oMaster);			break;
				case 5:		ApplyOnFreeSlot(5, oFollowing, oFollower, oMaster);			break;
				case 6:		ApplyOnFreeSlot(6, oFollowing, oFollower, oMaster);			break;
				case 7:		ApplyOnFreeSlot(7, oFollowing, oFollower, oMaster);			break;
				case 8:		ApplyOnFreeSlot(8, oFollowing, oFollower, oMaster);			break;
				case 9:		BattleIgnoreMode( oFollower, oMaster);						break;
				case 10:	ChangeFollower( oFollower, oMaster, oFollowing ); 			break;
				case 11:	CloseGUI( oFollower, oMaster, oFollowing );		 			break;
				default:
					SendMessageToPC(oMaster, sUnknownFollowingSlot);
					break;
			}
		else
			SendMessageToPC(oMaster, sErrorAllTheSame);
	else if(iPosition==11)
		CloseGUI( oFollower, oMaster, oFollowing );
	else
		SendMessageToPC(oMaster, sErrorNoTarget);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
///En cada latido custom (definido en fHeartBeatTimmer), se da una orden de movimiento mediante la
///función MoveToTargetLocation.
////////////////////////////////////////////////////////////////////////////////////////////////////////
void DoHeartBeat(object oFollower, object oMaster)
{
	if(GetLocalInt(oFollower, "FollowHeartBeatActivated")==TRUE)
		DelayCommand(fHeartBeatTimmer, DoHeartBeat(oFollower, oMaster));
	MoveToTargetLocation(oFollower, oMaster);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
///Esta función se encarga de leer el Slot asignado anteriormente y asignarle una posición en grados
///y en distancia. También se encarga de dar la orden de movimiento hasta la posición necesaria.
////////////////////////////////////////////////////////////////////////////////////////////////////////
void MoveToTargetLocation(object oFollower, object oMaster)
{
	location lTargetLocation;
	string sSlot = GetLocalString(oFollower, "sFollowingSlot");
	
	/*Aquí irá la serie de IF haciendo de "Case"*/
	if(sSlot=="FSlot_5")        lTargetLocation = GetTargetLocation(oFollower, 90, 2.0);
	else if(sSlot=="FSlot_5-a") lTargetLocation = GetTargetLocation(oFollower, 90, 4.0);
	else if(sSlot=="FSlot_5-b") lTargetLocation = GetTargetLocation(oFollower, 90, 6.0);
	else if(sSlot=="FSlot_4")   lTargetLocation = GetTargetLocation(oFollower, 270, 2.0);
	else if(sSlot=="FSlot_4-a") lTargetLocation = GetTargetLocation(oFollower, 270, 4.0);
	else if(sSlot=="FSlot_4-b") lTargetLocation = GetTargetLocation(oFollower, 270, 6.0);
	else if(sSlot=="FSlot_7")   lTargetLocation = GetTargetLocation(oFollower, 0, 2.0);
	else if(sSlot=="FSlot_7-a") lTargetLocation = GetTargetLocation(oFollower, 0, 4.0); 
	else if(sSlot=="FSlot_7-b") lTargetLocation = GetTargetLocation(oFollower, 0, 6.0);
	else if(sSlot=="FSlot_2")  lTargetLocation = GetTargetLocation(oFollower, 180, 2.0);
	else if(sSlot=="FSlot_2-a") lTargetLocation = GetTargetLocation(oFollower, 180, 4.0);
	else if(sSlot=="FSlot_2-b") lTargetLocation = GetTargetLocation(oFollower, 180, 6.0);
	
	else if(sSlot=="FSlot_1")   lTargetLocation = GetTargetLocation(oFollower, 225, 3.0); //For circular use 2.0
	else if(sSlot=="FSlot_1-a") lTargetLocation = GetTargetLocation(oFollower, 225, 6.0); //For circular use 4.0
	else if(sSlot=="FSlot_1-b") lTargetLocation = GetTargetLocation(oFollower, 225, 9.0); //For circular use 6.0
	else if(sSlot=="FSlot_3")   lTargetLocation = GetTargetLocation(oFollower, 135, 3.0); //For circular use 2.0
	else if(sSlot=="FSlot_3-a") lTargetLocation = GetTargetLocation(oFollower, 135, 6.0); //For circular use 4.0
	else if(sSlot=="FSlot_3-b") lTargetLocation = GetTargetLocation(oFollower, 135, 9.0); //For circular use 6.0
	
	else if(sSlot=="FSlot_8")   lTargetLocation = GetTargetLocation(oFollower, 45, 3.0); //For circular use 2.0
	else if(sSlot=="FSlot_8-a") lTargetLocation = GetTargetLocation(oFollower, 45, 6.0); //For circular use 4.0
	else if(sSlot=="FSlot_8-b") lTargetLocation = GetTargetLocation(oFollower, 45, 9.0); //For circular use 6.0
	else if(sSlot=="FSlot_6")   lTargetLocation = GetTargetLocation(oFollower, 315, 3.0); //For circular use 2.0
	else if(sSlot=="FSlot_6-a") lTargetLocation = GetTargetLocation(oFollower, 315, 6.0); //For circular use 4.0
	else if(sSlot=="FSlot_6-b") lTargetLocation = GetTargetLocation(oFollower, 315, 9.0); //For circular use 6.0
	
	float fDistanceBetween = GetDistanceBetweenLocations(GetLocation(oFollower), lTargetLocation);
	if ( ((fDistanceBetween>0.0)&((!GetIsInCombat(oFollower))|(GetLocalInt(oFollower, "FollowingBattleIgnore"))))&(CanSeeTheTarget(oFollower)) )
	{
		AssignCommand(oFollower , ClearAllActions(FALSE));
		if((fDistanceBetween<fDistanceToRun)&(fDistanceBetween>fMinimunDistance))
			AssignCommand(oFollower , ActionMoveToLocation(lTargetLocation, FALSE));
		else if(fDistanceBetween>=fDistanceToRun)
			AssignCommand(oFollower , ActionMoveToLocation(lTargetLocation, TRUE));
		AssignCommand(oFollower, SetFacing(GetFacing(GetLocalObject(oFollower, "oFollowingTarget"))));
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
///Esta función realiza las tareas de cálculo para hayar la ubicación a la que deberá dirigirse el
///follower.
////////////////////////////////////////////////////////////////////////////////////////////////////////
location GetTargetLocation(object oFollower, int iRotation = 90, float fDistance = 2.0)
{
	location lResult = GetLocation(oFollower);
	if(GetIsObjectValid(GetLocalObject(oFollower, "oFollowingTarget")))
	{
		object oFollowing = GetLocalObject(oFollower, "oFollowingTarget");
		location lLocationTarget = GetLocation(oFollowing);
		float facing = GetFacing(oFollowing)+iRotation;
		float reverse = IntToFloat(FloatToInt(facing + 180.0f) % 360);
		vector Posicion = GetPositionFromLocation(lLocationTarget);
		Posicion.x += fDistance * cos(reverse);
		Posicion.y += fDistance * sin(reverse);
		Posicion.z += 1.0;
		lResult = Location(GetArea(oFollower), Posicion, facing);
	}
	return lResult;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
///Esta función detiene completamente la orden de seguir a un objetivo, es el Stop.
////////////////////////////////////////////////////////////////////////////////////////////////////////
void RemoveFollowingOnFollower(object oFollowing, object oFollower, object oMaster)
{
	DeleteLocalString(oFollower, "sFollowingSlot");
	DeleteLocalObject(oFollower, "oFollowingTarget");
	SendMessageToPC(oMaster, sStopFollowing+" <C=Green>"+GetFirstName(oFollower)+"</C>::");
	DeactivateHeartbeat(oFollower);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
///Cierra la interfaz GUI de seguimiento y lo detiene.
////////////////////////////////////////////////////////////////////////////////////////////////////////
void CloseGUI( object oFollower, object oMaster, object oFollowing )
{
	RemoveFollowingOnFollower(oFollowing, oFollower, oMaster);
	CloseGUIScreen(oMaster, "lustabel_follow");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
///Alterna el Battle Ignore Mode, cuando se activa, el Follower pasa a ignorar el combate, recibiendo
///constantemente órdenes de mantener la formación, las cuales deseará con todas sus fuerzas evitar.
///Este modo no es muy querido por los NPCs.
////////////////////////////////////////////////////////////////////////////////////////////////////////
void BattleIgnoreMode(object oFollower, object oMaster)
{
	if(GetLocalInt(oFollower, "FollowingBattleIgnore")==FALSE) {
		SetLocalInt(oFollower, "FollowingBattleIgnore", TRUE);
		SendMessageToPC(oMaster, sStartBattleIgoreMode+" <C=Green>"+GetFirstName(oFollower)+"</C>::");
	} else {
		SetLocalInt(oFollower, "FollowingBattleIgnore", FALSE);
		SendMessageToPC(oMaster, sEndBattleIgoreMode+" <C=Green>"+GetFirstName(oFollower)+"</C>::");
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
///Esta función es la que se utiliza para hacer que un objeto diferente del Personaje principal pueda
///recibir órdenes, en principio esto deberá ser utilizado únicamente por DMs.
////////////////////////////////////////////////////////////////////////////////////////////////////////
void ChangeFollower(object oFollower, object oMaster, object oFollowing)
{
	if((GetIsObjectValid(oFollowing))&((oMaster==oFollowing)|(GetMaster(oFollowing)==oMaster)|(GetIsDM(oMaster))|(GetIsDMPossessed(oMaster)))){
		SetLocalObject(oMaster, "SetAsFollower", oFollowing);
		SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(GetLocalObject(oMaster, "SetAsFollower"))+"</C> "+sHasBeenSetAsFollower);
		SetGUIObjectText(oMaster, "lustabel_follow", "FollowerName", -1, GetFirstName(GetLocalObject(oMaster, "SetAsFollower")));
	}
	else{
		DeleteLocalObject(oMaster, "SetAsFollower");
		if((!GetIsOwnedByPlayer(oFollowing))&(!GetIsDM(oMaster))){
			SendMessageToPC(oMaster, sCantControlOther+" "+GetFirstName(oMaster)+"::</C></C>");
			SetGUIObjectText(oMaster, "lustabel_follow", "FollowerName", -1, "DB Following GUI");
		}else
			SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oMaster)+"</C> "+sHasBeenSetAsFollower);
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
///Este es el que activa el Heartbeat sólo una vez, sin cascadas de sobrecargas ni tonterías
////////////////////////////////////////////////////////////////////////////////////////////////////////
void ActivateHeartbeat(object oFollower, object oMaster) 
{
	if(GetLocalInt(oFollower, "FollowHeartBeatActivated")==FALSE){
		SetLocalInt(oFollower, "FollowHeartBeatActivated", TRUE);
		DoHeartBeat(oFollower, oMaster);
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
///Desactiva el sistema de Heartbeat para ahorrar recursos
////////////////////////////////////////////////////////////////////////////////////////////////////////
void DeactivateHeartbeat(object oFollower)
{
	if(GetLocalInt(oFollower, "FollowHeartBeatActivated")==TRUE){
		SetLocalInt(oFollower, "FollowHeartBeatActivated", FALSE);
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
///Esta función evalúa el slot a utilizar y llama directamente a SetFollowerAndFollowing para que los
///guarde.
////////////////////////////////////////////////////////////////////////////////////////////////////////
void ApplyOnFreeSlot(int iPosition, object oFollowing, object oFollower, object oMaster)
{
	if(GetLocalObject(oFollowing, "oFollowingTarget")!=oFollower) //Damos permiso a seguir en el caso de que no se intente hacer una redundancia cíclica
	{
		ActivateHeartbeat(oFollower, oMaster);
		switch (iPosition)
		{
			case 1: if(VerifyFreeSlot(oFollowing, "FSlot_1", oMaster)) {
					SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swFront+"-"+swLeft+" "+swShortDistance);
					SetFollowerAndFollowing("FSlot_1", oFollowing, oFollower, oMaster);
				} else if(VerifyFreeSlot(oFollowing, "FSlot_1-a", oMaster)){
						SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swFront+"-"+swLeft+" "+swMediumDistance);
						SetFollowerAndFollowing("FSlot_1-a", oFollowing, oFollower, oMaster);
					} else if(VerifyFreeSlot(oFollowing, "FSlot_1-b", oMaster)){
							SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swFront+"-"+swLeft+" "+swLongDistance);
							SetFollowerAndFollowing("FSlot_1-b", oFollowing, oFollower, oMaster);
						} else SendMessageToPC(oMaster, sNoEnoughtSubSlots); break;
				
			case 2: if(VerifyFreeSlot(oFollowing, "FSlot_2", oMaster)) {
					SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swFront+" "+swShortDistance);
					SetFollowerAndFollowing("FSlot_2", oFollowing, oFollower, oMaster);
				} else if(VerifyFreeSlot(oFollowing, "FSlot_2-a", oMaster)) {
						SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swFront+" "+swMediumDistance);
						SetFollowerAndFollowing("FSlot_2-a", oFollowing, oFollower, oMaster);
					} else if(VerifyFreeSlot(oFollowing, "FSlot_2-b", oMaster)) {
							SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swFront+" "+swLongDistance);
							SetFollowerAndFollowing("FSlot_2-b", oFollowing, oFollower, oMaster);
						} else SendMessageToPC(oMaster, sNoEnoughtSubSlots); break;
				
			case 3: if(VerifyFreeSlot(oFollowing, "FSlot_3", oMaster)) {
					SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swFront+"-"+swRight+" "+swShortDistance);
					SetFollowerAndFollowing("FSlot_3", oFollowing, oFollower, oMaster);
				} else if(VerifyFreeSlot(oFollowing, "FSlot_3-a", oMaster)) {
						SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swFront+"-"+swRight+" "+swMediumDistance);
						SetFollowerAndFollowing("FSlot_3-a", oFollowing, oFollower, oMaster);
					} else if(VerifyFreeSlot(oFollowing, "FSlot_3-b", oMaster)) {
							SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swFront+"-"+swRight+" "+swLongDistance);
							SetFollowerAndFollowing("FSlot_3-b", oFollowing, oFollower, oMaster);
						} else SendMessageToPC(oMaster, sNoEnoughtSubSlots); break;
				
			case 4: if(VerifyFreeSlot(oFollowing, "FSlot_4", oMaster)) {
					SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swLeft+" "+swShortDistance);
					SetFollowerAndFollowing("FSlot_4", oFollowing, oFollower, oMaster);
				} else if(VerifyFreeSlot(oFollowing, "FSlot_4-a", oMaster)) {
						SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swLeft+" "+swMediumDistance);
						SetFollowerAndFollowing("FSlot_4-a", oFollowing, oFollower, oMaster);
					} else if(VerifyFreeSlot(oFollowing, "FSlot_4-b", oMaster)) {
							SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swLeft+" "+swLongDistance);
							SetFollowerAndFollowing("FSlot_4-b", oFollowing, oFollower, oMaster);
						} else SendMessageToPC(oMaster, sNoEnoughtSubSlots); break;
				
			case 5: if(VerifyFreeSlot(oFollowing, "FSlot_5", oMaster)) {
					SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swRight+" "+swShortDistance);
					SetFollowerAndFollowing("FSlot_5", oFollowing, oFollower, oMaster);
				} else if(VerifyFreeSlot(oFollowing, "FSlot_5-a", oMaster)) {
						SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swRight+" "+swMediumDistance);
						SetFollowerAndFollowing("FSlot_5-a", oFollowing, oFollower, oMaster);
					} else if(VerifyFreeSlot(oFollowing, "FSlot_5-b", oMaster)) {
							SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swRight+" "+swLongDistance);
							SetFollowerAndFollowing("FSlot_5-b", oFollowing, oFollower, oMaster);
						} else SendMessageToPC(oMaster, sNoEnoughtSubSlots); break;
				
			case 6: if(VerifyFreeSlot(oFollowing, "FSlot_6", oMaster)) {
					SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swBehind+"-"+swLeft+" "+swShortDistance);
					SetFollowerAndFollowing("FSlot_6", oFollowing, oFollower, oMaster);
				} else if(VerifyFreeSlot(oFollowing, "FSlot_6-a", oMaster)) {
						SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swBehind+"-"+swLeft+" "+swMediumDistance);
						SetFollowerAndFollowing("FSlot_6-a", oFollowing, oFollower, oMaster);
					} else if(VerifyFreeSlot(oFollowing, "FSlot_6-b", oMaster)) {
							SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swBehind+"-"+swLeft+" "+swLongDistance);
							SetFollowerAndFollowing("FSlot_6-b", oFollowing, oFollower, oMaster);
						} else SendMessageToPC(oMaster, sNoEnoughtSubSlots); break;
				
			case 7: if(VerifyFreeSlot(oFollowing, "FSlot_7", oMaster)) {
					SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swBehind+" "+swShortDistance);
					SetFollowerAndFollowing("FSlot_7", oFollowing, oFollower, oMaster);
				} else if(VerifyFreeSlot(oFollowing, "FSlot_7-a", oMaster)) {
						SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swBehind+" "+swMediumDistance);
						SetFollowerAndFollowing("FSlot_7-a", oFollowing, oFollower, oMaster);
					} else if(VerifyFreeSlot(oFollowing, "FSlot_7-b", oMaster)) {
							SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swBehind+" "+swLongDistance);
							SetFollowerAndFollowing("FSlot_7-b", oFollowing, oFollower, oMaster);
						} else SendMessageToPC(oMaster, sNoEnoughtSubSlots); break;
				
			case 8: if(VerifyFreeSlot(oFollowing, "FSlot_8", oMaster)) {
					SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swBehind+"-"+swRight+" "+swShortDistance);
					SetFollowerAndFollowing("FSlot_8", oFollowing, oFollower, oMaster);
				} else if(VerifyFreeSlot(oFollowing, "FSlot_8-a", oMaster)) {
						SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swBehind+"-"+swRight+" "+swMediumDistance);
						SetFollowerAndFollowing("FSlot_8-a", oFollowing, oFollower, oMaster);
					} else if(VerifyFreeSlot(oFollowing, "FSlot_8-b", oMaster)) {
							SendMessageToPC(oMaster, "::<C=green>"+GetFirstName(oFollower)+"</C> "+swFollows+" <C=green>"+GetFirstName(oFollowing)+"</C>, "+swPosition+" "+swBehind+"-"+swRight+" "+swLongDistance);
							SetFollowerAndFollowing("FSlot_8-b", oFollowing, oFollower, oMaster);
						} else SendMessageToPC(oMaster, sNoEnoughtSubSlots); break;
				
			default: SendMessageToPC(oMaster, sApplyOnFreeSlotUnkown); break;
		}
	}
	else
		SendMessageToPC(oMaster, sErrorCircle);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
/// Aquí miramos si el slot está libre o no, si no lo está entonces miramos si quien ocupa el slot
/// sigue todavía a la ciratura, y si la está siguiendo en el mismo slot, si quien seguía ha cambiado
/// entonces interpretamos que el slot está libre.
////////////////////////////////////////////////////////////////////////////////////////////////////////
int VerifyFreeSlot(object oFollowing, string sSlot, object oMaster)
{
	int bResult;
	object oSlotFollower; //La declaramos, la cargaremos si procede
	if(GetIsObjectValid(GetLocalObject(oFollowing, sSlot))) //Si alguien ocupa el slot
	{
		oSlotFollower = GetLocalObject(oFollowing, sSlot); //Sabemos que este personaje está declarado cómo seguidor, ahora necesitamos 
														   //preguntarle si es cierto que sigue persiguiéndolo.
		if (
			(GetLocalObject(oSlotFollower, "oFollowingTarget")==oFollowing) //Si el seguidor está actualmente siguiendo
			& //...y si...
			(GetLocalString(oSlotFollower, "sFollowingSlot")  ==sSlot) //y si continúa siguiéndolo en el mismo slot
		)
			bResult=FALSE; //entonces indicamos que el slot no está libre
		else //...de lo contrario...
			bResult=TRUE; //de lo contrario indicamos que está libre para ser sobre-escrito
	}
	else
		bResult=TRUE; //Si el slot está puramente libre, o si la criatura no está en el servidor, entonces decimos que está libre
	
	return bResult; //La función devuelve el resultado
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
///Esta función inscribe el Following y Follower, haciendo que queden vinculados.
////////////////////////////////////////////////////////////////////////////////////////////////////////
void SetFollowerAndFollowing(string sSlot ,object oFollowing, object oFollower, object oMaster)
{
		//Escribimos quien ocupa el lugar, tanto en el slot del seguido cómo del seguidor, el seguido lleva una variable, el seguidor lleva dos
		SetLocalString(oFollower, "sFollowingSlot", sSlot); //Indica en el Follower qué slot utiliza
		SetLocalObject(oFollower, "oFollowingTarget", oFollowing); //Indica en el Follower qué criatura sigue
		SetLocalObject(oFollowing, sSlot, oFollower); //Indica en el Following, en la variable de su slot, la criatura que lo está siguiendo
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
///Esta función devuelve True si el objeto oFollowing es invisible o si se está tratandod e ocultar,
///por lo que, según estas normas, el modo Stealth es lo mismo que la invisibilidad.
////////////////////////////////////////////////////////////////////////////////////////////////////////
int isFollowingInvisible(object oFollowing, object oFollower)
{
	int SeeTheInvisible = FALSE;
	int IsInvisible = FALSE;
	if(
		(GetHasSpellEffect(88, oFollowing))| //Greater_Invisibility
		(GetHasSpellEffect(90, oFollowing))| //Invisibility
		(GetHasSpellEffect(93, oFollowing))| //Invisibility_Sphere
		(GetHasSpellEffect(483,oFollowing))| //Invisibility
		(GetHasSpellEffect(607,oFollowing))| //ASInvisibility
		(GetHasSpellEffect(608,oFollowing))| //ASImprovedInvisibility
		(GetHasSpellEffect(799,oFollowing))| //Vampire_Invisibility
		(GetHasSpellEffect(804,oFollowing))| //GrayInvisibility
		(GetHasSpellEffect(841,oFollowing))| //Retributive_Invisibility
		(GetHasSpellEffect(944,oFollowing))| //RacialInvisibility
		(GetHasSpellEffect(829, oFollowing))//Walk_Unseen
	  )
		IsInvisible = TRUE;
	else
		IsInvisible = FALSE;
		
	if(
		(GetHasSpellEffect(818, oFollower))| //See_the_Unseen
		(GetHasSpellEffect(186, oFollower))| //True_Seeing
		(GetHasSpellEffect(943, oFollower))| //See_Invisibility
		(GetHasSpellEffect(849, oFollower))  //Blindsight
	  )
		SeeTheInvisible = TRUE;
	else
		SeeTheInvisible = FALSE;
		
//	SendMessageToPC(GetFirstPC(),"SeeInvisible "+GetFirstName(oFollower)+": "+IntToString(SeeTheInvisible)+", IsInvisible "+GetFirstName(oFollowing)+": "+IntToString(IsInvisible));
		
	if(!IsInvisible)
		return FALSE;
	else
		if(SeeTheInvisible)
			return FALSE;
		else
			return TRUE;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
///Esta función devuelve Verdadero|1 en caso de que el objeto a seguir se esté ocultando correctamente
////////////////////////////////////////////////////////////////////////////////////////////////////////
int isFollowedHidding(object oFollowing, object oFollower)
{
	if(GetActionMode(oFollowing, ACTION_MODE_STEALTH))
	{
		if((GetSkillRank(SKILL_SPOT, oFollower)+10 > GetSkillRank(SKILL_HIDE, oFollowing)) |
			((GetSkillRank(SKILL_LISTEN, oFollower)+10 > GetSkillRank(SKILL_MOVE_SILENTLY, oFollowing)&(GetHasSpellEffect(849, oFollower)))))
			return FALSE;
		else
			return TRUE;
	}
	else
		return FALSE;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////
///Esta función permite saber si el Follower puede ver a su Following, el cual está guardado dentro
///de una variable del Follower mismo. Siguiendo las normas estándar de NWN2, o sin seguir las normas
///estándar, esta decisión se hace mediante la constante [UseClassicNWN2Perception].
////////////////////////////////////////////////////////////////////////////////////////////////////////
int CanSeeTheTarget(object oFollower)
{
	object oFollowing = GetLocalObject(oFollower, "oFollowingTarget");
	if (UseClassicNWN2Perception)
		return GetObjectSeen(oFollowing, oFollower); //Classic NWN2 Perception
	else
		if(!(isFollowedHidding(oFollowing, oFollower)) & !(isFollowingInvisible(oFollowing, oFollower))) //Si no se oculta y no es invisible
			return TRUE;
		else
			return FALSE;
}