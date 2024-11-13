//+------------------------------------------------------------------+
//|                                                    TradeLine.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//---
#include "Defines\Defines.mqh"
#include "Include\TL_CGlobalVariables.mqh"
#include "Entry\Lines\TL_CSetTradeLine.mqh";
#include "Entry\Lines\TL_CStopLine.mqh"
#include "Entry\Lines\TL_CEntryLine.mqh"
//#include "Entry\Labels\TL_CSetLineLabel.mqh"
//#include "Entry\Labels\TL_CStopLabel.mqh"
//#include "Entry\Labels\TL_CEntryLineLabel.mqh"

//---
CGlobalVariables gv;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   ChartSetInteger(0,CHART_EVENT_OBJECT_CREATE,1);
   ChartSetInteger(0,CHART_EVENT_OBJECT_DELETE,1);
   ChartSetInteger(0,CHART_EVENT_MOUSE_MOVE,1);   
   
   //gv.SetInitSwitchMethod(); //ByMarket   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   //--- EntryLine
   CSetTradeLine *line = new CEntryLine(UPDATE_TRADELINE_PRICE);
   line.UpdateLine();
   delete line;
   //--- StopLabel
   //CSetLineLabel *stopLabel  = new CStopLabel();
   //stopLabel.UpdateLabel();
   //--- EntryLabel
   //CSetLineLabel *entryLabel = new CEntryLineLabel();
   //entryLabel.UpdateLabel();
   //---
   //delete(stopLabel);
   //delete(entryLabel);
}
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{
//---     
   if(id==CHARTEVENT_KEYDOWN)
   {
      switch((int)lparam)
      {
         case KEY_SWITCH_TRADELINE: //#1
         {
            Print("Pressed #1: KEY_SWITCH_TRADELINE"); 
            //--- TradeLine
            CSetTradeLine *gvSwitch = new CSetTradeLine();
            gvSwitch.SetSwitchTradeLine();
            //---
            CSetTradeLine *entryLine  = new CEntryLine();
            entryLine.SwitchOnOff();
            CSetTradeLine *stopLine   = new CStopLine();
            stopLine.SwitchOnOff();
            //--- TradeLineLabel
            //CSetLineLabel *stopLabel  = new CStopLabel();
            //stopLabel.SwitchOnOff();
            //CSetLineLabel *entryLabel = new CEntryLineLabel();
            //entryLabel.SwitchOnOff();
            //---
            delete(gvSwitch);
            delete(stopLine);
            delete(entryLine);
            //delete(gvLineOnOff);
            //delete(stopLabel);
            //delete(entryLabel);
            //---
            ChartRedraw(0);        
         }   
         break; 
         case KEY_SWITCH_TRADE_METHOD: //#2
         {
            Print("Pressed #2: KEY_SWITCH_TRADE_METHOD"); 
            CSetTradeLine *gvSwitch = new CSetTradeLine();
            gvSwitch.SetSwitchTradeMethod();
            //---
            CSetTradeLine *entryLine = new CEntryLine();
            entryLine.SetProperties();
            //---
            delete(gvSwitch);
            delete(entryLine);
            //---
            ChartRedraw(0);
         }
         break;
         case KEY_RESET_TRADELINE: //#3
         {
            Print("Pressed #3: KEY_RESET_TRADELINE");
            CSetTradeLine * stopLine = new CStopLine(RESET_TRADELINE_PRICE);
            stopLine.ResetTradeLine();
            //---
            CSetTradeLine *entryLine = new CEntryLine(RESET_TRADELINE_PRICE);
            entryLine.ResetTradeLine();
            //---
            ChartRedraw(0);
         }
         break;
         default:Print("Pressed unlisted key");
      }
   }
   if(id == CHARTEVENT_OBJECT_DRAG)
   {
      CSetTradeLine *stopLine = new CStopLine();
      stopLine.SetCurrentTradelinePriceForGV();
      //---
      CSetTradeLine *entryLine = new CEntryLine();
      entryLine.SetCurrentTradelinePriceForGV();
      //---
      delete(stopLine);
      delete(entryLine);
   }
}
//+------------------------------------------------------------------+
