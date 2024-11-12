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
      ~CEntryLine(void){}; 
      //---
      //void SwitchOnOff();           
};
//+------------------------------------------------------------------+
//| Chlid Class : Construct                                          |
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
