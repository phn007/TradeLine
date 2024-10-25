#include "TL_CBaseObjects.mqh"
//+------------------------------------------------------------------+
//| Class : CLabel                                                   |
//+------------------------------------------------------------------+
class CLabel : public CBaseObjects
{
   public:
      CLabel(string _name)                   : CBaseObjects( _name){}
      CLabel(long _id,string _name)          : CBaseObjects(_id,_name){}
      CLabel(long _id,string _name,int _sub) : CBaseObjects(_id,_name,_sub){}
      //---
      ~CLabel(void){};
      //---
      bool Create();
      bool Delete();
      bool Move(int x,int y);
};
bool CLabel::Create(void)
{
   ResetLastError(); 
   //---
   if(!ObjectCreate(id,name,OBJ_LABEL,sub,0,0)) 
   { 
      Print(__FUNCTION__,": failed to create text label! Error code = ",GetLastError()); 
      return(false); 
   } 
   return true;
}
bool CLabel::Move(int x,int y)
{
   //--- reset the error value 
   ResetLastError(); 
   //--- move the text label 
   if(!ObjectSetInteger(id,name,OBJPROP_XDISTANCE,x)) 
   { 
      Print(__FUNCTION__,": failed to move X coordinate of the label! Error code = ",GetLastError()); 
      return(false); 
   } 
   if(!ObjectSetInteger(id,name,OBJPROP_YDISTANCE,y)) 
   { 
      Print(__FUNCTION__,": failed to move Y coordinate of the label! Error code = ",GetLastError()); 
      return(false); 
   } 
   //--- successful execution 
   return(true); 
}

bool CLabel::Delete(void)
{
   //--- reset the error value 
   ResetLastError(); 
   //--- delete the label 
   if(!ObjectDelete(id,name)) 
   { 
      Print(__FUNCTION__, ": failed to delete a text label! Error code = ",GetLastError()); 
      return(false); 
   } 
   //--- successful execution 
   return(true); 
}