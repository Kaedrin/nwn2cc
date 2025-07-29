//-----------------------------------------------------------------------------
//  C Daniel Vale 2007
//  djvale@gmail.com
//
//  C Laurie Vale 2007
//  charlievale@gmail.com
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program; if not, write to the Free Software
//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
//------------------------------------------------------------------------------
//  Script Name: vn_mda__inc
//  Description: include file for modifying item appearances
//------------------------------------------------------------------------------

//   Pick the price!
//                     Only one of these should be uncommented;
//const float MDA_PERCENTAGE_CHARGE = 1.5;  // charge a percentage of the value of the item being modified.
const float MDA_PERCENTAGE_CHARGE = 0.0;  // do not charge based on the item's value.

//                   Only one of these should be uncommented;
//const int MDA_FLAT_FEE = 1; // make sure changing always cost something, even when the percentage cost is less than 1 gp
//const int MDA_FLAT_FEE = 100; // charge 100 gp per item modified.
const int MDA_FLAT_FEE = 0; // do not charge per item modified.

// You can control the cost based on the type of item, if you wish, by changing these:
const float HELM_PERCENTAGE_CHARGE = MDA_PERCENTAGE_CHARGE;
const int  HELM_FLAT_FEE = MDA_FLAT_FEE;
const float CLOAK_PERCENTAGE_CHARGE = MDA_PERCENTAGE_CHARGE;
const int  CLOAK_FLAT_FEE = MDA_FLAT_FEE;
const float BOOTS_PERCENTAGE_CHARGE = MDA_PERCENTAGE_CHARGE;
const int  BOOTS_FLAT_FEE = MDA_FLAT_FEE;
const float GLOVES_PERCENTAGE_CHARGE = MDA_PERCENTAGE_CHARGE;
const int  GLOVES_FLAT_FEE = MDA_FLAT_FEE;
const float ARMOR_PERCENTAGE_CHARGE = MDA_PERCENTAGE_CHARGE;
const int  ARMOR_FLAT_FEE = MDA_FLAT_FEE;
const float RIGHTHAND_PERCENTAGE_CHARGE = MDA_PERCENTAGE_CHARGE;
const int  RIGHTHAND_FLAT_FEE = MDA_FLAT_FEE;
const float LEFTHAND_PERCENTAGE_CHARGE = MDA_PERCENTAGE_CHARGE;
const int  LEFTHAND_FLAT_FEE = MDA_FLAT_FEE;


// -------------------  End of Customizeable variables -----------------------------------------

// These are the prefixes used for the appearance ResRefs.
const string HELM = "vn_base_helm_";
const string CLOAK = "vn_base_cloak_";
const string BOOTS = "vn_base_boots_";
const string GLOVES = "vn_base_glove_";
const string BRACERS = "vn_base_bracer_";
 // armor
const string CLOTH = "vn_base_cloth_";
const string PADDED = "vn_base_padded_";
const string LEATHER = "vn_base_leather_";
const string STUDDED = "vn_base_studdedleather_";
const string CHAINSHIRT = "vn_base_chainshirt_";
const string HIDE = "vn_base_hide_";
const string SCALEMAIL = "vn_base_scalemail_";
const string CHAINMAIL = "vn_base_chainmail_";
const string BREASTPLATE = "vn_base_breastplate_";
const string SPLINT = "vn_base_splint_";
const string BANDED = "vn_base_banded_";
const string HALFPLATE = "vn_base_halfplate_";
const string FULLPLATE = "vn_base_fullplate_";
// mithral armor
const string MITHRAL_BANDED = "vn_base_mithral_banded_";
const string MITHRAL_BREASTPLATE = "vn_base_mithral_breastplate_";
const string MITHRAL_CHAINSHIRT = "vn_base_mithral_chainshirt_";
const string MITHRAL_CHAINMAIL = "vn_base_mithral_chainmail_";
const string MITHRAL_FULLPLATE = "vn_base_mithral_fullplate_";
const string MITHRAL_HALFPLATE = "vn_base_mithral_halfplate_";
const string MITHRAL_SCALEMAIL = "vn_base_mithral_scalemail_";
const string MITHRAL_SPLINT = "vn_base_mithral_splint_";

 // shield
const string LIGHTSHIELD = "vn_base_lightshield_";
const string HEAVYSHIELD = "vn_base_heavyshield_";
const string TOWERSHIELD = "vn_base_towershield_";
 // weapons
const string BASTARDSWORD = "vn_base_bastardsword_";
const string BATTLEAXE = "vn_base_battleaxe_";
const string CLUB = "vn_base_club_";
const string DAGGER = "vn_base_dagger_";
const string DWARVENWARAXE = "vn_base_dwarvenwaraxe_";
const string FALCHION = "vn_base_falchion_";
const string GREATAXE = "vn_base_greataxe_";
const string GREATSWORD = "vn_base_greatsword_";
const string HALBERD = "vn_base_halberd_";
const string HANDAXE = "vn_base_handaxe_";
const string HEAVYCROSSBOW = "vn_base_heavycrossbow_";
const string KAMA = "vn_base_kama_";
const string KATANA = "vn_base_katana_";
const string KUKRI = "vn_base_kukri_";
const string LIGHTCROSSBOW = "vn_base_lightcrossbow_";
const string LIGHTFLAIL = "vn_base_lightflail_";
const string LIGHTHAMMER = "vn_base_lighthammer_";
const string LONGBOW = "vn_base_longbow_";
const string LONGSWORD = "vn_base_longsword_";
const string MACE = "vn_base_mace_";
const string MORNINGSTAR = "vn_base_morningstar_";
const string QUARTERSTAFF = "vn_base_quarterstaff_";
const string RAPIER = "vn_base_rapier_";
const string SCIMITAR = "vn_base_scimitar_";
const string SCYTHE = "vn_base_scythe_";
const string SHORTBOW = "vn_base_shortbow_";
const string SHORTSWORD = "vn_base_shortsword_";
const string SICKLE = "vn_base_sickle_";
const string SPEAR = "vn_base_spear_";
const string WARHAMMER = "vn_base_warhammer_";
const string WARMACE = "vn_base_warmace_";

// how many variations of each item type are available to choose from
const int HELM_VARIATIONS = 310;
const int CLOAK_VARIATIONS = 151;
const int BOOTS_VARIATIONS = 193;
const int GLOVES_VARIATIONS = 75;
const int BRACER_VARIATIONS = 9;
 // armor
const int CLOTH_VARIATIONS = 361;
const int PADDED_VARIATIONS = 42;
const int LEATHER_VARIATIONS = 63;
const int STUDDED_VARIATIONS = 64;
const int CHAINSHIRT_VARIATIONS = 152;
const int HIDE_VARIATIONS = 32;
const int SCALEMAIL_VARIATIONS = 33;
const int CHAINMAIL_VARIATIONS = 72;
const int BREASTPLATE_VARIATIONS = 177;
const int BANDED_VARIATIONS = 122; 
const int HALFPLATE_VARIATIONS = 122;
const int FULLPLATE_VARIATIONS = 240;
const int SPLINT_VARIATIONS = 122;
  //mithral armor
const int MITHRAL_BANDED_VARIATIONS = 122;
const int MITHRAL_BREASTPLATE_VARIATIONS = 177;
const int MITHRAL_CHAINSHIRT_VARIATIONS = 152;
const int MITHRAL_CHAINMAIL_VARIATIONS = 72;
const int MITHRAL_FULLPLATE_VARIATIONS = 240;
const int MITHRAL_HALFPLATE_VARIATIONS = 122;
const int MITHRAL_SCALEMAIL_VARIATIONS = 29;
const int MITHRAL_SPLINT_VARIATIONS = 122;  
  //shield
const int LIGHTSHIELD_VARIATIONS = 41;
const int HEAVYSHIELD_VARIATIONS = 69;
const int TOWERSHIELD_VARIATIONS = 43;
 // weapons
const int BASTARDSWORD_VARIATIONS = 26;
const int BATTLEAXE_VARIATIONS = 20;
const int CLUB_VARIATIONS = 23;
const int DAGGER_VARIATIONS = 45;
const int DWARVENWARAXE_VARIATIONS = 7;
const int FALCHION_VARIATIONS = 15;
const int GREATAXE_VARIATIONS = 25;
const int GREATSWORD_VARIATIONS = 40;
const int HALBERD_VARIATIONS = 14;
const int HANDAXE_VARIATIONS = 22;
const int HEAVYCROSSBOW_VARIATIONS = 5;
const int KAMA_VARIATIONS = 19;
const int KATANA_VARIATIONS = 18;
const int KUKRI_VARIATIONS = 11;
const int LIGHTCROSSBOW_VARIATIONS = 12;
const int LIGHTFLAIL_VARIATIONS = 3;
const int LIGHTHAMMER_VARIATIONS = 7;
const int LONGBOW_VARIATIONS = 15;
const int LONGSWORD_VARIATIONS = 41;
const int MACE_VARIATIONS = 21;
const int MORNINGSTAR_VARIATIONS = 8;
const int QUARTERSTAFF_VARIATIONS = 18;
const int RAPIER_VARIATIONS = 24;
const int SCIMITAR_VARIATIONS = 20;
const int SCYTHE_VARIATIONS = 10;
const int SHORTBOW_VARIATIONS = 5;
const int SHORTSWORD_VARIATIONS = 40;
const int SICKLE_VARIATIONS = 8;
const int SPEAR_VARIATIONS = 56;
const int WARHAMMER_VARIATIONS = 13;
const int WARMACE_VARIATIONS = 14;