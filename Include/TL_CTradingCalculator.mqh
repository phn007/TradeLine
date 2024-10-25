//+------------------------------------------------------------------+
//| Class : CTradingCalculator                                       |
//+------------------------------------------------------------------+
class CTradingCalculator
{
   private:
      double tickValue;
      double _1LotRisk;
      double ask;
      double bid;
   public:
      double method;
      double stopPrice;
      double entryPrice;
      double points; 
      double lotsize;     
      double moneyRisk;
      ENUM_ORDER_TYPE orderType;
      string sOrderType;
   private:
      ENUM_ORDER_TYPE   GetOrderType      (double stop,double entry);
      double            GetMethod         (ENUM_ORDER_TYPE type);
      double            GetEntryPrice     (double stop,double entry,double met);
      double            GetPoints         (double stop,double entry);
      double            Get1LotMoneyRisk  (double point, double tick);
      double            GetLotsize        (double risk,double oneLotRisk);
      double            GetMoneyRisk      (double oneLotRisk,double lot);
      string            GetOrderTypeText  (ENUM_ORDER_TYPE type);
   public:
      CTradingCalculator(double stop,double entry,double risk);
      ~CTradingCalculator(void){};
};
//+------------------------------------------------------------------+
//| Construct                                                        |
//+------------------------------------------------------------------+
CTradingCalculator::CTradingCalculator(double stop,double entry,double _risk = 10)
{
   bid         = SymbolInfoDouble(Symbol(),SYMBOL_BID);
   ask         = SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   tickValue   = SymbolInfoDouble(Symbol(),SYMBOL_TRADE_TICK_VALUE);
   //---
   orderType   = GetOrderType    (stop,entry);
   method      = GetMethod       (orderType);
   entryPrice  = GetEntryPrice   (stop,entry,method);
   stopPrice   = stop; 
   points      = GetPoints       (stopPrice,entryPrice);
   _1LotRisk   = Get1LotMoneyRisk(points,tickValue);
   lotsize     = GetLotsize      (_risk,_1LotRisk);
   moneyRisk   = GetMoneyRisk    (_1LotRisk,lotsize);
   sOrderType  = GetOrderTypeText(orderType);
}
//+------------------------------------------------------------------+
//| Method : GetOrderTypeText                                        |
//+------------------------------------------------------------------+
string CTradingCalculator::GetOrderTypeText(ENUM_ORDER_TYPE type)
{
   string sType;
   switch(type)
   {
      case ORDER_TYPE_BUY        : sType = "Buy";        break;
      case ORDER_TYPE_SELL       : sType = "Sell";       break;
      case ORDER_TYPE_BUY_LIMIT  : sType = "Buy Limit";  break;
      case ORDER_TYPE_SELL_LIMIT : sType = "Sell Limit"; break;
      case ORDER_TYPE_BUY_STOP   : sType = "Buy Stop";   break;
      case ORDER_TYPE_SELL_STOP  : sType = "Sell Stop";  break;
      default                    : sType = "Invalid";    break;
   }
   return sType;   
}
//+------------------------------------------------------------------+
//| Method : GetMoneyRisk                                            |
//+------------------------------------------------------------------+
double CTradingCalculator::GetMoneyRisk(double oneLotRisk,double lot)
{
   if(oneLotRisk != -1 && lot != -1)
   {
      return NormalizeDouble(oneLotRisk * lot,2);
   }
   else
   {
      return -1;
   }
}
//+------------------------------------------------------------------+
//| Method : GetLotsize                                              |
//+------------------------------------------------------------------+
double CTradingCalculator::GetLotsize(double _risk,double oneLotRisk)
{
   if(oneLotRisk != -1)
   {
      return NormalizeDouble(_risk / oneLotRisk,2);
   }
   else
   {
      return -1;
   }
}
//+------------------------------------------------------------------+
//| Method : Get1LotMoneyRisk                                        |
//+------------------------------------------------------------------+
double CTradingCalculator::Get1LotMoneyRisk(double point,double tick)
{
   if(point != -1)
   {
      return point * tick;
   }
   else
   {
      return -1;
   }
}
//+------------------------------------------------------------------+
//| Method : GetPoints                                               |
//+------------------------------------------------------------------+
double CTradingCalculator::GetPoints(double stop,double entry)
{
   if(entry != -1)
   {
      return NormalizeDouble(MathAbs(entry - stop) / Point(),2);      
   }
   else
   {
      return -1;
   }   
}
//+------------------------------------------------------------------+
//| Method : GetEntryPrice                                           |
//+------------------------------------------------------------------+
double CTradingCalculator::GetEntryPrice(double stop,double entry,double met)
{
   if(met == 0)//Pending
   {
      return entry;  
   }
   else if(met == 1) //ByMarket
   {
      if(stop < ask && stop < bid)
      {
         return ask;
      }
      else if(stop > ask && stop > bid)
      {
         return bid;
      }
      else
      {
         return -1;
      }
   }
   else
   {
      return -1;
   }
}
//+------------------------------------------------------------------+
//| Method : GetMethod                                               |
//+------------------------------------------------------------------+
double CTradingCalculator::GetMethod(ENUM_ORDER_TYPE type)
{
   switch(type)
   {
      case ORDER_TYPE_BUY        : return 1;
      case ORDER_TYPE_SELL       : return 1;
      case ORDER_TYPE_BUY_LIMIT  : return 0;
      case ORDER_TYPE_BUY_STOP   : return 0;
      case ORDER_TYPE_SELL_LIMIT : return 0;
      case ORDER_TYPE_SELL_STOP  : return 0;
      default                    : return -1;
     }
}
//+------------------------------------------------------------------+
//| Method : GetOrderType                                            |
//+------------------------------------------------------------------+
ENUM_ORDER_TYPE CTradingCalculator::GetOrderType(double stop,double entry)
{
   if(entry > stop && entry < ask)
   {
      return ORDER_TYPE_BUY_LIMIT;
   }
   else if(entry > stop && entry > ask && stop < ask) 
   {
      return ORDER_TYPE_BUY_STOP;    
   }
   else if(entry < stop && entry > bid)
   { 
      return ORDER_TYPE_SELL_LIMIT;      
   }
   else if(entry < stop && entry < bid && stop > bid)
   {
      return ORDER_TYPE_SELL_STOP; 
   }   
   else if(entry > stop && entry == ask)
   {
      return ORDER_TYPE_BUY;
   }
   else if(entry < stop && entry == bid)
   {
      return ORDER_TYPE_SELL;
   }
   else
   {
      return -1;
   }
}


