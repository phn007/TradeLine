//+------------------------------------------------------------------+
//|                                              CSetTradeLine.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "../../Include/TL_CGlobalVariables.mqh"
#include "../../Objects/TL_CHLine.mqh"
//+------------------------------------------------------------------+
//| class                                                            |
//+------------------------------------------------------------------+

class CSetTradeLine
{
   protected:
      CGlobalVariables gv;
      //---
      string lineName;
      double linePrice;
      string text;
      color  clr;
      bool   select;
      //---
      SWITCH_TRADELINE gvSwitchTradeLine;
   private:  
      void CreateLine();
      void DeleteLine();  
   public:
      CSetTradeLine(){};
     ~CSetTradeLine(){};
     //---
     void SwitchOnOff();
     void UpdateLine();
     void SetCurrentTradelinePriceForGV();
     void SetSwitchTradeLine();
     void SetSwitchTradeMethod();
     void SetProperties();
     //---
     void ResetTradeLine();
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CSetTradeLine::SetSwitchTradeLine(void)
{
   //---
   gv.SetSwitchOnOff(TRADELINE);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CSetTradeLine::SetSwitchTradeMethod(void)
{
   gv.SetSwitchOnOff(METHOD);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CSetTradeLine::SwitchOnOff(void)
{
   //---
   if(gvSwitchTradeLine == CREATE_TRADELINE)
   {
      Print(__FUNCTION__, " gvSwitchTradeLine: ",EnumToString(gvSwitchTradeLine)," | ",lineName);
      CreateLine();
      SetProperties();
   }
   else if(gvSwitchTradeLine == DELETE_TRADELINE)
   {
      Print(__FUNCTION__, " gvSwitchTradeLine: ",EnumToString(gvSwitchTradeLine)," | ",lineName);
      DeleteLine();
   }
}

//+------------------------------------------------------------------+
//| Method : CreateLine                                              |
//+------------------------------------------------------------------+
void CSetTradeLine::CreateLine()
{
   //Print(__FUNCTION__," lineName: ",lineName);
   CHLine line(lineName);
   line.Create();
}
//+------------------------------------------------------------------+
//| Method : SetProperties                                           |
//+------------------------------------------------------------------+
void CSetTradeLine::SetProperties(void)
{
   //Print(__FUNCTION__);
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
   //Print(__FUNCTION__);
   if(ObjectFind(0,lineName) >= 0)
   {
      ObjectDelete(0,lineName);   
   }
}
//+------------------------------------------------------------------+
//| Method : UpdateLine                                              |
//+------------------------------------------------------------------+
void CSetTradeLine::UpdateLine(void)
{
   Print(__FUNCTION__);
   CHLine line(lineName);
   line.SetPrice1(linePrice);
}
//+------------------------------------------------------------------+
//| Update Current TradeLine Price to GV                             |
//+------------------------------------------------------------------+
void CSetTradeLine::SetCurrentTradelinePriceForGV(void)
{
   gv.SetPriceLineVariable(lineName);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CSetTradeLine::ResetTradeLine(void)
{
   Print(__FUNCTION__," name: ", lineName," | price: ", linePrice);
   CHLine line(lineName);
   line.SetPrice1(linePrice);
   //---
   SetCurrentTradelinePriceForGV();
}
