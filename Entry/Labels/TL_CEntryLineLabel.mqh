#include "TL_CSetLineLabel.mqh"
//+------------------------------------------------------------------+
//| Child Class :  CEntryLineLabel                                    |
//+------------------------------------------------------------------+
class CEntryLineLabel : public CSetLineLabel
{
   public:
      CEntryLineLabel();
      ~CEntryLineLabel(void){};
};
//+------------------------------------------------------------------+
//| Child Class :  Construct                                         |
//+------------------------------------------------------------------+
CEntryLineLabel::CEntryLineLabel()
{
   labelName = ENTRYLINE_NAME + "_Label";
   gvSwitchTradeLine = gv.GetSwitchTradeLine();
   //---
   if(ObjectFind(0,STOPLINE_NAME) >= 0 && ObjectFind(0,ENTRYLINE_NAME) >= 0)
   {
      CPositionSizeCalculator post(MONEY_RISK);
      post.Calculate();
      text = post.orderTypeString + " : " + (string)post.lotSize+" Lot";
      //---
      yDistance = GetYDistance(post.entryPrice);
      xDistance = 10;
      anchor    = ANCHOR_RIGHT_UPPER;
      corner    = CORNER_RIGHT_UPPER;
      clr       = clrWheat;
      fontSize  = 9;
   }
   //---
}


