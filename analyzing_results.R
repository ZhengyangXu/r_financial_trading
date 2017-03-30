#RUN THE STRATEGY

#APPLIES YOUR STRATEGY
out = applyStrategy(strategy = strategy.st, portfolios = portfolio.st)

#UPDATE YOUR PORTFOLIO
updatePortf(portfolio.st)
daterange = time(getPortfolio(portfolio.st)$summary)[-1]

#UPDATE YOUR ACCOUNT
updateAcct(account.st, daterange)
updateEndEq(account.st)

#THIS STRATEGY INCLUDES THE FOLLOWING SINGLA 
#1.sigComparison for SMA50 being greater than SMA200
#2.sigThreshold with cross set to FALSE for DVO_2_126 LESS THAN 20
#3.sigFormula to tie them toegether and set cross to TRUE
#4.sigCrossover with SMA50 less than SMA200
#5.sigThreshold with cross set to TRUE for DVO_2_126

#CALCULATE THE PROFIT FACTOR
tstats = tradeStats(Portfolios = portfolio.st)
tstats$Profit.Factor
  #HOW MANY DOLLARS YOU MAKE FOR EACH DOLLAR YOU LOSE. A PROFIT FACTOR ABOVE 1 MEANS YOUR STRATEGY IS PROFITABLE

#VIEW HOW THE STRATEGY PERFORMED
chart.Posn(Portfolio = portfolio.st, Symbol = "SPY")


#ADDING INDICATORS TO CHART.POSN
sma50 = SMA(x = Cl(SPY), n = 50)
sma200 = SMA(x = Cl(SPY), n = 200)
dvo = DVO(HLC(SPY), navg = 2, percentlookback = 126)

chart.Posn(Portfolio = portfolio.st, Symbol = "SPY")
add_TA(sma50, on = 1, col="blue")
add_TA(sma200, on = 1, col="red")
add_TA(dvo)



#COMPUTE SHARPE_RATIO
  #GET INSTRUMENT RETURNS
  instrets = PortfReturns(portfolio.st)
  SharpeRatio.annualized(instrets, geometric = FALSE)
  
  
#BLUE LINE = TOOK A POSITION. LINE LESS THEN ZERO IS A BET ON DECREASING PRICES
#GREEN LINE IS THE VALUE OF THE PORTFOLIO OVER TIME
#RED LINE IS THE DRAWDOWN CHARTE. DRAWDOWN = THE AMOUNT OF MONEY LOST SINCE A NEW HIGH
#GREEN TRIANGLES ARE BUY ORDERS AND RED TRIANGLES OR SELL ORDERS


#WANT TO SEE TRADES AND WHAT MY INDICATORS WERE ON THAT DAY


  data.frame(getOrderBook(portfolio.st)[1])
  tradeStats(portfolio.st, Symbols = "SPY")
  View(tradeOrderStats(portfolio.st, symbol = "SPY"))
  mktdata
  
#merge order book and mktdata 
  x = data.frame(getOrderBook(portfolio.st)[1]) 
  x["dates"] =  row.names(x)
  y = data.frame(mktdata)
  y["dates"] = row.names(data.frame(mktdata))
  findal_book = merge(x=x, y=y, by.x = "dates", by.y = "dates", all.x = TRUE)
  