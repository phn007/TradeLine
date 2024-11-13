#include "TL_CRRFib.mqh";
//+------------------------------------------------------------------+
//| Class: CSetEntryLines                                            |
//+------------------------------------------------------------------+
class CEntryRRFib : public CRRFib
{
   public:
      CEntryRRFib();
     ~CEntryRRFib(void){};
};
CEntryRRFib::CEntryRRFib()
{
   //---
   objName  = RRFIB_NAME;
   time1    = iTime(_Symbol,_Period,0);
   time2    = time1;
   //---
   price1 = ObjectGetDouble(0,ENTRYLINE_NAME,OBJPROP_PRICE); 
   price2 = ObjectGetDouble(0,STOPLINE_NAME, OBJPROP_PRICE);  
   //---
   clr         = clrBlack; 
   style       = STYLE_SOLID; 
   width       = 1; 
   back        = false;
   selectable  = true;
   selection   = false;
   ray_left    = false; 
   ray_right   = true;
   hidden      = true; 
   z_order     = 0;
   //---
   levels = 12;
   levelStyle  = STYLE_DASH;
   levelWidth  = 1;
   levelColor  = clrRoyalBlue;
   //---
}


