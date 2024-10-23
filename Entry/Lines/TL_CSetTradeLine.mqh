//+------------------------------------------------------------------+
//|                                              CSetTradeLine.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "../../Include/TL_CGlobalVariables.mqh"
#include "../TL_CSetEntryObjects.mqh"
#include "../../Objects/TL_CHLine.mqh"
//+------------------------------------------------------------------+
//| class                                                            |
//+------------------------------------------------------------------+

class CSetTradeLine
{
   protected:
      CGlobalVariables gv;
      CSetEntryObjects base;
      //---
      string lineName;
      double linePrice;
      string text;
      color  clr;
      bool   select;
      //---
      double gvSwitchTradeLine;
      //--- method
      double GetEntryPrice(double stop);
      double GetStopPrice (double gvStop); 
      //---  
      void CreateLine();
      void DeleteLine(); 
      void SetProperties(); 
   public:
      CSetTradeLine();
     ~CSetTradeLine();
     //---
     virtual void SwitchOnOff();
     //---
     
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSetTradeLine::CSetTradeLine()
{
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CSetTradeLine::~CSetTradeLine()
{
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CSetTradeLine::SwitchOnOff(void)
{
   Print(__FUNCTION__, " gvSwitchTradeLine: ",gvSwitchTradeLine);
   if(gvSwitchTradeLine == 1)
   {
      CreateLine();
      SetProperties();
   }
   else if(gvSwitchTradeLine == 0)
   {
      DeleteLine();
   }
}
//+------------------------------------------------------------------+
//| Method: GetStopPrice                                             |
//+------------------------------------------------------------------+
double CSetTradeLine::GetStopPrice(double gvStop)
{
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
//+------------------------------------------------------------------+
//| Method : CreateLine                                              |
//+------------------------------------------------------------------+
void CSetTradeLine::CreateLine()
{
   CHLine line(lineName);
   line.Create();
}
//+------------------------------------------------------------------+
//| Method : SetProperties                                           |
//+------------------------------------------------------------------+
void CSetTradeLine::SetProperties(void)
{
   Print(__FUNCTION__);
   CHLine line(lineName);
   line.SetText(text);
   line.SetColor(clr);
   line.SetSelectable(select);
   line.SetSelected(select);
   line.SetPrice1(linePrice);  
}
//+------------------------------------------------------------------+
//| Method : DeleteLine                                              |
//+------------------------------------------------------------------+
void CSetTradeLine::DeleteLine(void)
{
   Print(__FUNCTION__);
   if(ObjectFind(0,lineName) >= 0)
   {
      ObjectDelete(0,lineName);   
   }
}