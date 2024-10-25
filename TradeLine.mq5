//+------------------------------------------------------------------+
//|                                                    TradeLine.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//---
#include "Include/TL_CGlobalVariables.mqh"
#include "Entry/TL_CSetEntryObjects.mqh"
#include "Entry/Lines/TL_CSetTradeLine.mqh";
#include "Entry/Lines/TL_CStopLine.mqh"
#include "Entry/Lines/TL_CEntryLine.mqh"
#include "Entry/Labels/TL_CSetLineLabel.mqh"
#include "Entry/Labels/TL_CStopLabel.mqh"
#include "Entry/Labels/TL_CEntryLineLabel.mqh"

//--- Key IDs
#define KEY_SWITCH_ONOFF_TRADELINE 49  //ChartEvent_Keydown #1
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
   //--- EntryLine
   CSetTradeLine *line = new CEntryLine();
   line.UpdateLine();
   delete line;
   //--- StopLabel
   CSetLineLabel *stopLabel = new CStopLabel();
   stopLabel.UpdateLabel();
   //--- EntryLabel
   CSetLineLabel *entryLabel = new CEntryLineLabel();
   entryLabel.UpdateLabel();
   //---
   delete(stopLabel);
   delete(entryLabel);
   

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
         case KEY_SWITCH_ONOFF_TRADELINE: //#1
         {
            Print("Pressed #1: KEY_SWITCH_ONOFF_TRADELINE"); 
            //--- GlobalVariables
            CGlobalVariables gv;
            gv.SetInitSwitchMethod();     //ByMarket
            gv.SetSwitchOnOff(TRADELINE); //On
            //--- TradeLine
            CSetTradeLine *entryLine  = new CEntryLine();
            entryLine.SwitchOnOff();
            CSetTradeLine *stopLine   = new CStopLine();
            stopLine.SwitchOnOff();
            //--- TradeLineLabel
            CSetLineLabel *stopLabel  = new CStopLabel();
            stopLabel.SwitchOnOff();
            CSetLineLabel *entryLabel = new CEntryLineLabel();
            entryLabel.SwitchOnOff();
            //---
            delete(entryLine);
            delete(stopLine);
            delete(stopLabel);
            delete(entryLabel);
            //---
            ChartRedraw(0);        
         }   
         break;  
         default:Print("Pressed unlisted key");
      }
   }
   if(id == CHARTEVENT_OBJECT_DRAG)
   {
   
   }
}
//+------------------------------------------------------------------+
