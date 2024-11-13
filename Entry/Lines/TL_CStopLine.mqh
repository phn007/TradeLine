//+------------------------------------------------------------------+
//|                                                  CStopLine.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//---
#include "TL_CSetTradeLine.mqh"
//+------------------------------------------------------------------+
//| class                                                            |
//+------------------------------------------------------------------+
class CStopLine : public CSetTradeLine
{
   private:
      double GetStopPrice (double gvStop);        
   public:
      CStopLine();
      CStopLine(TRADELINE_CONSTRUCT con);
     ~CStopLine(){};
     //---
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CStopLine::CStopLine(TRADELINE_CONSTRUCT con)
{
   Print(__FUNCTION__," Constructor: ",EnumToString(con));
   lineName = STOPLINE_NAME; 
   
   double point = SymbolInfoDouble(Symbol(),SYMBOL_POINT);
   double bid   = SymbolInfoDouble(Symbol(),SYMBOL_BID);
   //---
   linePrice    = NormalizeDouble(bid + 10 * point,Digits());
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CStopLine::CStopLine()
{
   
//*
   lineName = STOPLINE_NAME;  
   //---
   text     = STOPLINE_TEXT;
   clr      = STOPLINE_COLOR;
   select   = STOPLINE_SELECT;   
   
   linePrice         = GetStopPrice(gv.getStopLinePrice());
   gvSwitchTradeLine = gv.getSwitchTradeLine();
   
   Print(__FUNCTION__," lineName: ", lineName,
   " | linePrice: ",linePrice,
   " | gvSwitchTradeLine: ",EnumToString(gv.getSwitchTradeLine()));
   //*/
}
//+------------------------------------------------------------------+
//| Method: GetStopPrice                                             |
//+------------------------------------------------------------------+
double CStopLine::GetStopPrice(double gvStop)
{
   //Print(__FUNCTION__," gvStop: ",gvStop);
   if(gvStop == 0)
   {
      double point = SymbolInfoDouble(Symbol(),SYMBOL_POINT);
      double bid   = SymbolInfoDouble(Symbol(),SYMBOL_BID);
      //---
      return NormalizeDouble(bid + 10 * point,Digits());
   }
   else
   {
      return gvStop;
   }   
}
