//+------------------------------------------------------------------+
//|                                           CGlobalVariables.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//---
#include "../Defines/Defines.mqh"
//+------------------------------------------------------------------+
//| Class                                                            |
//+------------------------------------------------------------------+
class CGlobalVariables
{
   //--- Variables
   public:
      string switchMethodName;
      string switchTradeLineName;
      string switchRRFibName;
      string switchProfitLineName;
      //---      
      string gvStopLineName;
      string gvEntryLineName;
      string gvProfitLineName;
      //---
      double switchTradeLine;
      double switchMethod;
      double switchRRFib;
      double switchProfitLine;
      //---      
      double stopPrice;
      double entryPrice;
      double profitPrice;
   //--- method
   private:
      void SetSwitchVariables(string name);
   public:
      CGlobalVariables();
      ~CGlobalVariables(){};
      //---
      void SetInitSwitchMethod();
      void SetSwitchOnOff(SWITCH_TYPE type);
      //---
      void SetPriceLineVariable(string name);
      //---
      SWICTH_METHOD     GetSwitchMethod();
      SWITCH_TRADELINE  GetSwitchTradeLine();
      SWITCH_RRFIB      GetSwitchRRFib();
      SWITCH_PROFITLINE GetSwitchProfitLine();
      //---
      double GetStopLinePrice();
      double GetEntryLinePrice();
      double GetProfitLinePrice();
};
//+------------------------------------------------------------------+
//|  Construct                                                       |
//+------------------------------------------------------------------+

CGlobalVariables::CGlobalVariables(void)
{
   switchMethodName     = "TL_P3121_Trade_Method_Switch_OnOff";
   switchTradeLineName  = "TL_P3121_TradeLine_Switch_OnOff";
   switchRRFibName      = "TL_P3121_RRFib_Switch_OnOff";
   switchProfitLineName = "TL_P3121_ProfitLine_Switch_OnOff";
   //---   
   gvStopLineName       = "TL_" + Symbol() + "_" + STOPLINE_NAME;
   gvEntryLineName      = "TL_" + Symbol() + "_" + ENTRYLINE_NAME;
   gvProfitLineName     = "TL_" + Symbol() + "_" + PROFITLINE_NAME;
   //---
   switchTradeLine  = NULL;
   switchMethod     = NULL;
   switchRRFib      = NULL;
   switchProfitLine = NULL;
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
      case TRADELINE    : SetSwitchVariables(switchTradeLineName);   break;
      case METHOD       : SetSwitchVariables(switchMethodName);      break;
      case RRFIB        : SetSwitchVariables(switchRRFibName);       break;
      case PROFITLINE   : SetSwitchVariables(switchProfitLineName);  break;
   }
}
//+------------------------------------------------------------------+
//| Method: SetSwitchVariables                                       |
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
//| StopLinePrice                                                    |
//+------------------------------------------------------------------+
double CGlobalVariables::GetStopLinePrice(void)
{
   if(GlobalVariableGet(gvStopLineName,stopPrice))
   {
      return stopPrice; 
   } 
   else return 0;
}
//+------------------------------------------------------------------+
//|  EntryLinePrice                                                  |
//+------------------------------------------------------------------+
double CGlobalVariables::GetEntryLinePrice(void)
{
   if(GlobalVariableGet(gvEntryLineName,entryPrice))
   {
      return entryPrice;
   }
   else return 0;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CGlobalVariables::GetProfitLinePrice(void)
{
   if(GlobalVariableGet(gvProfitLineName,profitPrice))
   {
      return profitPrice;
   }
   else return 0;
}
//+------------------------------------------------------------------+
//| SwitchMethod                                                     |
//+------------------------------------------------------------------+
//*
SWICTH_METHOD CGlobalVariables::GetSwitchMethod()
{
   switchMethod = GlobalVariableGet(switchMethodName);
   //Print(__FUNCTION__," switchMethod: ",switchMethod);
   //---
   
   if(switchMethod == 0)        return PENDING;
   else if(switchMethod == 1)   return MARKET;
   else                         return NONE;
}
//*/
//+------------------------------------------------------------------+
//| SwitchTradeLine                                                  |
//+------------------------------------------------------------------+
SWITCH_TRADELINE CGlobalVariables::GetSwitchTradeLine(void)
{
   switchTradeLine = GlobalVariableGet(switchTradeLineName);
   //---
   if(switchTradeLine == 0)      return SWITCH_TRADELINE_OFF;
   else if(switchTradeLine == 1) return SWITCH_TRADELINE_ON;
   else                          return SWITCH_TRADELINE_NONE;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
SWITCH_RRFIB CGlobalVariables::GetSwitchRRFib(void)
{
   switchRRFib = GlobalVariableGet(switchRRFibName);
   //---
   if(switchRRFib == 0)       return SWITCH_RRFIB_OFF;
   else if(switchRRFib == 1)  return SWITCH_RRFIB_ON;
   else                       return SWITCH_RRFIB_NONE;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
SWITCH_PROFITLINE CGlobalVariables::GetSwitchProfitLine(void)
{
   switchProfitLine = GlobalVariableGet(switchProfitLineName);
   if(switchProfitLine == 0)        return SWITCH_PROFITLINE_OFF;
   else if(switchProfitLine == 1)   return SWITCH_PROFITLINE_ON;
   else                             return SWITCH_PROFITLINE_NONE;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CGlobalVariables::SetPriceLineVariable(string name)
{
   double price = 0;
   string gvLineName = NULL;
   //---
   if       (name == STOPLINE_NAME)    gvLineName = gvStopLineName;
   else if  (name == ENTRYLINE_NAME)   gvLineName = gvEntryLineName; 
   else if  (name == PROFITLINE_NAME)  gvLineName = gvProfitLineName; 
   //---
   if(gvLineName != NULL)
   {
      price = ObjectGetDouble(0,name,OBJPROP_PRICE);
      GlobalVariableSet(gvLineName,price);
   }
}