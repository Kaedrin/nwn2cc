/*


Hi there, 

Thanks for being willing to build for Dalelands Beyond server. What you have here is a “Builders Module” The Builders Module is not the full server.  Most of the custom content that makes the server run is not actually here, but what is here will let you create areas, creatures items that will work with the server.

///////////GETTING STARTED//////////

A little note, about what is actually here;
Like many of the NWN2 PW’s out there, DLB used the HCR2 System as a bases for mounting the server.  There are in fact a lot of other community based things as well as custom things created for DLB that make it run, but those things are not really needed for the purpose of building.  

Why do we not hand out the full set of custom scripts? Well, it actually has nothing to do with keeping secrets, believe it or not.  A lot of DLB’s custom features are based off of a SQL database, and in order for them to work, you would have to have access to that database or run from a copy of that database.  For the staff to do that, well it would just be a pain in the rear end. So to be blunt, that is one of the main reason we don’t send out a full set of the module scripts etc.

Reason number two is even more practical. The module is quite large, over almost three hundred areas and still growing at the time when this was written.  It takes a silly long time to download a copy, and opening it in the toolset is an effective exercise in crashing the toolset.  One has to work with it in smaller “chunks.”

So that is what we have created here for you to work with, the bare bones of what is needed to get started. As you begin to work on areas, or adjust areas already live on the server, we can and will of course give you copies of those needed areas, items, creatures etc.

/////////NAMING CONVENTIONS – AREAS/////////

When it comes to “Area Names”, please use English.  Calling a Bar in Myth Drannor “area_001-456-wkha” is just gonna piss everyone off.  Better to name it something that lets folks know what the hell it is, such as myth_drannor_dwarf_bar

Also, you will see there are four areas provided for you in the module, 

“base_area_ext_large”
“base_interior”
“ud_base_area_ext_large”
“ud_base_interior”

You can right-click and “duplicate” duplicate these areas to create areas of your own.  Each of them has the basic areas setting needed to run on the server already set up for you, BUT there is something you need to do in order to avoid confusion when using one of these duplicated areas for you own work.

First you will need to re-name the area (right-click, rename) AND then you will need to open that area and look at the area properties BEFORE you click on anything else. Once the area is open, look at the properties window (upper left side is default) and change the following things to fit your new area

Find the following in the “Basics” section of the “Properties” tab

Display Name – this will have a description such as “Surface ~” or “Underdark ~” Please add in a specific name for you area, which is the one the players will see in their player map (“Underdark ~ Stinky Feet Tunnels”). Then scroll down a bit and find the “Tag” for the area.  For the love of God, geekness, candy or whatever, please, oh please re-name the tag to match up with the name you put into the “Display Name” box.

/////////NAMING CONVENTIONS – EVERYTHING ELSE//////////

If you take a look at the “Creatures” blueprints window (lower left had of the toolset screen when you first load this module) you will see the basic set up of how things get organized for the server.

In the past builders just kinda did whatever, and tossed it on the server.  Over the past year or so, the staff has been making the effort to clean the chaotic “whatever” up so that other builders, and more specifically the DM’s, can actually find things in the game while they are helping players, running events etc.  So please, or please take the extra couple of seconds to follow the naming conventions.

So at the top of that list is “(a) Example” – take a look at that creature.  If you scroll down to “Basics” you will see a box called “Classification.” In that box you will see the “(a) Example” category that the creature is filed under.  Please follow that example with all of the items and creatures you create for the server.  

Now the “(a) Example” category is not actually a category used for anything on the server, but is just here in the builder’s module to be easily found at the top of the list.

The (c) has a specific meaning, in regards to creatures it refers to if they are hostile from the moment spawned.  
The (n) indicates that the creatures are “True Nuetral” (or at least should be)

All NPC’s. or Mobs (mobile objects), need to be set to either the “Hostile” faction or the “Nuetral” faction.  Never use Commoner, Merchant or Defender.  In game the DM’s can change a creatures faction to one of the other settings as desired or needed, so please just use Nuetral and Hostile.

Below is a list of categories, by type, for the server.

====CREATURE BLUEPRINTS====
(c) Location - this is Hostile creature from the area name where the creature spawns.
(n) Location  - this is a Nuetral creature from the area name where the creature spawns.

====ITEM BLUEPRINTS====
(i) Area – this item is found in the area name
(i) Crafting – this item drops for use in the custom crafting system
(i) Guild Name – this item is for a specific guild (NEVER PUT MAGICAL EFFECT ON GUILD ITEMS)
(i) Faction Name – this item is for a specific faction, Zhent, Myth Drannor, Shadowdale
(i) Custom Character Appearance – these are items submitted for import for specific character, more on this below.

====DOORS BLUEPRINTS====
(d) Example Door – this is just there to show you something about doors and scripts later, please do not make any custom doors or transitions for the server.  Just don’t do it, cause it will just end up being deleted before up loading.

Regarding doors that automatically close or automatically close and lock, if you look at the two “Example Doors” you will see in the “On Used Script” section of the door’s scripts properties and assigned script.  To have doors the shut or shut and lock, you will need to place that script in the “On Used Script” of every door you place.

====STORES BLUEPRINTS====
Just like Doors, please do not ever make a store for the server, it will just be deleted before it is uploaded.  If their needs to be a store added in an area, one of the DM staff will take care of it.  It is far too easy to cause a great deal of trouble via stores, so please leave them alone.

====PLACEABLES BLUEPRINTS====
Please do not create custom blueprints for your placeables.  Yes I know it is easier for you to find them while your building if you make your own, but what happens is, the server it’s self gets so filled up with copies of the exact same thing, often with the exact same name, that an in game DM has absolutely no chance what so ever of finding anything to then create live on the server for use in your role-playing.  Just don’t do it, please.
For Chairs and benches etc that player characters can “sit” upon, we use the KEMO Chairs system.  If you look in the blueprints, you will find them ready for placing.

====TRIGGERS BLUEPRINTS====
Please do not create any custom trigger blue prints.  You can easily lay down a trigger in an area, and customize it without creating a blue print from that trigger.
Note the HCR2 category – there you will find the “Rest Zone Trigger” that you can paint around campfires, bed rooms, etc for players to rest within.

====ENCOUNTERS BLUEPRINTS====
Do not use the default encounter system. Do not create encounter blueprints.

The NWN2 Encounter system is one of the most server resource unfriendly things in the game (next to Trees).  Please do not use it.  In the past, some of the older areas have used the default encounter system, and chances are you might be able to point out which specific area still have it (server pauses or lags a brief second every time you hit a spawn trigger). Some old areas are mixed with both the default and the NESS system in place.  At present, the staff is slowing working on shifting over all areas to the NESS spawn based system to improve server response and stability.
DLB uses a custom system based off of NESS – see below

====SOUND BLUEPRINTS====
Please do not create any custom sound blueprints. You can easily adjust a sound one it has been placed down in an area, as needed.

====WAYPOINT BLUEPRINTS====
Please do not create any custom waypoint blueprints, with one very big exception.  All things that spawn, creatures, chests etc, do it through waypoints and the custom version of NESS running on the server.  There will be more on NESS below. 

====STATIC CAMERA BLUEPRINTS====
Please do not make custom static cameras, and in fact, please do not ever use them.  The NWN2 camera system bugs several of the other multiple player features, such as stealth, and is not used on this server.

====LIGHT BLUEPRINTS====
Please do not make custom light blueprints.  It is exceptionally easy to select all of the placed lights in an area and adjust them all at once, in real time, to see their effects on the lighting conditions of an area.

====TREE BLUEPRINTS====
Please do not make custom tree blueprints.  Just don’t do it, easy enough to adjust them from within an area.  Also, please note, Trees are one of the biggest lag creators within NWN2.  Placing a lot of trees will just get your area sent back to you for them to be removed.  Never, ever, just paint trees into an area. Always place them one at a time specifically.

====PLACED EFFECT BLUEPRINTS====
Please do not make custom placed effects blueprints. 

====PREFABS BLUEPRINTS====
Make all of the prefab blueprints your little heart might desire, as these items do not transfer into the server.  These stay wholly on your computer. 

/////////NESS SPAWNING SYSTEM/////////
Okie dokie, here comes the fun.  One should never just drop an NPC or other mob down in and area.
  What will happen is that creature will be killed once, and never ever come back again (or at leas
  t until the server resets).  Instead, you NESS and a spawning waypoint.

So how does one use NESS?  Well when you unpacked this 7-Zipped up little package, you may have noticed
 a folder that was called “Look at Me Later”, well it is not “Later.” Within that folder you will find
  “NESS2.rar” – open that fella up, and within you will find “NESS_V80_Tutorial_v11”.  Sorry to say there
   is a bit of a learning curve to struggle through, as this system was originally written for NWN1, then
    adapted to NWN2 (with further specific adjustments for DLB), but that Manuel will get you going and let
	 you know all you need to use the NESS spawning system.

////////MAKING BLUEPRINTS/////////
When you do make a blueprint for a creature or an item there is one more thing you need to do, so that you
 can find your blueprint for exporting later, as well as be confident that you are not going to overwrite
  someone else’s work and make a mess.  

There are three categories in every blueprint, which correspond to unique filenames. These are found in the
 “Properties” tab, under the “Basics” heading of blueprints.  They are – 

“Resource Name”
“Tag”
“Template Resref”

In order address the above mentioned issues, you must rename these three things to unique names.  On DLB,
 we use the builder’s name or initials as a prefix to a descriptive name, and use that name for all three
  categories (Resource Name, Tag and ResRef).
Example – 

Resource Name - “gac_human_example”
Tag – “gac_human_example”
Template Resref – “gac_human_example”

Please do this for every creature, item and thing you might create as a blueprint.

/////////CUSTOM APPEARANCE GEAR/////////
All custom created gear must be passed though the DM staff before it will go live on the server.  Any and
 all gear that has a magical property on it will not be allowed on the server.  Create your custom
  appearance items with no effects/abilities on them what-so-ever.  Once these plain items are approved
   and added to the server, the DM staff can add the magical effects to the items in real time, if such
    effects are needed.

////////CONVERSATIONS/////////
Please be sure to check the “Neverwinter Night 1-style Dialogue” box in all the conversation you create.
  The fancy camera NWN2 style conversations causes bug issues on multiplayer servers, please do not use it. 

/////////TESTING YOUR WORK/////////
To test your work you will need to do two things, first bake the area.  If you don’t know how to do that,
 then please go look it up on one of the many PDF tutorials for the NWN2 Toolset. 

Then you can run your areas/work on your own machine from the Toolset via the “Run Module” command
 (File|Run module).  Pease check you work before submitting it to the staff for review and up load prep.
   Make sure all of your sit-able chairs are facing the right direction.  Make sure your mobs are spawning
    correctly, and delete any store or item that you may have placed on the ground in an area.

/////////SUBMITTING YOUR AREAS FOR UP LOADING/////////
Your areas will not be directly up loaded to the server. Period.  Sorry folks, it is just too easy to break
 things, so one has to be careful in this process, and that will take time.  Often more time than anyone
  might happen to like.

To submit your work you will need to export it via the “Export” command (File|Export).  A new window will
 pop up, with a pull down menu along the top. Click the pull down menu, and select the ResRef Name of your
  area(s) adding them to the export box on the left.  Then hit OK and name your newly created ERF file
   describing what it is, along with your name and date of submission (01_31_13_Gil_Cass_Ale_Drunk_Inn).

If you are including creatures/mob in your work, you will need to export those separately so that when the
 staff adds them to the server, there is something for the NESS waypoints to spawn.

Please note that any and all scripts/stores/items left in areas will be deleted before up loading, as well
 as any placeable containers that might have an item within their inventory, so please don’t do it, as you
  are just creating more work and delaying your work form going live on the server. 
  
One last note, and hopefully this won’t be an issue, but it just has to be said.  Anything you build for
 the server belongs to the server.  That means should you move on, decide to start your own server, etc,
  your work that has been added to this server will remain on the server.  It will not be removed by your
   request.  Furthermore, should other builders and staff members make adjustments to your work reflecting
    on going changes in the plotlines and role-play, or even remove it, please do not be offended.

Thank you for reading, as well as being willing to contribute to the server! 

PS – the “0_see_readmebuilder_in_scripts” area has some examples of door connections, waypoint jumps
 and conversation launched transitions that might be a helpful learning tool 

*/