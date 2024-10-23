#include "Include/TL_CGlobalVariables.mqh"
#include "Entry/TL_CSetEntryObjects.mqh"
#include "Entry/Lines/TL_CStopLine.mqh"

class TurnOnOffTradeLine
{
   private:
      
   public:
      TurnOnOffTradeLine(void){};
     ~TurnOnOffTradeLine(void){};
     void SwitchOnOff();
};
void TurnOnOffTradeLine::SwitchOnOff(void)
{
   Print(__FUNCTION__," SwitchOnOff");
   //---
   CGlobalVariables gv;
   gv.SetInitSwitchMethod();     //ByMarket
   gv.SetSwitchOnOff(TRADELINE); //Off
   //---
   CSetTradeLine *stop = new CStopLine();
   stop.SwitchOnOff();
   
   delete stop;
}