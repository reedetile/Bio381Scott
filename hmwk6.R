###Libraries###
library(ggplot2)
library(MASS)

###Question1###

#Creating dummy dataframe
z <- rnorm(n=3000,mean=0.2)
z <- data.frame(1:3000,z)
names(z) <- list("ID","myVar")
z <- z[z$myVar>0,]
str(z)
summary(z$myVar)

#plot
p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 
print(p1)

#adds curve to plot
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
print(p1)

#fitting a normal distribution
normPars <- fitdistr(z$myVar,"normal")
print(normPars)
str(normPars)
normPars$estimate["mean"] # note structure of getting a named attribute

#Plot Normal 
meanML <- normPars$estimate["mean"]
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(z$myVar),len=length(z$myVar))

stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="red", n = length(z$myVar), args = list(mean = meanML, sd = sdML))
p1 + stat

#Plot Exponential Dist
expoPars <- fitdistr(z$myVar,"exponential")
rateML <- expoPars$estimate["rate"]

stat2 <- stat_function(aes(x = xval, y = ..y..), fun = dexp, colour="blue", n = length(z$myVar), args = list(rate=rateML))
p1 + stat + stat2

#Plot uniform prob. dist
stat3 <- stat_function(aes(x = xval, y = ..y..), fun = dunif, colour="darkgreen", n = length(z$myVar), args = list(min=min(z$myVar), max=max(z$myVar)))
p1 + stat + stat2 + stat3

#Plot Gamma prob dist
gammaPars <- fitdistr(z$myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]

stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="brown", n = length(z$myVar), args = list(shape=shapeML, rate=rateML))
p1 + stat + stat2 + stat3 + stat4

#Plot Bet prob dens
pSpecial <- ggplot(data=z, aes(x=myVar/(max(myVar + 0.1)), y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) + 
  xlim(c(0,1)) +
  geom_density(size=0.75,linetype="dotted")

betaPars <- fitdistr(x=z$myVar/max(z$myVar + 0.1),start=list(shape1=1,shape2=2),"beta")
shape1ML <- betaPars$estimate["shape1"]
shape2ML <- betaPars$estimate["shape2"]

statSpecial <- stat_function(aes(x = xval, y = ..y..), fun = dbeta, colour="orchid", n = length(z$myVar), args = list(shape1=shape1ML,shape2=shape2ML))
pSpecial + statSpecial


###Question2##
setwd('D:/Dropbox/Reed/2019/DensityModifiedContagion')
DMC <- read.table("DMC.master.csv",header=TRUE,sep=",")
str(DMC)
summary(DMC)
#plot
p1 <- ggplot(data=DMC, aes(x=Sum, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 
print(p1)

#adds curve to plot
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
print(p1)

#fitting a normal distribution
normPars <- fitdistr(DMC$Sum,"normal")
print(normPars)
str(normPars)
normPars$estimate["mean"] # note structure of getting a named attribute

#Plot Normal 
meanML <- normPars$estimate["mean"]
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(DMC$Sum),len=length(DMC$Sum))

stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="red", n = length(DMC$Sum), args = list(mean = meanML, sd = sdML))
p1 + stat

#Plot Exponential Dist
expoPars <- fitdistr(DMC$Sum,"exponential")
rateML <- expoPars$estimate["rate"]
rateML

stat2 <- stat_function(aes(x = xval, y = ..y..), fun = dexp, colour="blue", n = length(DMC$Sum), args = list(rate=rateML))
p1 + stat + stat2

#Plot uniform prob. dist
stat3 <- stat_function(aes(x = xval, y = ..y..), fun = dunif, colour="darkgreen", n = length(DMC$Sum), args = list(min=min(DMC$Sum), max=max(DMC$Sum)))
p1 + stat + stat2 + stat3

########My data is not fitting a gamma distribution, so I didn't run this########
#Plot Gamma prob dist
#gammaPars <- fitdistr(DMC$sum,"gamma")
#shapeML <- gammaPars$estimate["shape"]
#rateML <- gammaPars$estimate["rate"]


#stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="brown", n = length(DMC$Sum), args = list(shape=shapeML, rate=rateML))
#p1 + stat + stat2 + stat3 + stat4

########My data is not fitting a beta distribution, so I didn't run this########
#Plot Beta prob dens
# pSpecial <- ggplot(data=DMC, aes(x=Sum/(max(Sum + 0.1)), y=..density..)) +
#   geom_histogram(color="grey60",fill="cornsilk",size=0.2) + 
#   xlim(c(0,1)) +
#   geom_density(size=0.75,linetype="dotted")
# 
# betaPars <- fitdistr(x=DMC$Sum/max(DMC$Sum + 0.1),start=list(shape1=1,shape2=2),"beta")
# shape1ML <- betaPars$estimate["shape1"]
# shape2ML <- betaPars$estimate["shape2"]
# 
# statSpecial <- stat_function(aes(x = xval, y = ..y..), fun = dbeta, colour="orchid", n = length(DMC$Sum), args = list(shape1=shape1ML,shape2=shape2ML))
# pSpecial + statSpecial
#

###Question 4###

#setup fake data
dmcDUMMY <- rexp(n = 96, rate = 0.002664151)
dmcDUMMY <- data.frame(1:96, dmcDUMMY)
names(dmcDUMMY) <- list("ID","sum")

expoPars <- fitdistr(dmcDUMMY$sum,"exponential")
rateML <- expoPars$estimate["rate"]
rateML #close to set rate

dummy <- ggplot(data=dmcDUMMY, aes(x=sum, y=..density..)) +
  geom_histogram(color="grey60",fill="cornsilk",size=0.2) 

dummy_exp_line <- stat_function(aes(x = xval, y = ..y..), fun = dexp, colour="blue", n = length(dmcDUMMY$sum), args = list(rate=rateML))
dummy + dummy_exp_line
