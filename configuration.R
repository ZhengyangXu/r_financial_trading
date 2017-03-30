#INITIAL CONFIGURATION
  library(quantstrat)
  
  #INITIALIZE DATE FOR THE BACKTEST
  initDate = "1999-01-01"
  
  #START OF THE DATA
  from = "2003-01-01"
  
  #END OF THE DATA
  to = "2015-12-31"
  
  #SET THE TIMEZONE
  Sys.setenv( TZ = "UTC")
  
  #SET THE CURRENCY TO USD
  currency("USD")
  
  
#GET STOCK DATA
  
  library(quantmod)
  
  #RETRIEVE SPY FROM YAHOO
  getSymbols("SPY", from =from, to = to, src="yahoo", adjust=TRUE)
  
  #INITIALIZES SPY AND SETS CURRENCY TO USD. TELLS QUANTSTRAT WHICH INSTRUMENTS WILL BE PRESENT FOR THE SIMULATION.
  stock("SPY", currency = "USD")

#NAME AND SET INITIAL SETTINGS 
  tradesize = 100000
  initeq = 100000
  
  #DEFINE THE NAMES OF THE STRATEGY, PORTFOLIO AND ACCOUNT
  strategy.st = "jakestrat"
  portfolio.st = "jakestrat"
  account.st = "jakestrat"
  
  #REMOVE STRATEGY IF IT EXISTS 
  rm.strat(strategy.st)
  
#FINAL INITIALIZATIONS
  
  #INITIALIZE PORTFOLIO
  initPortf(portfolio.st, symbols = "SPY", initDate = initDate, currency = "USD")
  
  #INITIALIZE THE ACCOUNT
  initAcct(account.st, portfolios = portfolio.st, initDate = initDate, currency = "USD", initEq = initeq)
  
  #INITIALIZE THE ORDERS 
  initOrders(portfolio.st, initDate = initDate)
  
  #STORE THE STRATEGY
  strategy(strategy.st, store = TRUE)
  
  
  
  
  
    
  
  
  
  
  