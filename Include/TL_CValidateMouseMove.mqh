//+------------------------------------------------------------------+
//| Base Class : CValidateMouseMove                                  |
//+------------------------------------------------------------------+
class CValidateMouseMove
{
   protected:
      int      mouseX;
      int      mouseY;
      int      gap;
      //---
      datetime time1;
      datetime time2;
      double   price1;
      double   price2;
      //---
      int   GetXDistance(datetime time);
      int   GetYDistance(double price);
      bool  CheckPoint  (int x,int y);
      bool  HorzMidPoint(int x1,int y1,int x2,int y2);
   public:
      virtual bool MoveAllowed(){ return false; };
      //---
      CValidateMouseMove(long lparam,double dparam,string name);
      CValidateMouseMove(double dparam,string name);
      ~CValidateMouseMove(void){};
};
//+------------------------------------------------------------------+
//| Base Class : CValidateMouseMove - Construct 1                    |
//+------------------------------------------------------------------+
CValidateMouseMove::CValidateMouseMove(long lparam,double dparam,string name)
{
   mouseX   = (int)lparam;
   mouseY   = (int)dparam;
   gap      = 3;
   
   time1    = (datetime)ObjectGetInteger(0,name,OBJPROP_TIME,0);
   time2    = (datetime)ObjectGetInteger(0,name,OBJPROP_TIME,1);
   price1   = ObjectGetDouble(0,name,OBJPROP_PRICE,0);
   price2   = ObjectGetDouble(0,name,OBJPROP_PRICE,1);
}
//+------------------------------------------------------------------+
//| Base Class : CValidateMouseMove - Construct 2                    |
//+------------------------------------------------------------------+
CValidateMouseMove::CValidateMouseMove(double dparam,string name)
{
   mouseY = (int)dparam;
   gap    = 3;
   time1  = 0;
   price1 = ObjectGetDouble(0,name,OBJPROP_PRICE,0);
}
//+------------------------------------------------------------------+
//| Base Class : CValidateMouseMove - GetXDistance                   |
//+------------------------------------------------------------------+
int CValidateMouseMove::GetXDistance(datetime time)
{
   int x  = 0;
   int y  = 0;  
   double price = 0;
   ChartTimePriceToXY(0,0,time,price,x,y);
   //---
   return x;
}
//+------------------------------------------------------------------+
//| Base Class : CValidateMouseMove - GetYDistance                   |
//+------------------------------------------------------------------+
int CValidateMouseMove::GetYDistance(double price)
{
   int x  = 0;
   int y  = 0;  
   datetime time = 0;
   ChartTimePriceToXY(0,0,time,price,x,y);
   //---
   return y;
}
//+------------------------------------------------------------------+
//| Base Class : CValidateMouseMove - CheckPoint                     |
//+------------------------------------------------------------------+
bool CValidateMouseMove::CheckPoint(int x,int y)
{
   bool xPoint = false;
   if(mouseX > x-gap && mouseX < x+gap) 
      xPoint = true;
   //---
   bool yPoint = false;
   if(mouseY > y-gap && mouseY < y+gap)
      yPoint = true;
   //---
   bool point = false;
   if(xPoint == true && yPoint == true)
      point = true;
   //---
   return point;      
}
//+------------------------------------------------------------------+
//| Child Class : CHLineMouseMove                                    |
//+------------------------------------------------------------------+
class CHLineMouseMove : public CValidateMouseMove
{
   public:
      CHLineMouseMove(double dparam,string name) : CValidateMouseMove(dparam,name){}
      bool MoveAllowed();
};
//+------------------------------------------------------------------+
//| Child Class : CHLinePoint - MoveAllowed                          |
//+------------------------------------------------------------------+
bool CHLineMouseMove::MoveAllowed(void)
{
   int y = GetYDistance(price1);
   if(mouseY > y-gap && mouseY < y+gap)
      return true;
   else
      return false;
}