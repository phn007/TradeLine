#include "TL_CSetTradeLine.mqh"
//+------------------------------------------------------------------+
//| Chlid Class : CEntryLine                                         |
//+------------------------------------------------------------------+
class CEntryLine : public CSetTradeLine
{
   private:
      void GetProperties();
   public:
      CEntryLine();
      ~CEntryLine(void){}; 
      //---
      void SwitchOnOff();           
};
//+------------------------------------------------------------------+
//| Chlid Class : Construct                                          |
//+------------------------------------------------------------------+
CEntryLine::CEntryLine()
{
   gv.GetVars();
   //---
   lineName = base.entryLine;
   GetProperties();
}
//+------------------------------------------------------------------+
//| Method : GetProperties                                           |
//+------------------------------------------------------------------+
void CEntryLine::GetProperties(void)
{
   double stopPrice = ObjectGetDouble(0,base.stopLine,OBJPROP_PRICE);
   //---
   if(gv.switchMethod == 1) // ByMarket
   {
      linePrice = GetEntryPrice(stopPrice);
      //---
      text       = "#Entry : ByMarket";
      clr        = clrRoyalBlue;
      select     = false;
   }
   else if(gv.switchMethod == 0) // Pending
   {
      linePrice = gv.entryPrice != NULL ? gv.entryPrice : GetEntryPrice(stopPrice);
      text       = "#Entry : Pending";
      clr        = clrRoyalBlue;
      select     = true;   
   }
}
//+------------------------------------------------------------------+
//| Method : SwitchOnOff                                             |
//+------------------------------------------------------------------+
void CEntryLine::SwitchOnOff(void)
{
   gvSwitchTradeLine = gv.switchTradeLine;
   CSetTradeLine::SwitchOnOff();
}
