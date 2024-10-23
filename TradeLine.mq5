//+------------------------------------------------------------------+
//|                                                    TradeLine.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

//--- Include
#include "Entry/TL_CSetEntryObjects.mqh"
#include "Include/TL_CGlobalVariables.mqh"
//--- Entry
#include "Entry/Lines/TL_CSetTradeLine.mqh"
#include "Entry/Lines/TL_CStopLine.mqh"
//---
#include "TurnOnOffTradeLine.mqh"
//--- Key IDs
#define KEY_SWITCH_ONOFF_TRADELINE       49 //#1
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   ChartSetInteger(0,CHART_EVENT_OBJECT_CREATE,1);
   ChartSetInteger(0,CHART_EVENT_OBJECT_DELETE,1);
   ChartSetInteger(0,CHART_EVENT_MOUSE_MOVE,1);      
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
         //#1
         case KEY_SWITCH_ONOFF_TRADELINE: 
         {
            Print("Pressed KEY_SWITCH_ONOFF_TRADELINE");  
            TurnOnOffTradeLine line; 
            line.SwitchOnOff(); 
            ChartRedraw(0);        
         }   
         break;  
         default:Print("Pressed unlisted key");
      }
   }
}
//+------------------------------------------------------------------+
