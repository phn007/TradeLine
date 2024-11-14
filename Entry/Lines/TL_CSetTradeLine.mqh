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
      SWITCH_TRADELINE  gvSwitchTradeLine;
      SWITCH_PROFITLINE gvSwitchProfitLine;
   private:  
      void CreateLine();
      void DeleteLine();  
   public:
      CSetTradeLine(){};
     ~CSetTradeLine(){};
     //---
     void SwitchOnOff();
     void UpdateLine();
     void SetCurrentTradelinePriceForGV();   //Global Variable
     void SetSwitchTradeLine();              //Global Variable
     void SetSwitchTradeMethod();            //Global Variable
     void setSwitchProfitLine();             //Global Variable
     void SetProperties();
     //---
     void ResetTradeLine();
     void SwitchTradeMethod();
     void SwitchProfitLineOnOff();
     //---
     virtual void UpdateRatio(){};
     
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CSetTradeLine::setSwitchProfitLine(void)
{
   gv.SetSwitchOnOff(PROFITLINE);
}
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
void CSetTradeLine::SwitchProfitLineOnOff(void)
{
   if(gvSwitchTradeLine == SWITCH_TRADELINE_ON)
   {
      if(gvSwitchProfitLine == SWITCH_PROFITLINE_ON)
      {
         CreateLine();
         SetProperties();
         SetCurrentTradelinePriceForGV();
      }
      else if(gvSwitchProfitLine == SWITCH_PROFITLINE_OFF)
      {
         DeleteLine();
      }
   }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CSetTradeLine::SwitchOnOff(void)
{
   //---
   if(gvSwitchTradeLine == SWITCH_TRADELINE_ON)
   {
      CreateLine();
      SetProperties();
      SetCurrentTradelinePriceForGV();
   }
   else if(gvSwitchTradeLine == SWITCH_TRADELINE_OFF)
   {
      DeleteLine();
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
   if(gv.GetSwitchMethod() == MARKET)
   {
      CHLine line(lineName);
      line.SetPrice1(linePrice);
      SetCurrentTradelinePriceForGV();
   }  
}
//+------------------------------------------------------------------+
//| Update Current TradeLine Price to GV                             |
//+------------------------------------------------------------------+
void CSetTradeLine::SetCurrentTradelinePriceForGV(void)
{
   //Print(__FUNCTION__," lineName: ",lineName," | linePrice: ", linePrice);
   gv.SetPriceLineVariable(lineName);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CSetTradeLine::ResetTradeLine(void)
{
   CHLine line(lineName);
   line.SetPrice1(linePrice);
   //---
   SetCurrentTradelinePriceForGV();
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CSetTradeLine::SwitchTradeMethod(void)
{
   CHLine line(lineName);
   line.SetText(text);
   line.SetSelectable(select);
   line.SetSelected(select);
   line.SetPrice1(linePrice);
   //---   
   SetCurrentTradelinePriceForGV();
}
