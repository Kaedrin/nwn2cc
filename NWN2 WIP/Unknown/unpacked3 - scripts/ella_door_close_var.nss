string localname = GetLocalString(OBJECT_SELF,"Door");
void main(){
	object Puerta = GetObjectByTag(localname);
	ActionCloseDoor(Puerta);
}