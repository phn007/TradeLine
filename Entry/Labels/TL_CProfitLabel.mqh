#include "TL_CSetLineLabel.mqh"
//+------------------------------------------------------------------+
//| Child Class :  CProfitLabel                                    |
//+------------------------------------------------------------------+
class CProfitLabel : public CSetLineLabel
{
   public:
      CProfitLabel();
      ~CProfitLabel(void){};
      //---
};
//+------------------------------------------------------------------+
//| Child Class :  Construct                                         |
//+------------------------------------------------------------------+
CProfitLabel::CProfitLabel()
{
   //---
   labelName          = PROFITLINE_NAME + "_Label";
   gvSwitchTradeLine  = gv.GetSwitchTradeLine();
   gvSwitchProfitLine = gv.GetSwitchProfitLine();
   //---
   if(ObjectFind(0,STOPLINE_NAME)   >=0 && 
      ObjectFind(0,ENTRYLINE_NAME)  >=0 &&
      ObjectFind(0,PROFITLINE_NAME) >=0)
   {
      //---      
      double stopPrice    = ObjectGetDouble(0,STOPLINE_NAME,  OBJPROP_PRICE);
      double entryPrice   = ObjectGetDouble(0,ENTRYLINE_NAME, OBJPROP_PRICE);
      double profitPrice  = ObjectGetDouble(0,PROFITLINE_NAME,OBJPROP_PRICE);
      //---
      double profitPoints = NormalizeDouble(MathAbs(entryPrice - profitPrice) / Point(),2);
      //---
      CTradingCalculator cal(stopPrice,entryPrice,MONEY_RISK);
      //---
      double usdPerPoint = cal.moneyRisk / cal.points;
      double moneyProfit = NormalizeDouble(usdPerPoint * profitPoints,2);
      //---
      double RRR  = NormalizeDouble(profitPoints / cal.points,2);
      //---
      text = "P/L: "+(string)moneyProfit+" USD ("+(string)profitPoints+") RRR: "+(string)RRR;
      xDistance = 10;
      yDistance = GetYDistance(profitPrice);
      anchor    = ANCHOR_RIGHT_UPPER;
      corner    = CORNER_RIGHT_UPPER;
      clr       = clrWheat;
      fontSize  = 9;
   }
}

  