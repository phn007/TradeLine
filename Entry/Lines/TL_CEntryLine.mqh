#include "TL_CSetTradeLine.mqh"
//+------------------------------------------------------------------+
//| Chlid Class : CEntryLine                                         |
//+------------------------------------------------------------------+
class CEntryLine : public CSetTradeLine
{
   private:
      double GetEntryPrice(double stop);
      void   GetProperties();
   public:
      CEntryLine();
      CEntryLine(TRADELINE_CONSTRUCT con);
      ~CEntryLine(void){}; 
      //---
      //void ResetTradeLine();           
};
//+------------------------------------------------------------------+
// Construct                                                         |
//+------------------------------------------------------------------+
CEntryLine::CEntryLine()
{
//Print(__FUNCTION__);

   lineName = ENTRYLINE_NAME;
   clr      = ENTRYLINE_COLOR;
   //---
   GetProperties();
   gvSwitchTradeLine = gv.GetSwitchTradeLine();//OnOff
}
//---
CEntryLine::CEntryLine(TRADELINE_CONSTRUCT con)
{
   if(gv.GetSwitchTradeLine() != SWITCH_TRADELINE_ON) return;
   //---   
   lineName                   = ENTRYLINE_NAME;
   double stopPrice           = ObjectGetDouble(0,STOPLINE_NAME,OBJPROP_PRICE);
   //---
   SWICTH_METHOD tradeMethod  = gv.GetSwitchMethod();
   //---
   if(con == RESET_TRADELINE_PRICE)
   { 
      linePrice = GetEntryPrice(stopPrice);
   }
   else if(con == UPDATE_TRADELINE_PRICE)
   {
      if(tradeMethod == MARKET)
      {
         linePrice = GetEntryPrice(stopPrice);  
      }
      else if(tradeMethod == PENDING)
      {
         linePrice = gv.GetEntryLinePrice();
      }
   }
   else if( con == SWITCH_TRADE_METHOD)
   {
      //---
      if(tradeMethod == MARKET) // instant order
      {
         text      = ENTRYLINE_MARKET_TEXT;
         select    = ENTRYLINE_UNSELECT;
         //---
         double stopPrice = ObjectGetDouble(0,STOPLINE_NAME,OBJPROP_PRICE);
         linePrice = GetEntryPrice(stopPrice);
      }
      else if(tradeMethod == PENDING) // pending order
      {
         text      = ENTRYLINE_PENDING_TEXT;  
         select    = ENTRYLINE_SELECT;
         //---
         linePrice = gv.GetEntryLinePrice();
      }
   }
}
//+------------------------------------------------------------------+
//| Method : GetProperties                                           |
//+------------------------------------------------------------------+
void CEntryLine::GetProperties(void)
{
   SWICTH_METHOD tradeMethod = gv.GetSwitchMethod();
   //---
   if(tradeMethod == MARKET) // instant order
   {
      //Print(__FUNCTION__," getSwitchMethod() : ",EnumToString(tradeMethod));
      //---
      double stopPrice = ObjectGetDouble(0,STOPLINE_NAME,OBJPROP_PRICE);
      linePrice = GetEntryPrice(stopPrice);
      text      = ENTRYLINE_MARKET_TEXT;
      select    = ENTRYLINE_UNSELECT;
   }
   else if(tradeMethod == PENDING) // pending order
   {
      //Print(__FUNCTION__," getSwitchMethod() : ",EnumToString(tradeMethod));
      double stopPrice = gv.GetStopLinePrice();
      double entryPrice = gv.GetEntryLinePrice();
      linePrice = entryPrice != 0 ? entryPrice : GetEntryPrice(stopPrice);
      text      = ENTRYLINE_PENDING_TEXT;  
      select    = ENTRYLINE_SELECT;
   }
}
//+------------------------------------------------------------------+
//| Method: GetEntryPrice                                            |
//+------------------------------------------------------------------+
double CEntryLine::GetEntryPrice(double stop)
{
   double bid = SymbolInfoDouble(Symbol(),SYMBOL_BID);
   double ask = SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   //---
   if       (stop > ask && stop > bid) return bid;
   else if  (stop < ask && stop < bid) return ask;
   else                  return -1;
}

