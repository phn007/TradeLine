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
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CStopLabel::CStopLabel()
{ 
   //---
   labelName         = STOPLINE_NAME + "_Label";
   gvSwitchTradeLine = gv.GetSwitchTradeLine();
   //---
   if(ObjectFind(0,STOPLINE_NAME) >= 0 && ObjectFind(0,ENTRYLINE_NAME) >= 0)
   {
      CPositionSizeCalculator post(MONEY_RISK);
      post.Calculate();
      double points    = NormalizeDouble(post.points,2);
      double moneyRisk = NormalizeDouble(post.riskPerTrade,2);
      //---
      text        = "P/L: "+(string)moneyRisk+" USD ("+(string)points+")";
      xDistance   = 10;
      yDistance   = GetYDistance(post.stopPrice);
      anchor      = ANCHOR_RIGHT_UPPER;
      corner      = CORNER_RIGHT_UPPER;
      clr         = clrWheat;
      fontSize    = 9;
   }
}
