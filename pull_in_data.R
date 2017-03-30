#THIS STRATEGY USE QUANTMOD TO PULL IN ETF DATA

getSymbols("SPY", from ="2015-01-01", to ="2016-12-25", src="yahoo", adjust=TRUE)
plot(Cl(SPY))

#add a moving average to your data
lines(SMA(Cl(SPY)), col="red")



