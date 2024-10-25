//+------------------------------------------------------------------+
//|                                           CGlobalVariables.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "../Entry/TL_CSetEntryObjects.mqh"
//+------------------------------------------------------------------+
//| ENUM                                                             |
//+------------------------------------------------------------------+
enum SWITCH_TYPE { METHOD,TRADELINE,PANEL,RRFIB,PROLINE };

//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class CGlobalVariables
{
   private:
      CSetEntryObjects base;
   //--- Variables
   public:
      string switchMethodName;
      string switchTradeLineName;
      string gvStopName;
      string gvEntryName;
      //---
      double switchTradeLine;
      double switchMethod;
      double stopPrice;
      double entryPrice;
   //--- method
   private:
      void SetSwitchVariables(string name);
   public:
      CGlobalVariables();
      ~CGlobalVariables(){};
      //---
      void SetInitSwitchMethod();
      void SetSwitchOnOff(SWITCH_TYPE type);
      void SetPriceLineVars(string name);
      void GetVars();
};
//+------------------------------------------------------------------+
//|  Construct                                                       |
//+------------------------------------------------------------------+

CGlobalVariables::CGlobalVariables(void)
{
   switchMethodName     = "TL_P3121_OrderMethod_Switch_OnOff";
   switchTradeLineName  = "TL_P3121_TradeLine_Switch_OnOff";
   gvStopName           = "TL_GV3121_" + Symbol() + "_" + base.stopLine;
   gvEntryName          = "TL_GV3121_" + Symbol() + "_" + base.entryLine;
   //---
   switchTradeLine  = NULL;
   switchMethod     = NULL;
   stopPrice        = NULL;
   entryPrice       = NULL;
   
}
//+------------------------------------------------------------------+
//| Method: SetInitSwitchMethod                                      |
//+------------------------------------------------------------------+
void CGlobalVariables::SetInitSwitchMethod(void)
{
   if(!GlobalVariableCheck(switchMethodName))
   {
      GlobalVariableSet(switchMethodName,1);
   }      
}
//+------------------------------------------------------------------+
//| Method: SetSwitchOnOff                                           |
//+------------------------------------------------------------------+
void CGlobalVariables::SetSwitchOnOff(SWITCH_TYPE type)
{
   switch(type)
   {
      case TRADELINE : SetSwitchVariables(switchTradeLineName);    break;
   }
}
//+------------------------------------------------------------------+
//| Method: SetVariables                                             |
//+------------------------------------------------------------------+
void CGlobalVariables::SetSwitchVariables(string name)
{
   if(!GlobalVariableCheck(name))
   {
      GlobalVariableSet(name,1);
   }
   else
   {
      if(GlobalVariableGet(name) == 0)
      {    
         GlobalVariableSet(name,1);
      }
      else
      {
         GlobalVariableSet(name,0);
      }
   }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CGlobalVariables::GetVars(void)
{
   stopPrice       = GlobalVariableGet(gvStopName);
   entryPrice      = GlobalVariableGet(gvEntryName);
   switchMethod    = GlobalVariableGet(switchMethodName);
   switchTradeLine = GlobalVariableGet(switchTradeLineName);
}
//+------------------------------------------------------------------+
//| Method: SetPriceLineVars                                         |
//+------------------------------------------------------------------+
void CGlobalVariables::SetPriceLineVars(string name)
{
   //Print(__FUNCTION__," Line Name: ",name);
   double price = 0;
   if(name == base.stopLine)
   {
      if(ObjectFind(0,base.stopLine) >= 0)
      {
         price = ObjectGetDouble(0,base.stopLine,OBJPROP_PRICE);
         //Print(__FUNCTION__," Line Name: ",name," Price: ",price);
         GlobalVariableSet(gvStopName,price);
      }
   }
   else if(name == base.entryLine)
   {
      if(ObjectFind(0,base.entryLine) >= 0)
      {
         price = ObjectGetDouble(0,base.entryLine,OBJPROP_PRICE);
         //Print(__FUNCTION__," Line Name: ",name," Price: ",price);
         GlobalVariableSet(gvEntryName,price);
      }
   }
   /*else if(name == base.profitLine)
   {
      if(ObjectFind(0,base.profitLine) >= 0)
      {
         price = ObjectGetDouble(0,base.profitLine,OBJPROP_PRICE);
         GlobalVariableSet(gvProfitName,price);
      }
   }
   */    
}