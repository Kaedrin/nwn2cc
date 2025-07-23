#include "ginc_var_ops"
#include "nw_i0_plot"

object oSeen = GetLastPerceived();
void main()
{
	if (GetIsPC(oSeen)) {
		if (GetJournalEntry("hv_captured_dryad",oSeen) == 6) {
			ActionSpeakString("<C=lightgreen><i>The Dryad presses her face against the bars in silent plea");
			if (GetNumItems(oSeen, "hv_gnoll_key") < 1) {
				object oItem = GetObjectByTag("hv_gnoll_key");
				ActionGiveItem(oItem, oSeen, 1);
								
			}
			AddJournalQuestEntry("hv_captured_dryad", 7, oSeen, FALSE, FALSE, FALSE);
		}
	}
}