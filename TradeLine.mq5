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
#include "Include\TL_CValidateMouseMove.mqh"
//---
#include "Entry\Lines\TL_CSetTradeLine.mqh";
#include "Entry\Lines\TL_CStopLine.mqh"
#include "Entry\Lines\TL_CEntryLine.mqh"
#include "Entry\Lines\Tl_CProfitLine.mqh"
#include "Entry\Labels\TL_CSetLineLabel.mqh"
#include "Entry\Labels\TL_CStopLabel.mqh"
#include "Entry\Labels\TL_CEntryLineLabel.mqh"
#include "Entry\RRFib\TL_CRRFib.mqh"
#include "Entry\RRFib\TL_CEntryRRFib.mqh"

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
   //--- EntryLabel
   CSetLineLabel *entryLabel = new CEntryLineLabel();
   entryLabel.UpdateLabel();
   //---
   CRRFib *entryRRFib = new CEntryRRFib();
   entryRRFib.Move();     
   //---   
   delete(line);
   delete(entryLabel);
   delete(entryRRFib);
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
            CSetLineLabel *stopLabel  = new CStopLabel();
            stopLabel.SwitchOnOff();
            CSetLineLabel *entryLabel = new CEntryLineLabel();
            entryLabel.SwitchOnOff();
            //---            
            delete(gvSwitch);
            delete(entryLine);
            delete(stopLine);           
            delete(stopLabel);
            delete(entryLabel);
            //---
            CProfitLine proline;
            proline.ClearLine();
            //---
            CEntryRRFib fib;
            fib.ClearFib();
            ChartRedraw(0); 
            //---                   
         } break; 
         case KEY_SWITCH_TRADE_METHOD: //#2
         {
            Print("Pressed #2: KEY_SWITCH_TRADE_METHOD"); 
            CSetTradeLine *gvSwitch = new CSetTradeLine();
            gvSwitch.SetSwitchTradeMethod();
            //---
            CSetTradeLine *entryLine = new CEntryLine(SWITCH_TRADE_METHOD);
            entryLine.SwitchTradeMethod();
            //---
            delete(gvSwitch);
            delete(entryLine);
            //---
            CSetLineLabel *entryLabel = new CEntryLineLabel();
            entryLabel.UpdateLabel();
            delete(entryLabel);
            //---
            ChartRedraw(0);
            //---            
         } break;
         case KEY_RESET_TRADELINE: //#3
         {
            Print("Pressed #3: KEY_RESET_TRADELINE");
            CSetTradeLine * stopLine = new CStopLine(RESET_TRADELINE_PRICE);
            stopLine.ResetTradeLine();
            //---
            CSetTradeLine *entryLine = new CEntryLine(RESET_TRADELINE_PRICE);
            entryLine.ResetTradeLine();
            //---
            delete(stopLine);
            delete(entryLine);
            //---
            CSetLineLabel *stopLabel = new CStopLabel();
            stopLabel.UpdateLabel();
            CSetLineLabel *entryLabel = new CEntryLineLabel();
            entryLabel.UpdateLabel();
            //---
            delete(stopLabel);            
            delete(entryLabel);
            //---            
            ChartRedraw(0);
            //---            
         } break;
         case KEY_SWITCH_RRFIB: //#F
         {
            Print("Pressed #F: KEY_SWITCH_RRFIB");
            //---            
            CRRFib *gvSwitchRRFib = new CRRFib();
            gvSwitchRRFib.SetSwitchRRFib();
            delete(gvSwitchRRFib);
            //---
            CRRFib *rrfib = new CEntryRRFib();
            rrfib.SwitchOnOff();
            delete(rrfib);  
            //---
            ChartRedraw(0);  
            //---                     
         } break;
         case KEY_SWITCH_PROFITLINE : //#R
         {
            Print("Pressed #R: KEY_SWITCH_PROFITLINE");
            //---
            CSetTradeLine *gvSwitch = new CSetTradeLine();
            gvSwitch.setSwitchProfitLine();
            delete(gvSwitch);
            //---            
            CSetTradeLine *profitLine = new CProfitLine(RRRx1);
            profitLine.SwitchProfitLineOnOff();    
            delete(profitLine);
            //---            
            ChartRedraw(0);
            //---            
         } break;
         case KEY_PROFIT_RRRx0://#numlock0
         {
            Print("Pressed #Numlock 0: KEY_PROFIT_RRRx0");
            //---            
            CSetTradeLine *profitLine = new CProfitLine(RRRx0);
            profitLine.UpdateRatio();
            //---            
            delete(profitLine);
            ChartRedraw(0);
            //---            
         } break;
         case KEY_PROFIT_RRRx1: //#numlock1
         {
            Print("Pressed #Numlock 1: KEY_PROFIT_RRRx1");
            //---            
            CSetTradeLine *profitLine = new CProfitLine(RRRx1);
            profitLine.UpdateRatio();
            //---            
            delete(profitLine);
            ChartRedraw(0);
            //---                     
         } break;
         case KEY_PROFIT_RRRx2: //#numlock2
         {
            Print("Pressed #Numlock 2: KEY_PROFIT_RRRx2");
            //---            
            CSetTradeLine *profitLine = new CProfitLine(RRRx2);
            profitLine.UpdateRatio();
            //---            
            delete(profitLine);
            ChartRedraw(0);
            //---                               
         } break;
         case KEY_PROFIT_RRRx3: //#numlock3
         {
            Print("Pressed #Numlock 3: KEY_PROFIT_RRRx3");
            //---            
            CSetTradeLine *profitLine = new CProfitLine(RRRx3);
            profitLine.UpdateRatio();
            //---            
            delete(profitLine);
            ChartRedraw(0);
            //---                     
         } break;
         case KEY_PROFIT_RRRx4: //#numlock4
         {
            Print("Pressed #Numlock 4: KEY_PROFIT_RRRx4");
            CSetTradeLine *profitLine = new CProfitLine(RRRx4);
            profitLine.UpdateRatio();
            //---            
            delete(profitLine);
            ChartRedraw(0);
            //---         
         } break;
         case KEY_PROFIT_RRRx5: //#numlock5
         {
            Print("Pressed #Numlock 5: KEY_PROFIT_RRRx5");
            CSetTradeLine *profitLine = new CProfitLine(RRRx5);
            profitLine.UpdateRatio();
            //---            
            delete(profitLine);
            ChartRedraw(0);
            //---         
         } break;
         case KEY_PROFIT_RRRx6: //#numlock6
         {
            Print("Pressed #Numlock 6: KEY_PROFIT_RRRx6");
            CSetTradeLine *profitLine = new CProfitLine(RRRx6);
            profitLine.UpdateRatio();
            //---            
            delete(profitLine);
            ChartRedraw(0);
            //---         
         } break;
         case KEY_PROFIT_RRRx7: //#numlock7
         {
            Print("Pressed #Numlock 7: KEY_PROFIT_RRRx7");
            CSetTradeLine *profitLine = new CProfitLine(RRRx7);
            profitLine.UpdateRatio();
            //---            
            delete(profitLine);
            ChartRedraw(0);
            //---         
         } break;
         case KEY_PROFIT_RRRx8: //#numlock8
         {
            Print("Pressed #Numlock 8: KEY_PROFIT_RRRx8");
            CSetTradeLine *profitLine = new CProfitLine(RRRx8);
            profitLine.UpdateRatio();
            //---            
            delete(profitLine);
            ChartRedraw(0);
            //---
         } break;
         case KEY_PROFIT_RRRx9: //#numlock9
         {
            Print("Pressed #Numlock 9: KEY_PROFIT_RRRx9");
            CSetTradeLine *profitLine = new CProfitLine(RRRx9);
            profitLine.UpdateRatio();
            //---            
            delete(profitLine);
            ChartRedraw(0);
            //---         
         } break;
         default:Print("Pressed unlisted key lparame: ",lparam); break;
      }
      
   }
   if(id == CHARTEVENT_OBJECT_DRAG)
   {
      Print("CHARTEVENT_OBJECT_DRAG");
      CSetTradeLine *stopLine = new CStopLine();
      stopLine.SetCurrentTradelinePriceForGV();
      //---
      CSetTradeLine *entryLine = new CEntryLine();
      entryLine.SetCurrentTradelinePriceForGV();
      //---
      delete(stopLine);
      delete(entryLine);
      //---
      CSetLineLabel *stopLabel = new CStopLabel();
      stopLabel.UpdateLabel();
      CSetLineLabel *entryLabel = new CEntryLineLabel();
      entryLabel.UpdateLabel();
      //---
      delete(entryLabel);
      delete(stopLabel);
      //---
      CRRFib *entryRRFib = new CEntryRRFib();
      entryRRFib.Move();
      delete(entryRRFib);
      //--- 
      CSetTradeLine *profitLine = new CProfitLine();
      profitLine.SetCurrentTradelinePriceForGV();        
      delete(profitLine);
      //---      
      ChartRedraw(0);
   }
   if(id == CHARTEVENT_MOUSE_MOVE)
   {
      if((int)sparam == MOUSEMOVE_ACTION_CLICK_DRAG)
      {
         CHLineMouseMove stopLine (dparam,STOPLINE_NAME); 
         CHLineMouseMove entryLine(dparam,ENTRYLINE_NAME);
         //---
         if(stopLine.MoveAllowed()  == true || 
            entryLine.MoveAllowed() == true )
         {
            CSetLineLabel *stopLabel = new CStopLabel();
            stopLabel.UpdateLabel();
            CSetLineLabel *entryLabel = new CEntryLineLabel();
            entryLabel.UpdateLabel();
            //---
            CRRFib *entryRRFib = new CEntryRRFib();
            entryRRFib.Move();              
            //---                   
            delete(stopLabel);
            delete(entryLabel);
            delete(entryRRFib);
         }               
      }
   }
}
//+------------------------------------------------------------------+
