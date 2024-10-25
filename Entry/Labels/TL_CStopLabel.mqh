//+------------------------------------------------------------------+
//|                                                TL_CStopLabel.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//---
#include "TL_CSetLineLabel.mqh"
//+------------------------------------------------------------------+
//| Child Class :  CStopLabel                                    |
//+------------------------------------------------------------------+
class CStopLabel : public CSetLineLabel
{
   public:
      CStopLabel();
      ~CStopLabel(void){};
      //---
      void SwitchOnOff();//override
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CStopLabel::CStopLabel()
{ 
   gv.GetVars();
   //---
   labelName         = base.stopLine + "_Label";
   gvSwitchTradeLine = gv.switchTradeLine;
   //---

  
   if(ObjectFind(0,base.stopLine) >= 0 && ObjectFind(0,base.entryLine) >= 0)
   {
      double stopPrice  = ObjectGetDouble(0,base.stopLine ,OBJPROP_PRICE);
      double entryPrice = ObjectGetDouble(0,base.entryLine,OBJPROP_PRICE);
      //---
      CTradingCalculator cal(stopPrice,entryPrice,base.risk);
      //---
      double points    = NormalizeDouble(cal.points,2);
      double moneyRisk = NormalizeDouble(cal.moneyRisk,2);
      //---
      text        = "P/L: "+(string)moneyRisk+" USD ("+(string)points+")";
      xDistance   = 10;
      yDistance   = GetYDistance(stopPrice);
      anchor      = ANCHOR_RIGHT_UPPER;
      corner      = CORNER_RIGHT_UPPER;
      clr         = clrWheat;
      fontSize    = 9;
      //---
   }
}
void CStopLabel::SwitchOnOff(void)
{
   CSetLineLabel::SwitchOnOff();
}

