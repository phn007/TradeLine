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
//*
   lineName = ENTRYLINE_NAME;
   clr      = ENTRYLINE_COLOR;
   //---
   GetProperties();
   gvSwitchTradeLine = gv.getSwitchTradeLine();
   
   Print(__FUNCTION__," lineName: ", lineName,
   " | linePrice: ",linePrice,
   " | gvSwitchTradeLine: ",EnumToString(gv.getSwitchTradeLine()));
   //*/
}
//---
CEntryLine::CEntryLine(TRADELINE_CONSTRUCT con)
{
   lineName  = ENTRYLINE_NAME;
   //---
   double         stopPrice  = ObjectGetDouble(0,STOPLINE_NAME,OBJPROP_PRICE);
   SWICTH_METHOD tradeMethod = gv.getSwitchMethod();
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
   }
   //---
   Print(__FUNCTION__,
   " Constructor: ",EnumToString(con),
   " | TradeMethod: ",EnumToString(tradeMethod),
   " | lineName: ",lineName,
   " | price: ",linePrice);
   //---

}
//+------------------------------------------------------------------+
//| Method : GetProperties                                           |
//+------------------------------------------------------------------+
void CEntryLine::GetProperties(void)
{
   SWICTH_METHOD tradeMethod = gv.getSwitchMethod();
   //---
   if(tradeMethod == MARKET) // instant order
   {
      Print(__FUNCTION__," getSwitchMethod() : ",EnumToString(tradeMethod));
      //---
      double stopPrice = ObjectGetDouble(0,STOPLINE_NAME,OBJPROP_PRICE);
      linePrice = GetEntryPrice(stopPrice);
      text      = ENTRYLINE_MARKET_TEXT;
      select    = ENTRYLINE_UNSELECT;
   }
   else if(tradeMethod == PENDING) // pending order
   {
      Print(__FUNCTION__," getSwitchMethod() : ",EnumToString(tradeMethod));
      double stopPrice = gv.getStopLinePrice();
      double entryPrice = gv.getEntryLinePrice();
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
