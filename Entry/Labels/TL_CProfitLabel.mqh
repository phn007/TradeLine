#include "TL_CSetLineLabel.mqh"
//+------------------------------------------------------------------+
//| Child Class :  CProfitLabel                                    |
//+------------------------------------------------------------------+
class CProfitLabel : public CSetLineLabel
{
   private:
      double stopPrice;
      double entryPrice;
      double profitPrice;
      //---      
      double GetProfitPoints();
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
   //--- start
   double profitPoints = GetProfitPoints();
   if(profitPoints > 0)
   {
      CPositionSizeCalculator post(MONEY_RISK);
      post.Calculate();
      //---
      double usdPerPoint = post.riskPerTrade / post.points;
      double moneyProfit = NormalizeDouble(usdPerPoint * profitPoints,2);
      //---
      double RRR  = NormalizeDouble(profitPoints / post.points,2);
      //---
      text = "P/L: "+(string)moneyProfit+" USD ("+(string)profitPoints+") RRR: "+(string)RRR;
      clr  = clrWheat;  
   }
   else
   {
      text = "Invalid( profitPoints: " + DoubleToString(profitPoints) + ")";
      clr  = clrRed;
   }
   //--- end
   xDistance = 10;
   yDistance = GetYDistance(profitPrice);
   anchor    = ANCHOR_RIGHT_UPPER;
   corner    = CORNER_RIGHT_UPPER;
   fontSize  = 9;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CProfitLabel::GetProfitPoints(void)
{
   double profitPoints = -1;
   if(ObjectFind(0,STOPLINE_NAME)   >=0 && 
      ObjectFind(0,ENTRYLINE_NAME)  >=0 &&
      ObjectFind(0,PROFITLINE_NAME) >=0)
   {
      //---      
      stopPrice    = ObjectGetDouble(0,STOPLINE_NAME,  OBJPROP_PRICE);
      entryPrice   = ObjectGetDouble(0,ENTRYLINE_NAME, OBJPROP_PRICE);
      profitPrice  = ObjectGetDouble(0,PROFITLINE_NAME,OBJPROP_PRICE);
      //--- Buy Side
      if(stopPrice < entryPrice)
      {
         //Print(__FUNCTION__," Buy Side : profitPrice - entryPrice = ",profitPrice - entryPrice);
         profitPoints = NormalizeDouble((profitPrice - entryPrice) / Point(),2);
      }
      //--- Sell Side
      else if(stopPrice > entryPrice) 
      {
         //Print(__FUNCTION__," Sell Side : entryPrice - ProfitPrice = ",entryPrice - profitPrice);
         profitPoints = NormalizeDouble((entryPrice - profitPrice) / Point(),2);
      } 
      //--- Error     
      else 
      {
         profitPoints = -1;
      } 
   }
   return profitPoints; 
}

  