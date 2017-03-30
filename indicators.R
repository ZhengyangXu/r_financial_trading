#CREATE A 200 DAY MOVING AVERAGE
  spy_sma = SMA(x= Cl(SPY), n = 200)
  
  # CREATE AN RSI WITH A THREE DAY LOOKBCAK PERIOD. RSI IS THE RELATIVE STRENGTH INDEX. FORMULA THAT EXPRESSES THE FRACTION OF GAINS AND LOSSES OVER THE PAST LOOKBACK PERIODS
  #100-(100/(1+RS)) WHERE RS IS THE AVERAGE GAIN OVER THE AVERAGE LOSS OVER THE LOOKBACK WINDOW DECIDED
  spy_rsi = RSI(price = Cl(SPY), n = 3)
  
  
  #VISUALIZE THE INDICATORS
  plot(Cl(SPY))
  lines(spy_sma, col = "red")
  
#IMPLEMENT AN IDICATOR
  
  #ADD THE 200 DAY SIMPLE MOVING AVERAGE TO YOUR STRATEGY. THE add.indicator FUNCTION TELLS QUANTSTRAT YOU WISH TO ADD THE INDICATOR TO YOUR STRATEGY 
  add.indicator(strategy = strategy.st,
                #ADD THE SMA FUNCTION
                name = SMA,
                #ASKS FOR THE ARGUMENTS TO THE NAME FUNCTION. MKTDATA IS USED BC THE DATA WILL CHANGE DEPENDING ON WHAT INSTRUMENT IS USED AT THE TIME AND QUOTE ALLOWS THE DATA TO CHANGE OVER TIME???
                arguments = list(x = quote(Cl(mktdata)), n = 200),
                #LABEL YOUR INDICATOR
                label = "SMA200"
                )
  #ADD A 50 DAY SMA IDICATOR
  add.indicator(strategy = strategy.st,
                #ADD THE SMA FUNCTION
                name = SMA,
                #ASKS FOR THE ARGUMENTS TO THE NAME FUNCTION. MKTDATA IS USED BC THE DATA WILL CHANGE DEPENDING ON WHAT INSTRUMENT IS USED AT THE TIME AND QUOTE ALLOWS THE DATA TO CHANGE OVER TIME???
                arguments = list(x = quote(Cl(mktdata)), n = 50),
                #LABEL YOUR INDICATOR
                label = "SMA50"
                )
  #ADD AN RSI INDICATOR TO YOUR STRATEGY
  add.indicator(strategy = strategy.st,
                name = "RSI",
                arguments = list(price = quote(Cl(mktdata)),n = 3),
                label = "RSI_3"
                )
#CODE MY OWN IDICATOR 1 
  RSI_avg = function(price, n1, n2){
    rsi_1 = RSI(price = price, n = n1)
    rsi_2 = RSI(price = price, n = n2)
    RSI_avg = (rsi_1 + rsi_2)/2
    colnames(RSI_avg) = "RSI_avg"
    return(RSI_avg)
  }
  add.indicator(strategy.st, name = "RSI_avg", arguments = list(price=quote(Cl(mktdata)), n1 = 3, n2 = 4), label = "RSI_3_4")


#CODE OWN INDICATOR 2
  #DAVID VARADI INDICATOR #HOW DOES THE CURRENT RATIO COMPARE TO LAST 126 DAYS
  DVO = function(HLC, navg = 2, percentlookback = 126){
    ratio = Cl(HLC)/((Hi(HLC) +Lo(HLC))/2)
    #SMOOTH OUTPUTS USING MOVING AVERAGE
    avgratio = SMA(ratio, n = navg)
    out = runPercentRank(avgratio, n = percentlookback, exact.multiplier = 1)*100
    colnames(out)= "DVO"
    return(out)
  }
  add.indicator(strategy = strategy.st, name = "DVO", arguments = list(HLC = quote(HLC(mktdata)),navg = 2, percentlookback = 126),label = "DVO_2_126")
  
#APPLY INDICATORS TO TEST 
test = applyIndicators(strategy = strategy.st, mktdata = OHLC(SPY))
test_subset = test["2013-09-01/2013-09-05"]
  


  



