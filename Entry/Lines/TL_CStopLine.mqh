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

   public:
      CStopLine();
     ~CStopLine();
     //---
     void SwitchOnOff();
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CStopLine::CStopLine()
{
   gv.GetVars();
   lineName = base.stopLine;   
   //---
   text     = "#SL";
   clr      = clrLime;
   select   = true;   
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CStopLine::~CStopLine()
{
}
//+------------------------------------------------------------------+
void CStopLine::SwitchOnOff(void)
{
   Print(__FUNCTION__);
   linePrice         = GetStopPrice(gv.stopPrice);
   gvSwitchTradeLine = gv.switchTradeLine;
   Print(__FUNCTION__, " gvSwitchTradeLine = ", gvSwitchTradeLine);
   //---
   CSetTradeLine::SwitchOnOff();
}