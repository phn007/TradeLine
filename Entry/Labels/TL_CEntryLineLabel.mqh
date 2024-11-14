#include "TL_CSetLineLabel.mqh"
//+------------------------------------------------------------------+
//| Child Class :  CEntryLineLabel                                    |
//+------------------------------------------------------------------+
class CEntryLineLabel : public CSetLineLabel
{
   public:
      CEntryLineLabel();
      ~CEntryLineLabel(void){};
};
//+------------------------------------------------------------------+
//| Child Class :  Construct                                         |
//+------------------------------------------------------------------+
CEntryLineLabel::CEntryLineLabel()
{
   //Print(__FUNCTION__);
   //---
   labelName = ENTRYLINE_NAME + "_Label";
   gvSwitchTradeLine = gv.GetSwitchTradeLine();
   //---
   if(ObjectFind(0,STOPLINE_NAME) >= 0 && ObjectFind(0,ENTRYLINE_NAME) >= 0)
   {
      double stopPrice  = ObjectGetDouble(0,STOPLINE_NAME ,OBJPROP_PRICE);
      double entryPrice = ObjectGetDouble(0,ENTRYLINE_NAME,OBJPROP_PRICE);
      //---
      CTradingCalculator cal(stopPrice,entryPrice,MONEY_RISK);
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


