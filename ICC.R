install.packages("irr")
library(irr)	#Load the irr package (must already be installed)


marius <- read.csv2("Data/Torrence_Full_Marius.csv")
qi <- read.csv2("Data/Torrence_Full_Qi.csv")


#fluency
fluencyMarius = c(marius$task1.flu, marius$task2.flu, marius$task3.flu, marius$task5.flu)
fluencyQi = c(qi$task1.flu, qi$task2.flu, qi$task3.flu, qi$task5.flu)
matFlu= matrix(c(fluencyQi, fluencyMarius), nrow=length(fluencyQi))
print(icc(matFlu, model="twoway", type="consistency", unit="average"))

##originality
origMarius = c(marius$task1.orig, marius$task2.orig, marius$task3.orig, marius$task4.orig, marius$task5.orig)
origQi = c(qi$task1.orig, qi$task2.orig, qi$task3.orig, qi$task4.orig, qi$task5.orig)
matOri= matrix(c(origQi, origMarius), nrow=length(origMarius))
print(icc(matOri, model="twoway", type="consistency", unit="average"))

#elaboration
origMarius = c(marius$task1.ela, marius$task5.ela)
elaQi = c(qi$task1.ela, qi$task5.ela)
matEla= matrix(c(elaQi, origMarius), nrow=length(origMarius))
print(icc(matEla, model="twoway", type="consistency", unit="average"))

#resistence
resMarius = c(marius$task1.res, marius$task3.res, marius$task4.res, marius$task5.res)
resQi = c(qi$task1.res, qi$task3.res, qi$task4.res, qi$task5.res)
matRes= matrix(c(resQi, resMarius), nrow=length(resMarius))
print(icc(matRes, model="twoway", type="consistency", unit="average"))

#abstractness
absMarius = c(marius$task2.abs, marius$task3.abs, marius$task4.abs, marius$task5.abs)
absQi = c(qi$task2.abs, qi$task3.abs, qi$task4.abs, qi$task5.abs)
matAbs= matrix(c(absMarius, absQi), nrow=length(absMarius))
print(icc(matAbs, model="twoway", type="consistency", unit="average"))

