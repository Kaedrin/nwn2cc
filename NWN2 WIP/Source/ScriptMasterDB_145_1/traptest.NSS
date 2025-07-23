/* Undead defense trap script
* 
* @author <your name>
* @id $Id$
*/

void blastWithHolyMight(object o) {

	ActionCastSpellAtObject(SPELL_HAMMER_OF_THE_GODS, o, METAMAGIC_NONE, TRUE, 15);
}

void main() {

	object exiting = GetExitingObject();
	object entering = GetEnteringObject();
	if (GetIsObjectValid(entering)) {
		PrintString("Trap triggered by entry of " + GetName(entering));
		 blastWithHolyMight(entering);
	}
	
	if (GetIsObjectValid(exiting)) {
		PrintString("Trap triggered by exit of " + GetName(exiting));
		 blastWithHolyMight(exiting);
	}
		
	if (!(GetIsObjectValid(exiting) || GetIsObjectValid(entering))) {
		PrintString("Trap triggered by no one in particular");
	}
	
	
			 

}