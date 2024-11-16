#include "..\Defines\Defines.mqh"
//+------------------------------------------------------------------+
//|                                       CPositionSizeCalculator.mqh |
//+------------------------------------------------------------------+
class CPositionSizeCalculator
{
   private:
      double moneyRisk;   
   public:
      double stopPrice;
      double entryPrice;      
      //---      
      MARKET_DIRECTION  marketDirection;  
      ORDER_ACTION      orderAction; 
      double            marketPrice;  
      ENUM_ORDER_TYPE   orderType; 
      double            points;   
      double            tickValue;
      double            oneLotPerRisk;  
      double            lotSize;
      double            riskPerTrade;
      string            orderTypeString;
   public:
      CPositionSizeCalculator(double risk = 5);
     ~CPositionSizeCalculator();
     //---
     void               Calculate();
     MARKET_DIRECTION   GetMarketDirection   (double stop, double entry);    
     double             GetMarketPrice       (MARKET_DIRECTION direct);
     ENUM_ORDER_TYPE    GetOrderType         (double stop,double entry,double market);
     ORDER_ACTION       GetOrderAction       (ENUM_ORDER_TYPE type);
     double             GetPoints            (double stop,double entry);
     double             GetTickValue();
     double             GetOneLotPerRisk     (double point, double tick);
     double             GetLotSize           (double risk,double _1LotPerRisk);
     double             GetMoneyRiskPerTrade (double _1LotRisk,double lotsize);
     string             GetOrderTypeString(ENUM_ORDER_TYPE type);  
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CPositionSizeCalculator::CPositionSizeCalculator(double risk)
{
   
   stopPrice  = ObjectGetDouble(0,STOPLINE_NAME,OBJPROP_PRICE);
   entryPrice = ObjectGetDouble(0,ENTRYLINE_NAME,OBJPROP_PRICE);
   moneyRisk  = risk;
   //Print(__FUNCTION__," stopPrice: ",stopPrice," | entryPrice: ",entryPrice);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CPositionSizeCalculator::Calculate(void)
{
   marketDirection = GetMarketDirection   (stopPrice,entryPrice);
   marketPrice     = GetMarketPrice       (marketDirection);
   orderType       = GetOrderType         (stopPrice,entryPrice,marketPrice);
   orderTypeString = GetOrderTypeString   (orderType);
   orderAction     = GetOrderAction       (orderType);
   points          = GetPoints            (stopPrice,entryPrice);
   tickValue       = GetTickValue();
   oneLotPerRisk   = GetOneLotPerRisk     (points,tickValue);
   lotSize         = GetLotSize           (moneyRisk,oneLotPerRisk);
   riskPerTrade    = GetMoneyRiskPerTrade (oneLotPerRisk,lotSize);
   //*
   Print("========================================================\n",
   __FUNCTION__,"\n",
   "MarketDirection: ",    EnumToString(marketDirection),"\n",
   "MarketPrice: ",        DoubleToString(marketPrice),"\n",
   "OrderType: ",          EnumToString(orderType),"\n",
   "OrderAction: ",        EnumToString(orderAction),"\n",
   "Points: ",             DoubleToString(points),"\n",
   "TickValue:",           DoubleToString(tickValue),"\n",
   "OneLotPerRisk:",       DoubleToString(oneLotPerRisk),"\n",
   "LotSize:",             DoubleToString(lotSize),"\n",
   "MoneyRiskPerTrade:",   DoubleToString(riskPerTrade),"\n",
   "========================================================");
   //*/
   
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CPositionSizeCalculator::~CPositionSizeCalculator()
{
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MARKET_DIRECTION CPositionSizeCalculator::GetMarketDirection(double stop, double entry)
{
   if(stop < entry)
   {
      return DIRECTION_BUY;
   }
   else if(stop > entry)
   {
      return DIRECTION_SELL;
   }
   else
   {
      Print(__FUNCTION__," direction: Direction NONE");
      return DIRECTION_NONE;
   }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

double CPositionSizeCalculator::GetMarketPrice(MARKET_DIRECTION direct)
{
   Print(__FUNCTION__" Direct: ",EnumToString(direct));
   if(direct == DIRECTION_BUY)
   {
      //Print(__FUNCTION__," marketPrice => ask");
      return SymbolInfoDouble(Symbol(),SYMBOL_ASK);   
   }
   else if(direct == DIRECTION_SELL)
   {
      //Print(__FUNCTION__," marketPrice => bid");
      return SymbolInfoDouble(Symbol(),SYMBOL_BID);
   }
   else
   {
      Print(__FUNCTION__," marketPrice invalid: -1");
      return -1;
   } 
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

ENUM_ORDER_TYPE CPositionSizeCalculator::GetOrderType(double stop, double entry, double market)
{
   //---
   if(entry > stop && entry < market)
   {
      return ORDER_TYPE_BUY_LIMIT;
   }
   else if(entry > stop && entry > market && stop < market) 
   {
      return ORDER_TYPE_BUY_STOP;    
   }
   else if(entry < stop && entry > market)
   { 
      return ORDER_TYPE_SELL_LIMIT;      
   }
   else if(entry < stop && entry < market && stop > market)
   {
      return ORDER_TYPE_SELL_STOP; 
   }   
   else if(entry > stop && entry == market)
   {
      return ORDER_TYPE_BUY;
   }
   else if(entry < stop && entry == market)
   {
      return ORDER_TYPE_SELL;
   }
   else
   {
      Print(__FUNCTION__," Invalid OrderType: -1");
      return -1;
   }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CPositionSizeCalculator::GetOrderTypeString(ENUM_ORDER_TYPE type)
{
   switch(type)
   {
      case ORDER_TYPE_BUY        : return "Buy";               break;
      case ORDER_TYPE_SELL       : return "Sell";              break;
      case ORDER_TYPE_BUY_LIMIT  : return "Buy Limit";         break;
      case ORDER_TYPE_SELL_LIMIT : return "Sell Limit";        break;
      case ORDER_TYPE_BUY_STOP   : return "Buy Stop";          break;
      case ORDER_TYPE_SELL_STOP  : return "Sell Stop";         break;
      default                    : return "Invalid OrderType"; break;
     }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ORDER_ACTION CPositionSizeCalculator::GetOrderAction(ENUM_ORDER_TYPE type)
{
   switch(type)
   {
      case ORDER_TYPE_BUY_LIMIT  : return ORDER_ACTION_PENDING;   break;
      case ORDER_TYPE_SELL_LIMIT : return ORDER_ACTION_PENDING;   break;
      case ORDER_TYPE_SELL_STOP  : return ORDER_ACTION_PENDING;   break;
      case ORDER_TYPE_BUY_STOP   : return ORDER_ACTION_PENDING;   break;
      case ORDER_TYPE_BUY        : return ORDER_ACTION_MARKET;    break;
      case ORDER_TYPE_SELL       : return ORDER_ACTION_MARKET;    break;
      default                    : return -1;                     break;
   }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CPositionSizeCalculator::GetPoints(double stop,double entry)
{
   return MathAbs(entry-stop)/Point();   
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CPositionSizeCalculator::GetTickValue(void)
{
   return SymbolInfoDouble(Symbol(),SYMBOL_TRADE_TICK_VALUE);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CPositionSizeCalculator::GetOneLotPerRisk(double point,double tick)
{
   return point * tick;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CPositionSizeCalculator::GetLotSize(double risk,double _1LotPerRisk)
{
   return NormalizeDouble((risk/_1LotPerRisk),2);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CPositionSizeCalculator::GetMoneyRiskPerTrade(double _1LotRisk,double lotsize)
{
   return _1LotRisk*lotsize;
}