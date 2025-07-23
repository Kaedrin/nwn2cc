// Door Close Script, attach to "onOpen"
void main()
{
DelayCommand(15.0, ActionCloseDoor(OBJECT_SELF));
}