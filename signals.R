#SMA50 MUST BE GREATER THAN SMA200 
add.signal(strategy.st, name = "sigComparison",
           arguments = list(columns = c("SMA50", "SMA200"),relationship = "gt"),
           label = "longfilter")

#SPECIFIES WHEN SMA50 CROSSES OVER SMA200
add.signal(strategy.st, name ="sigCrossover",
           arguments = list(columns = c ("SMA50", "SMA200"), relationship = "lt"),
           label = "filterexit"
           )

#SPECIFIES DVO_2_126 MUST BE LESS THAN 20. if dvo_2_126 is lover than 20 it will return true.
#ONE OF TWO SWITCHES THAT NEED TO BE ON IN ORDER TO ENTER INTO A LONG POSITION IN THIS STRATEGY
add.signal(strategy.st, name = 'sigThreshold',
           arguments = list(column= "DVO_2_126",
                            threshold = 20,
                            relationship = "lt",
                            #INTERESTED IN EVERY INSTANCE THAT THE OSCILLATOR IS LESS THAN 20 NOT JUST WHEN IT CROSSES OVER
                            cross = FALSE
                            ),
           label = "longthreshold"
           )

#SIGNAL TO EXIT A STRATEGY
add.signal(strategy.st, name = "sigThreshold",
           arguments = list(column="DVO_2_126",
                            threshold = 80,
                            relationship = "gt",
                            #INTERESTED ONLY WHEN THERE IS A CROSSOVER
                            cross = TRUE
                            ),
           label = "thresholdexit"
           )


test_init = applyIndicators(strategy.st, mktdata = OHLC(SPY))
test = applySignals(strategy = strategy.st, mktdata = test_init)

#ENTER INTO A POSITION IF LONGFILTER AND LONGTHRESHOLD ARE TRUE. SIGFORMULA IS JUST AN IF STATEMENT
#IDEA IS YOU DON'T WANT TO KEEP ENTERING INTO A POSITON AS LONG AS CONDITIONS HOLD TRUE BUT YOU DO WANT TO HOLD A POSITION WHEN THERES A PULLACK IN AN UPTRENDING ENVIRONMENT
add.signal(strategy.st, name = "sigFormula",
           arguments = list(formula = "longfilter & longthreshold",
                            cross = TRUE
           ),
           label = "longentry"
)




