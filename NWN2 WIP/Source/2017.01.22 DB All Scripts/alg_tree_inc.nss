//modified hv_oredrop for woods harvest

string ZALANATAR = "n2_crft_plkzalantar";
string YEW = "n2_crft_plkwood";
string DUSKWOOD = "n2_crft_plkdskwood";
string RAZORVINE = "alg_razor";
string SPLINTERS = "alg_splinters";

//Ironwood drops..go figure Ironwood
string GetWoodType(string sCategory)
{ 
 
 if (sCategory == "zalanatar") {
  
  {
   return ZALANATAR;
  
  }
 }
 //yew 
 else if (sCategory == "yew") {
  {
    return YEW;
   
  }
 }
 
  
  
  // Duskwood
 else if (sCategory == "duskwood") {
 {
      return DUSKWOOD;
  
  }
  
  
 }
 //razorvine
 else if (sCategory == "razorvine") {
 {
      return RAZORVINE;
  
  }
  
  
 }
  
   
 return "";
}