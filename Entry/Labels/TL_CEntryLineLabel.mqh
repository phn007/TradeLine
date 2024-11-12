#include "TL_CSetLineLabel.mqh"
//+------------------------------------------------------------------+
//| Child Class :  CEntryLineLabel                                    |
//+------------------------------------------------------------------+
class CEntryLineLabel : public CSetLineLabel
{
   public:
      CEntryLineLabel();
      ~CEntryLineLabel(void){};
      //---
      void SwitchOnOff();//override
};
//+------------------------------------------------------------------+
//| Child Class :  Construct                                         |
//+------------------------------------------------------------------+
CEntryLineLabel::CEntryLineLabel()
{
   Print(__FUNCTION__);
   //---
   labelName = base.entryLine + "_Label";
   gvSwitchTradeLine = gv.switchTradeLine;
   //---
   if(ObjectFind(0,base.stopLine) >= 0 && ObjectFind(0,base.entryLine) >= 0)
   {
      double stopPrice  = ObjectGetDouble(0,base.stopLine ,OBJPROP_PRICE);
      double entryPrice = ObjectGetDouble(0,base.entryLine,OBJPROP_PRICE);
      //---
      CTradingCalculator cal(stopPrice,entryPrice,base.risk);
      //---
      string orderType = cal.sOrderType;
      double lotsize   = NormalizeDouble(cal.lotsize,2);
      //---
      text = orderType+" : "+(string)lotsize+" Lot";
      //---
      yDistance = GetYDistance(entryPrice);
      xDistance = 10;
      anchor    = ANCHOR_RIGHT_UPPER;
      corner    = CORNER_RIGHT_UPPER;
      clr       = clrWheat;
      fontSize  = 9;
   }
   //---
}
//+------------------------------------------------------------------+
//| Method : SwitchOnOff                                             |
//+------------------------------------------------------------------+
void CEntryLineLabel::SwitchOnOff(void)
{
   CSetLineLabel::SwitchOnOff();
}

