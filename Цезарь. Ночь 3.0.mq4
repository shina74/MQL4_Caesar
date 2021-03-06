//+------------------------------------------------------------------+
//|                                                       Цезарь.mq4 |
//|                        Copyright 2016, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

extern double vol = 0.1;
double p,r1,r2,r3,s1,s2,s3;
int a,total;
double TPB1,TPB2,TPS1,TPS2;
bool buy,sell;

int OnInit()
  {
//---
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
  double H = iHigh(NULL,PERIOD_D1,1), L = iLow(NULL,PERIOD_D1,1), C = iClose(NULL,PERIOD_D1,1);

     p = (H + L + C) / 3;
     r1 = (2*p) - L;
     s1 = (2*p) - H;
     r2 = p + (H - L);
     s2 = p - (H - L);
     r3 = H + (2*(p - L));
     s3 = L - (2*(H - p));
     
    Comment ("P ",NormalizeDouble(p,5),"\n", "S1  ",NormalizeDouble(s1,5),"\n"
    "S2 ",NormalizeDouble(s2,5),"\n", "S3  ",NormalizeDouble(s3,5),"\n"
    "R1 ",NormalizeDouble(r1,5),"\n", "R2  ",NormalizeDouble(r2,5),"\n"
    "R3 ",NormalizeDouble(r3,5),"\n" );
     
if ( Hour() != 0)
{
a = 0;
}  
if ( Hour() == 0 && Minute() <= 59 && Minute() >= 30 && a != 1)
  { 
  
     a = 1;
  
     p = (H + L + C) / 3;
     r1 = (2*p) - L;
     s1 = (2*p) - H;
     r2 = p + (H - L);
     s2 = p - (H - L);
     r3 = H + (2*(p - L));
     s3 = L - (2*(H - p));
     
   total = OrdersTotal();
   
   while (total > 0)
 {
   total=total - 1;
   OrderSelect(total,SELECT_BY_POS);
   if ( OrderSymbol() == Symbol() && OrderComment() == "Цезарь")
   {
   if (OrderType() == 0)
   buy = buy + 1;
   if (OrderType() == 1)
   sell = sell + 1;
   }
 }
   
  if ( s1 + 0.00300 > p)
 TPB1 = NormalizeDouble(p,5) - 0.00025;
 else 
 TPB1 = NormalizeDouble(s1,5) + 0.00300;
 
 TPB2 = NormalizeDouble(s1,5) - 0.00010;
 
 if (r1 - 0.00300 < p)
 TPS1 = NormalizeDouble(p,5) + 0.00025;
 else
 TPS1 = NormalizeDouble(r1,5) - 0.00300;
 
 TPS2 = NormalizeDouble(r1,5) + 0.00010;
 
 if (buy > 0)
 {
 TPB1 = 0;
 TPB2 = 0;
 }
 
  if (sell > 0)
 {
 TPS1 = 0;
 TPS2 = 0;
 }
 
   
   // Покупка 1 уровень
   
   OrderSend(NULL,OP_BUYLIMIT,vol,NormalizeDouble(s1,5),10,0,TPB1,"Цезарь",1,TimeCurrent() + 85400,clrBlue);
      
   // Покупка 2 уровень
   
   OrderSend(NULL,OP_BUYLIMIT,vol,NormalizeDouble (s2,5),10,0,TPB2,"Цезарь",1,TimeCurrent() + 85500,clrBlue);
   
   // Покупка 3 уровень
   
   OrderSend(NULL,OP_BUYLIMIT,vol,NormalizeDouble(s3,5),10,0,0,"Цезарь",1,TimeCurrent() + 85600,clrBlue);
 
    // Продажа 1 уровень
   
   OrderSend(NULL,OP_SELLLIMIT,vol,NormalizeDouble(r1,5),10,0,TPS1,"Цезарь",1,TimeCurrent() + 85700,clrRed);
    
    // Продажа 2 уровень
   
   OrderSend(NULL,OP_SELLLIMIT,vol,NormalizeDouble(r2,5),10,0,TPS2,"Цезарь",1,TimeCurrent() + 85800,clrRed);
   
    // Продажа 3 уровень
   
   OrderSend(NULL,OP_SELLLIMIT,vol,NormalizeDouble(r3,5),10,0,0,"Цезарь",1,TimeCurrent() + 85900,clrRed);
  
 buy = 0;
 sell = 0;
 } 
  }
//+------------------------------------------------------------------+
