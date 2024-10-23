class CBaseObjects
{
   protected:
      long     id;
      string   name;
      int      sub;
   public:
      CBaseObjects(string _name)
      {
         name = _name;
         id   = ChartID();
         sub  = 0;
      };
      CBaseObjects(long _id,string _name)
      {
         name = _name;
         id   = _id;
         sub  = 0;
      }
      CBaseObjects(long _id,string _name,int _sub)
      {
         name = _name;
         id   = _id;
         sub  = _sub;
      }
      ~CBaseObjects(void){};
   public:
      //---
      //void SetAlign(ENUM_ALIGN_MODE value);
      void SetAnchor(ENUM_ANCHOR_POINT value)   { ObjectSetInteger(id,name,OBJPROP_ANCHOR,value);     }
      //void SetArrowAnchor(ENUM_ARROW_ANCHOR value);
      //void SetAngle(double value);
      //void SetArrowCode(uchar value);
      void SetBack      (bool value)            { ObjectSetInteger(id,name,OBJPROP_BACK,value);       }
      void SetBGColor   (color value)           { ObjectSetInteger(id,name,OBJPROP_BGCOLOR,value);    }
      //void SetBMPFile(string value);
      void SetBorderColor(color value)          { ObjectSetInteger(id,name,OBJPROP_BORDER_COLOR,value);}
      //void SetChartID(long value);
      //void SetChartScale(int value);
      void SetColor     (color value)           { ObjectSetInteger(id,name,OBJPROP_COLOR,value);      }
      void SetCorner(ENUM_BASE_CORNER value)    { ObjectSetInteger(id,name,OBJPROP_CORNER,value);     }
      //void SetCreateTime(datetime value);
      //void SetDateScale(bool value);
      //void SetDegree(ENUM_ELLIOT_WAVE_DEGREE value);
      //void SetDeviation(double value);
      //void SetDirection(ENUM_GANN_DIRECTION);
      //void SetDrawLines(bool value);
      //void SetEllipse(bool,value);
      void SetFill      (bool value)            { ObjectSetInteger(id,name,OBJPROP_FILL,value);       }
      void SetFont(string value)                { ObjectSetString(id,name,OBJPROP_FONT,value);        }
      void SetFontSize(int value)               { ObjectSetInteger(id,name,OBJPROP_FONTSIZE,value);   }
      void SetHidden    (bool value)            { ObjectSetInteger(id,name,OBJPROP_HIDDEN,value);     }
      void SetLevelColor(color value)           { ObjectSetInteger(id,name,OBJPROP_LEVELCOLOR,value); }
      void SetLevels    (int value)             { ObjectSetInteger(id,name,OBJPROP_LEVELS,value);     }
      void SetLevelStyle(ENUM_LINE_STYLE value) { ObjectSetInteger(id,name,OBJPROP_LEVELSTYLE,value); }
      void SetLevelText(string value)           { ObjectSetString(id,name,OBJPROP_LEVELTEXT,value);   }
      void SetLevelValue(double value)          { ObjectSetDouble(id,name,OBJPROP_LEVELVALUE,value);  }
      void SetLevelWidth(int value)             { ObjectSetInteger(id,name,OBJPROP_LEVELWIDTH,value); }
      void SetName(string value)                { ObjectSetString(id,name,OBJPROP_NAME,value);        }
      void SetPeriod(ENUM_TIMEFRAMES value)     { ObjectSetInteger(id,name,OBJPROP_PERIOD,value);     }
      void SetPrice1    (double value)          { ObjectSetDouble(id,name,OBJPROP_PRICE,0,value);     }
      void SetPrice2    (double value)          { ObjectSetDouble(id,name,OBJPROP_PRICE,1,value);     }
      //void SetPriceScale(bool value);
      //void SetRay(bool value);
      void SetRayLeft   (bool value)            { ObjectSetInteger(id,name,OBJPROP_RAY_LEFT,value);   }
      void SetRayRight  (bool value)            { ObjectSetInteger(id,name,OBJPROP_RAY_RIGHT,value);  }
      //void SetReadOnly(bool value);
      //void SetScale(double value);
      void SetSelectable(bool value)            { ObjectSetInteger(id,name,OBJPROP_SELECTABLE,value); }
      void SetSelected  (bool value)            { ObjectSetInteger(id,name,OBJPROP_SELECTED,value);   }
      void SetState     (bool value)            { ObjectSetInteger(id,name,OBJPROP_STATE,value);      }
      void SetStyle     (ENUM_LINE_STYLE value) { ObjectSetInteger(id,name,OBJPROP_STYLE,value);      }
      void SetText      (string value)          { ObjectSetString(id,name,OBJPROP_TEXT,value);        }
      void SetTime1     (datetime value)        { ObjectSetInteger(id,name,OBJPROP_TIME,0,value);     }
      void SetTime2     (datetime value)        { ObjectSetInteger(id,name,OBJPROP_TIME,1,value);     }
      void SetTimeframes(int value)             { ObjectSetInteger(id,name,OBJPROP_TIMEFRAMES,value); }
      //void SetSymbol(string value);
      void SetTooltip(string value)             { ObjectSetString(id,name,OBJPROP_TOOLTIP,value);     }
      //void SetType(ENUM_OBJECT value);
      void SetWidth     (int value)             { ObjectSetInteger(id,name,OBJPROP_WIDTH,value);      }
      void SetXDistance (int value)             { ObjectSetInteger(id,name,OBJPROP_XDISTANCE,value);  }
      void SetYDistance (int value)             { ObjectSetInteger(id,name,OBJPROP_YDISTANCE,value);  }
      void SetXSize     (int value)             { ObjectSetInteger(id,name,OBJPROP_XSIZE,value);      }
      void SetYSize     (int value)             { ObjectSetInteger(id,name,OBJPROP_YSIZE,value);      }
      //void SetXOffset(int value);
      //void SetYOffset(int value);
      void SetZorder    (long value)            { ObjectSetInteger(id,name,OBJPROP_ZORDER,value);     }
      //---
      //ENUM_ALIGN_MODE   GetAlign();
      ENUM_ANCHOR_POINT GetAnchor()       { return (ENUM_ANCHOR_POINT)ObjectGetInteger(id,name,OBJPROP_ANCHOR);   }
      //ENUM_ARROW_ANCHOR GetArrowAnchor();
      ENUM_BASE_CORNER  GetCorner()       { return (ENUM_BASE_CORNER)ObjectGetInteger(id,name,OBJPROP_CORNER);    }
      ENUM_LINE_STYLE   GetLevelStyle()   { return (ENUM_LINE_STYLE)ObjectGetInteger(id,name,OBJPROP_LEVELSTYLE); }
      ENUM_TIMEFRAMES   GetPeriod()       { return (ENUM_TIMEFRAMES)ObjectGetInteger(id,name,OBJPROP_PERIOD);     }
      ENUM_LINE_STYLE   GetStyle()        { return (ENUM_LINE_STYLE)ObjectGetInteger(id,name,OBJPROP_STYLE);      }
      ENUM_OBJECT       GetType()         { return (ENUM_OBJECT)ObjectGetInteger(id,name,OBJPROP_TYPE);           }
      //ENUM_ELLIOT_WAVE_DEGREE GetDegree();
      //ENUM_GANN_DIRECTION GetDirection();
      //double GetAngle();
      //uchar  GetArrowCode();
      bool     GetBack()         { return (bool)ObjectGetInteger(id,name,OBJPROP_BACK);         }
      color    GetBGColor()      { return (color)ObjectGetInteger(id,name,OBJPROP_COLOR);       }
      //string GetBMPFile();
      color    GetBorderColor()  { return (color)ObjectGetInteger(id,name,OBJPROP_BORDER_COLOR);}
      //long   GetChartID();
      //int    GetChartScale();
      color    GetColor()        { return (color)ObjectGetInteger(id,name,OBJPROP_COLOR);       }
      //datetime GetCreateTime();
      //bool     GetDateScale();
      //double   GetDeviation();
      //bool     GetDrawLines();
      //bool     GetEllipse();
      bool     GetFill()         { return (bool)ObjectGetInteger(id,name,OBJPROP_FILL);         }
      string   GetFont()         { return ObjectGetString(id,name,OBJPROP_FONT);                }
      int      GetFontSize()     { return (int)ObjectGetInteger(id,name,OBJPROP_FONTSIZE);      }
      //bool     GetHidden();
      color    GetLevelColor()   { return (color)ObjectGetInteger(id,name,OBJPROP_LEVELCOLOR);  }
      int      GetLevels()       { return (int)ObjectGetInteger(id,name,OBJPROP_LEVELS);        }
      string   GetLevelText()    { return ObjectGetString(id,name,OBJPROP_TEXT);                }
      double   GetLevelValue()   { return ObjectGetDouble(id,name,OBJPROP_LEVELVALUE);          }
      int      GetLevelWidth()   { return (int)ObjectGetInteger(id,name,OBJPROP_LEVELWIDTH);    }
      string   GetName()         { return ObjectGetString(id,name,OBJPROP_NAME);                }
      double   GetPrice1()       { return ObjectGetDouble(id,name,OBJPROP_PRICE,0);             }
      double   GetPrice2()       { return ObjectGetDouble(id,name,OBJPROP_PRICE,1);             }
      //bool     GetPriceScale();
      //bool     GetRay();
      bool     GetRayLeft()      { return (bool)ObjectGetInteger(id,name,OBJPROP_RAY_LEFT);     }
      bool     GetRayRight()     { return (bool)ObjectGetInteger(id,name,OBJPROP_RAY_RIGHT);    }
      //bool     GetReadOnly();
      //double   GetScale();
      bool     GetSelectable()   { return (bool)ObjectGetInteger(id,name,OBJPROP_SELECTABLE);   }
      bool     GetSelected()     { return (bool)ObjectGetInteger(id,name,OBJPROP_SELECTED);     }
      bool     GetState()        { return (bool)ObjectGetInteger(id,name,OBJPROP_STATE);        }
      string   GetText()         { return ObjectGetString(id,name,OBJPROP_TEXT);                }
      datetime GetTime1()        { return (datetime)ObjectGetInteger(id,name,OBJPROP_TIME,0);   }
      datetime GetTime2()        { return (datetime)ObjectGetInteger(id,name,OBJPROP_TIME,1);   }
      int      GetTimeframes()   { return (int)ObjectGetInteger(id,name,OBJPROP_TIMEFRAMES);    }
      //string   GetSymbol();
      string   GetTooltip()      { return ObjectGetString(id,name,OBJPROP_TOOLTIP);             }
      int      GetWidth()        { return (int)ObjectGetInteger(id,name,OBJPROP_WIDTH);         }
      int      GetXDistance()    { return (int)ObjectGetInteger(id,name,OBJPROP_XDISTANCE);     }
      int      GetYDistance()    { return (int)ObjectGetInteger(id,name,OBJPROP_YDISTANCE);     }
      int      GetXSize()        { return (int)ObjectGetInteger(id,name,OBJPROP_XSIZE);         }
      int      GetYSize()        { return (int)ObjectGetInteger(id,name,OBJPROP_YSIZE);         }
      //int      GetXOffset();
      //int      GetYOffset();
      long     GetZorder()       { return ObjectGetInteger(id,name,OBJPROP_ZORDER);             }
};
