void main()
{
	switch (Random(5)) //Quantity of total actions
   {
    case 1 : 
		SpeakString("*Loose talk phrases* Please... I need a coin... My, my family...");
		ActionPlayAnimation(ANIMATION_FIREFORGET_KNEELTALK);
	break;
    case 2 : 
		SpeakString("*Collapses*");
		ActionPlayAnimation(ANIMATION_FIREFORGET_COLLAPSE);
	break;
    case 3 : 
		SpeakString("I... I lost everything... ");
		ActionPlayAnimation(ANIMATION_FIREFORGET_BOW); 
	break;
    case 4 : 
		SpeakString("I'm in need...");
		ActionPlayAnimation(ANIMATION_FIREFORGET_INTIMIDATE); 
	break;
    default : 
		SpeakString("Please spare some food...");
		ActionPlayAnimation(ANIMATION_LOOPING_COOK01); 
   }
}