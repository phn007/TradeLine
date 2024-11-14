#include "..\..\include\TL_CGlobalVariables.mqh"
//+------------------------------------------------------------------+
//| Class : CRRFib.mqh                                               |
//+------------------------------------------------------------------+
class CRRFib
{
   protected: 
      //---
      string   objName;
      //--- 
      datetime time1;
      datetime time2;
      double   price1;
      double   price2;
      //---    
      color           clr;
      ENUM_LINE_STYLE style;
      int             width;
      bool            back;
      bool            selectable;
      bool            selection;
      bool            ray_left; 
      bool            ray_right; 
      bool            hidden;
      long            z_order;
      //---
      int             levels;
      color           levelColor;
      int             levelWidth;
      ENUM_LINE_STYLE levelStyle;
      //---                
      double            arrValue[];          
      color             arrColor[];           
      ENUM_LINE_STYLE   arrStyle[]; 
      int               arrWidth[];
      //---
      double switchLine;
      double switchRRFib;
      CGlobalVariables gv;
      //---
      virtual void SetObjects(){};
   private:
      void SetRootLevels();
   public:
      CRRFib(){};
      ~CRRFib(void){};
      void Create();
      void SetProperties();
      void SetLevels();
      void Delete();
      void SetSwitchRRFib();
      
      //---
      void SwitchOnOff();
      void Move();
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CRRFib::SetRootLevels(void)
{
   ObjectSetInteger(0,objName,OBJPROP_COLOR,clrNONE);
   ObjectSetString (0,objName,OBJPROP_LEVELTEXT,0,"");
   ObjectSetString (0,objName,OBJPROP_LEVELTEXT,1,"");
   ObjectSetInteger(0,objName,OBJPROP_LEVELCOLOR,0,clrLime);
   ObjectSetInteger(0,objName,OBJPROP_LEVELCOLOR,1,clrRoyalBlue);
   ObjectSetInteger(0,objName,OBJPROP_LEVELSTYLE,0,STYLE_SOLID);
   ObjectSetInteger(0,objName,OBJPROP_LEVELSTYLE,1,STYLE_SOLID);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CRRFib::SetSwitchRRFib(void)
{
   gv.SetSwitchOnOff(RRFIB);
}
//+------------------------------------------------------------------+
//| Method : SetLevel                                                |
//+------------------------------------------------------------------+
void CRRFib::SetLevels()
{
   ArrayResize(arrValue,levels);
   ArrayResize(arrStyle,levels);
   ArrayResize(arrWidth,levels);
   ArrayResize(arrColor,levels);
   
   for(int i=0; i<levels; i++)
   {
      arrValue[i] = i;
      arrColor[i] = levelColor;
      arrStyle[i] = levelStyle;
      arrWidth[i] = levelWidth;
   }
   ObjectSetInteger(0,objName,OBJPROP_LEVELS,levels); 
   for(int i=0;i<levels;i++) 
   { 
      int desc = (int)NormalizeDouble((i-1)*100,1);
      ObjectSetDouble (0,objName,OBJPROP_LEVELVALUE,i,arrValue[i]);  
      ObjectSetInteger(0,objName,OBJPROP_LEVELCOLOR,i,arrColor[i]); 
      ObjectSetInteger(0,objName,OBJPROP_LEVELSTYLE,i,arrStyle[i]); 
      ObjectSetInteger(0,objName,OBJPROP_LEVELWIDTH,i,arrWidth[i]); 
      ObjectSetString (0,objName,OBJPROP_LEVELTEXT ,i,(string)desc); 
   }
}
//+------------------------------------------------------------------+
//| Method : SetProperties                                           |
//+------------------------------------------------------------------+
void CRRFib::SetProperties(void)
{
   ObjectSetInteger(0,objName,OBJPROP_COLOR,clr); 
   ObjectSetInteger(0,objName,OBJPROP_STYLE,style); 
   ObjectSetInteger(0,objName,OBJPROP_WIDTH,width); 
   ObjectSetInteger(0,objName,OBJPROP_BACK,back); 
   ObjectSetInteger(0,objName,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(0,objName,OBJPROP_SELECTED,selectable);  
   ObjectSetInteger(0,objName,OBJPROP_RAY_LEFT,ray_left);  
   ObjectSetInteger(0,objName,OBJPROP_RAY_RIGHT,ray_right); 
   ObjectSetInteger(0,objName,OBJPROP_HIDDEN,hidden); 
   ObjectSetInteger(0,objName,OBJPROP_ZORDER,z_order); 
}
//+------------------------------------------------------------------+
//| Method : Create                                                  |
//+------------------------------------------------------------------+
void CRRFib::Create()
{
   //---
   ResetLastError(); 
   if(!ObjectCreate(0,objName,OBJ_FIBO,0,time1,price1,time2,price2)) 
   { 
      Print(__FUNCTION__, ": failed to create \"Fibonacci Retracement\"! Error code = ",GetLastError()); 
   } 
}
//+------------------------------------------------------------------+
//| Method : Create                                                  |
//+------------------------------------------------------------------+
void CRRFib::Delete(void)
{
   ResetLastError(); 
   if(!ObjectDelete(0,objName)) 
   { 
      Print(__FUNCTION__, ": failed to create \"Fibonacci Retracement\"! Error code = ",GetLastError()); 
   }   
}
//+------------------------------------------------------------------+
//| Method : Move                                                    |
//+------------------------------------------------------------------+
void CRRFib::Move()
{
   if(gv.GetSwitchTradeLine() == SWITCH_TRADELINE_ON)
   {
      if(gv.GetSwitchRRFib() == SWITCH_RRFIB_ON)
      {
         ObjectSetInteger(0,objName,OBJPROP_TIME,0,time1);
         ObjectSetInteger(0,objName,OBJPROP_TIME,1,time2);
         ObjectSetDouble(0,objName,OBJPROP_PRICE,0,price1);
         ObjectSetDouble(0,objName,OBJPROP_PRICE,1,price2);
      }
   }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CRRFib::SwitchOnOff(void)
{
   
   if(gv.GetSwitchTradeLine() == SWITCH_TRADELINE_ON)
   {
      Print(__FUNCTION__," | gv.getSwitchTradeLine(): ",EnumToString(gv.GetSwitchTradeLine()));
      if(gv.GetSwitchRRFib() == SWITCH_RRFIB_ON)
      {
         Print(__FUNCTION__," | gv.getSwitchRRFib(): ",EnumToString(gv.GetSwitchRRFib()));
         Create();
         SetProperties();
         SetLevels();
         SetRootLevels();
      }
      else
      {
         Print(__FUNCTION__," | gv.getSwitchRRFib(): ",EnumToString(gv.GetSwitchRRFib()));
         Delete();
      }
   }
   else
   {
      Delete();
   }
}
