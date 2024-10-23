//+------------------------------------------------------------------+
//|                                           CSetEntryObjects.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
class CSetEntryObjects
{
   public:
      string stopLine;
      string entryLine;
      string profitLine;
      string entryFib;
      double risk;
   public:
      CSetEntryObjects()
      {
         stopLine   = "P3121_StopLine";
         entryLine  = "P3121_EntryLine";
         profitLine = "P3121_ProfitLine";
         entryFib   = "P3121_RRFib";
         risk       = 5;
      }
      ~CSetEntryObjects(){};
};
