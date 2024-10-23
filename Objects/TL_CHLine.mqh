#include "TL_CBaseObjects.mqh"
//+-----------------------------------------------------------------+
//| Class : CHLine                                                   |
//+------------------------------------------------------------------+
class CHLine : public CBaseObjects
{
   public:
      CHLine(string _name)                   : CBaseObjects( _name){}
      CHLine(long _id,string _name)          : CBaseObjects(_id,_name){}
      CHLine(long _id,string _name,int _sub) : CBaseObjects(_id,_name,_sub){}
      //---
      ~CHLine(void){};
      //---
      bool Create();
      bool Delete();
      bool Move(double price);
};
bool CHLine::Create()
{
   ResetLastError(); 
   if(!ObjectCreate(id,name,OBJ_HLINE,sub,0,0)) 
   { 
      Print(__FUNCTION__,": failed to create a horizontal line! Error code = ",GetLastError()); 
      return(false); 
   }
   return true; 
}
bool CHLine::Delete(void)
{
   ResetLastError(); 
   if(!ObjectDelete(id,name)) 
   { 
      Print(__FUNCTION__,": failed to delete a horizontal line! Error code = ",GetLastError()); 
      return(false); 
   } 
   return true;
}
bool CHLine::Move(double price)
{
   ResetLastError();  
   if(!ObjectMove(id,name,0,0,price)) 
   { 
      Print(__FUNCTION__,": failed to move the horizontal line! Error code = ",GetLastError()); 
      return(false); 
   } 
   return true;
}


