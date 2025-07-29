void main()
{
	object oItemHolder	= GetItemActivator();
    object oItem		= GetItemActivated();
	
	// Store the book on pc
	SetLocalObject(oItemHolder, "ev_recipe_book", oItem);
	
	// Display gui
	DisplayGuiScreen(oItemHolder, "ev_recipe_book", FALSE, "ev_recipe_book.XML");
}