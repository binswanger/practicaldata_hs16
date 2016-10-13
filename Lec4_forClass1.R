
############################################
# LECTURE 4, Part 1: Completing function   #
# from last time with an optional argument #
############################################

# During Lecture 3 we worked on a function with an optional
# or "NULL" argument: if the argument get.out.as.text is not NULL,
# then the function saveFun would get the output as text.

# In this function, we introduced two new R functions:
# sprintf, and the conditional.


# sprintf
#########


x = 5000; T = 30; r = 4
out = round(  x/(1+r/100)^T  )
# Note that you can run several commands on one line, 
# separated by semicolons


sprintf("If you want to spend %s after %s years
and the interest rate is %s percent, 
you have to save %s.", x, T, r, out)


# Note: The s in "%s" means "string". See Section 8.2 in 
# "R for Everyone".

# If you want get rid of the editing symbols like "" or \n, you have
# to use the cat function


cat(sprintf("If you want to spend %s after %s years
and the interest rate is %s percent, 
    you have to save %s.", x, T, r, out))


# Note what happens if the text in the third line above 
# has an indent...


# Conditionals
##############

# See Chapter 9 in "R for Everyone"

arg = "no"

if (arg ==  "no"){
  print("I have nothing to say :-(")
}


# So what if arg = "yes"?

arg = "yes"

if (arg ==  "no"){
  print("I have nothing to say :-(")
}


arg = "no"

if (arg ==  "no"){
  print("I have nothing to say :-(")
} else if (arg=="yes"){
  print(":-))")
}
    
# Be very careful with the positions of the curly brackets
# If they are not in the right position, you will get
# an error. This can sometimes be quite tricky.


# Now let's make a function of this

saySomething = function(arg){
  
  #copy/paste from above
  if (arg ==  "no"){
    print("I have nothing to say :-(")
  } else if (arg=="yes"){
    print(":-))")
  }
}

saySomething("no")
saySomething("yes")


# Now we go back to our savings function
########################################

a = NULL
b = "yes"
is.null(a)
is.null(b)

saveFun = function(spending = 5000, 
                   interestRate = 4,
                   horizon = 30,
                   get.out.as.text = NULL){
  x = spending
  r = interestRate
  T = horizon
  out = round(  x/(1+r/100)^T  )
  
  if (is.null(get.out.as.text)){
    return(out)
    # everything in a function that comes after return is not executed
    # if return is executed...
  
  } else if (get.out.as.text == "yes"){
    cat(sprintf("If you want to spend %s after %s years
and the interest rate is %s percent, 
you have to save %s!", x, T, r, out))
  }
}
  
saveFun()
saveFun(get.out.as.text = "yes")

saveFun(spending = 5000, 
        interestRate = 1,
        horizon = 30,
        get.out.as.text = "yes")

  
saveFun(spending = 5000, 
        interestRate = -0.5,
        horizon = 30)



