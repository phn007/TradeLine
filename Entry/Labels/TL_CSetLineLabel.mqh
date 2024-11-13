//+------------------------------------------------------------------+
//|                                             TL_CSetLineLabel.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
//---
#include "../../Include/TL_CGlobalVariables.mqh"
#include "../../Include/TL_CTradingCalculator.mqh"
#include "../../Objects/TL_CLabel.mqh"
//+------------------------------------------------------------------+
//| Base Class : CSetLineLabel                                       |
//+------------------------------------------------------------------+
class CSetLineLabel
{  //--- variables
   protected:
      string   labelName;
      string   text;
      color    clr;
      int      fontSize;
      int      xDistance;
      int      yDistance;
      ENUM_ANCHOR_POINT anchor;
      ENUM_BASE_CORNER  corner;
      //---
      SWITCH_TRADELINE gvSwitchTradeLine;
      //---
      CGlobalVariables gv;
   //--- Method
   protected:
      int GetYDistance(double price);
      void CreateLabel();
      void SetProperties();
      void DeleteLabel();
   private:
      
   public:
      CSetLineLabel(void){}
      ~CSetLineLabel(void){}
      //---
      void SwitchOnOff();
      void UpdateLabel();
};
//+------------------------------------------------------------------+
//| Method : CreateLabel                                             |
//+------------------------------------------------------------------+
void CSetLineLabel::CreateLabel(void)
{
   CLabel label(labelName);
   //---
   if(ObjectFind(0,labelName) < 0)
   {
      label.Create();
      SetProperties();
   }
   else
   {
      SetProperties();
   }
}
//+------------------------------------------------------------------+
//| Base - Method : SetProperties                                    |
//+------------------------------------------------------------------+
void CSetLineLabel::SetProperties(void)
{
   //Print(__FUNCTION__," text : ",text);
   CLabel label(labelName);
   label.SetXDistance(xDistance);
   label.SetYDistance(yDistance);
   label.SetAnchor(anchor);
   label.SetCorner(corner);
   label.SetColor(clr);
   label.SetFontSize(fontSize);
   label.SetText(text); 
}
//+------------------------------------------------------------------+
//| Method : SwitchOnOff                                             |
//+------------------------------------------------------------------+
void CSetLineLabel::SwitchOnOff()
{
   //Print(__FUNCTION__," gvSwitchTradeLine",gvSwitchTradeLine);
   if(gvSwitchTradeLine == SWITCH_TRADELINE_ON)
   {
      CreateLabel();
   }
   else if(gvSwitchTradeLine == SWITCH_TRADELINE_OFF)
   {
      DeleteLabel();
   }

}
//+------------------------------------------------------------------+
//| Method : UpdateLabel                                             |
//+------------------------------------------------------------------+
void CSetLineLabel::UpdateLabel(void)
{
   //Print(__FUNCTION__," | labelName: ",labelName," | text: ",text);
   if(gvSwitchTradeLine == SWITCH_TRADELINE_ON)
   {
      CLabel label(labelName);
      label.SetText(text);
      label.SetYDistance(yDistance);      
   }
}
//+------------------------------------------------------------------+
//| Method : GetYDistance                                            |
//+------------------------------------------------------------------+
int CSetLineLabel::GetYDistance(double price)
{
   int x = 0;
   int y = 0;  
   datetime time = 0;
   ChartTimePriceToXY(0,0,time,price,x,y);
   return y;
}
//+------------------------------------------------------------------+
//| Method : DeleteLabel                                             |
//+------------------------------------------------------------------+
void CSetLineLabel::DeleteLabel(void)
{
   if(ObjectFind(0,labelName) >= 0)
   {
      ObjectDelete(0,labelName);
   }
}