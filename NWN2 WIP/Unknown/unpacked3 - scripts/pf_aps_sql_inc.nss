/*  Persistence Facade v1.1, by benton
*/
//==================   APS compatibilty functions ===================//
// These are put in for APS compatibility
// As of PFv1.0, they return empty SQL sets

int SQL_ERROR = 0;
int SQL_SUCCESS = 1;

void SQLExecDirect(string sSQL) { }
int SQLFetch() {return SQL_SUCCESS; }
int SQLFirstRow() { return SQL_ERROR; }
int SQLNextRow() { return SQL_ERROR; }
string SQLGetData(int iCol) { return "" ; }
