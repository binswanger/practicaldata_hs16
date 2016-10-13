
###############################
# Solution homework Lecture 3 #
###############################

saveFun = function(spend, interest, horizon){
  x = spend
  r = interest
  T = horizon
  round( x/(1+r/100)^T )
}

# Aufg 1
########
Tvec = seq(10, 50, 10)
rvec = seq(0, 8, 0.5)


Y = matrix(NA, length(rvec), length(Tvec))


# Aufg 2
########

Y[3, ] = rep(1, length(Tvec))
Y

Y[3, ] = rep(NA, length(Tvec))


# Aufg 3
########

for (i in 1:length(rvec)){
  
  Y[i,] = saveFun(1000, rvec[i], Tvec)
  
}
Y

# This does exactly the same as
Y[1,] = saveFun(1000, rvec[1], Tvec)
Y[2,] = saveFun(1000, rvec[2], Tvec)
    # ...
Y[17,] = saveFun(1000, rvec[17], Tvec)
# It would be kind of dumb to write this 17 times...


# There is no need for a double loop! You can put the entire
# Tvec as an argument into saveFun:
saveFun(1000, 4, Tvec)


# Aufg 4
########

# Just an example
colnames(Y) = paste0("T=", as.character(Tvec))
rownames(Y) = paste0("r=", as.character(rvec), "%")
Y

# Aufg 5

matplot(rvec, Y, type = "l")

# Do not forget the rvec as the x-variable,
# Otherwise the axis labels of the x axis will not fit.


# Aufg 6
########

matplot(rvec, Y, type = "l", col = 1:ncol(Y), lwd = 2, lty=1,
        xlab = "Rate of return", ylab = "Savings needed to get 1000 after T years",
        main = "Required savings as a function of interest rates")

grid()
legend('topright', inset=.05, legend=colnames(Y), 
       col = 1:ncol(Y), lty = 1, lwd = 2)



