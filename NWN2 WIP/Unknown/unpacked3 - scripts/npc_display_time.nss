void main()
{
int nHour = GetTimeHour ();
int nMinute = GetTimeMinute();
SendMessageToPC (GetFirstPC(),"It is hour "+IntToString(nHour));
}