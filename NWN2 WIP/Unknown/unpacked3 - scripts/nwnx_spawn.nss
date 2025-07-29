const int SPAWN_NOWAIT = 0;
const int SPAWN_WAIT = 1;

string SpawnEnvironment(string sEnvironmentVariable);
string SpawnEscape(string sString);
string SpawnQuote(string sString);
void SpawnCommand(string sCommand, int iWait = SPAWN_NOWAIT);
void SpawnProgram(string sProgram, int iWait = SPAWN_NOWAIT);

string SpawnEnvironment(string sEnvironmentVariable)
{
  return NWNXGetString("SPWN","ENVIRONMENT",sEnvironmentVariable,0);
}

string SpawnEscape(string sString)
{
  return NWNXGetString("SPWN","ESCAPE",sString,0);
}

string SpawnQuote(string sString)
{
  return NWNXGetString("SPWN","QUOTE",sString,0);
}

void SpawnCommand(string sCommand, int iWait = SPAWN_NOWAIT)
{
  NWNXSetString("SPWN","COMMAND","",iWait,sCommand);
}

void SpawnProgram(string sProgram, int iWait = SPAWN_NOWAIT)
{
  NWNXSetString("SPWN","PROGRAM","",iWait,sProgram);
}