//Otomo Tetsuo 10.19.2008
//OnOpen script that will Close doors after a slight delay.

// Edited 10th aug 2009 JayNi. Doors werent closing. We needed to assign the door to close itself.

void main()
{
	DelayCommand(24.0,ActionCloseDoor(OBJECT_SELF));
}