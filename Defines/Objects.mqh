//---
#define STOPLINE_NAME   "3121_StopLine"
#define STOPLINE_COLOR  clrLime
#define STOPLINE_SELECT true
#define STOPLINE_TEXT   "#SL"
//---
#define ENTRYLINE_NAME           "3121_EntryLine"
#define ENTRYLINE_COLOR          clrRoyalBlue
#define ENTRYLINE_UNSELECT       false
#define ENTRYLINE_SELECT         true
#define ENTRYLINE_MARKET_TEXT    "#Entry : ByMarket"
#define ENTRYLINE_PENDING_TEXT   "#Entry : Pending"
//---
#define PROFITLINE_NAME          "3121_ProfitLine"
#define PROFITLINE_COLOR         clrTeal
#define PROFITLINE_TEXT          "#TP"
#define PROFITLINE_SELECT        true
//---
#define RRFIB_NAME   "3121_RRFib"
//---
#define MONEY_RISK   5
//---RRR
/*
#define RRRx0        0
#define RRRx1        1
#define RRRx2        2
#define RRRx3        3
#define RRRx4        4
#define RRRx5        5
#define RRRx6        6
#define RRRx7        7
#define RRRx8        8
#define RRRx9        9
*/
//---
enum RISK_REWARD_RATIO
{
   RRRx0 = 0,
   RRRx1 = 1,
   RRRx2 = 2,
   RRRx3 = 3,
   RRRx4 = 4,
   RRRx5 = 5,
   RRRx6 = 6,
   RRRx7 = 7,
   RRRx8 = 8,
   RRRx9 = 9
};
//---
enum TRADELINE_CONSTRUCT
{
   RESET_TRADELINE_PRICE,
   UPDATE_TRADELINE_PRICE,
   SWITCH_TRADE_METHOD
};

