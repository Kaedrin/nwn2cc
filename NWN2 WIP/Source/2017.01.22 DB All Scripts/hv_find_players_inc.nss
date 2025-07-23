// If TRUE, the area where the PC is spotted
// will not show up even if others are there.
// If FALSE, the PC would just not be counted
// when calculating number of PCs in area.
const int HIDE_ENTIRE_AREA_FOR_PC = FALSE;

// TRUE = players will have to allow others to find them
// by default.
// FALSE = players will be found by default and will have
// to toggle anonymity in order not to be found
const int HIDE_ALL_BY_DEFAULT = FALSE;

// Name of the variable that will control anonymity
const string FIND_PLAYERS_VAR = "hv_scry_tool";

// Prefix for variable so I can identify them
const string AREA_VAR_PREFIX = "hv_area_";