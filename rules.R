#SPECIFY HOW YOU WILL SHAPE YOUR TRANSACTION,#EXIT THE POSITION ONCE THE 50 DAY DROPS BELOW THE 200 DAY SMA
#THIS IS AN EXIT RULE
add.rule(strategy.st, name = "ruleSignal",
         arguments = list(
           #specifies the signal column in your strategy
           sigcol = "filterexit",
           #THE VALUE YOUR RULE SHOULD TAKE TO TRIGGER THE RULE
           sigval = TRUE,
           #REDUCES YOUR POSITION TO ZERO 
           orderqty = "all",
           #CAN DO A LIMIT ORDER TOO
           ordertype = "market",
           #CAN GO LONG OR SHORT
           orderside = "long",
           #SPECIFIES WHETHER OR NOT TO IGNORE ALL OTHER SIGNALS ON THE SAME DATE THAT THE STRATEGY ACTS UPON ONE SIGNAL
           replace = FALSE,
           #CAN OVERRIDE THE NEXT BAR MECHANISM (SIGNAL TUESDAY PLACE ORDER WEDNSDAY) 
           #OPEN = BUY AT THE NEXT DAYS OPENING PRICE
           prefer = "Open"),
         type = "exit"
         )

#1= ON
#0=OFF

#THIS IS AN ENTRY RULE WITH A SET ORDERQTY
add.rule(strategy.st, name = "ruleSignal",
         arguments = list(
         sigcol = "longentry",
         sigval = TRUE,
         orderqty = 1,
         ordertype = "market",
         orderside = "long",
         replace = FALSE,
         prefer = "Open"),
     type = "enter"
    )

















