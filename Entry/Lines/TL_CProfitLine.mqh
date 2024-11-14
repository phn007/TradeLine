#include "TL_CSetTradeLine.mqh"
//+------------------------------------------------------------------+
//| Chlid Class : CProfitLine                                        |
//+------------------------------------------------------------------+
class CProfitLine : public CSetTradeLine
{
   private:
      //---
      double stopPrice;
      double entryPrice;
      double profitPrice;
      double diffPrice;
      //---
      void SetLinePriceByRRR(RISK_REWARD_RATIO ratio);
   public:
      CProfitLine(RISK_REWARD_RATIO ratio);
      CProfitLine();
      ~CProfitLine(void){};
      //--  
      void UpdateRatio(); 
      void ClearLine();
};
//+------------------------------------------------------------------+
//| Method : Construct                                               |
//+------------------------------------------------------------------+
CProfitLine::CProfitLine(void)
{
   gvSwitchProfitLine = gv.GetSwitchProfitLine();//OnOff
   //---   
   lineName = PROFITLINE_NAME;
   text     = PROFITLINE_TEXT;
   clr      = PROFITLINE_COLOR;
   select   = PROFITLINE_SELECT;
}
CProfitLine::CProfitLine(RISK_REWARD_RATIO ratio)
{ 
   gvSwitchProfitLine = gv.GetSwitchProfitLine();//OnOff
   //---   
   lineName = PROFITLINE_NAME;
   text     = PROFITLINE_TEXT;
   clr      = PROFITLINE_COLOR;
   select   = PROFITLINE_SELECT; 
   //---
   SetLinePriceByRRR(ratio);
//---
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CProfitLine::SetLinePriceByRRR(RISK_REWARD_RATIO ratio)
{
   stopPrice  = ObjectGetDouble(0,STOPLINE_NAME,OBJPROP_PRICE);
   entryPrice = ObjectGetDouble(0,ENTRYLINE_NAME,OBJPROP_PRICE);
   diffPrice  = MathAbs(entryPrice - stopPrice) * ratio; 
   //--- Buy Side
   if(stopPrice < entryPrice)
   {
      linePrice = entryPrice + diffPrice;
   }
   //--- Sell Side
   else if(stopPrice > entryPrice) 
   {
      linePrice = entryPrice - diffPrice;
   } 
   //--- Error     
   else 
   {
      linePrice = -1;
   }   
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CProfitLine::UpdateRatio(void)
{
   Print(__FUNCTION__);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CProfitLine::ClearLine(void)
{
   if(gv.GetSwitchTradeLine() == SWITCH_TRADELINE_OFF)
   {
      Print(__FUNCTION__," SWITCH_TRADELINE_OFF");
      //---      
      if(gv.GetSwitchProfitLine() == SWITCH_PROFITLINE_ON)
      {
         Print(__FUNCTION__," SWITCH_PROFITLINE_ON -> Delete ProfitLine");
         //---         
         if(ObjectFind(0,lineName) >= 0)
         {
            ObjectDelete(0,lineName);  
            gv.SetSwitchOnOff(PROFITLINE); 
         }
      }
   }
   
}
