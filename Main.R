#In this coding practice assignment, I'm going to measure the relationship between internet usage 
#and the voter turnout, the database I use would be 2012 internet usage by state and 2020 election 
#voter turnout by state, assume the internet usage doesnt change in 2020.

#import data
library(readxl)
IU <- read_excel("~/Desktop/2012internetusage.xls", skip = 3)
View(IU)
library(readxl)
VT <- read_excel("~/Desktop/2020voterturnout.xlsx", 
                 skip = 3)
View(VT)

#clean 

#drop the NA row
IU <- IU[-1, ]
IU <- IU[-1, ]

IU <- IU[-2, ]
IU <- IU[-52, ]
IU <- IU[-54, ]
IU <- IU[-55, ]
IU <- IU[-56, ]

VT <- VT[-1, ]
VT <- VT[-53, ]
VT <- VT[-53, ]
VT <- VT[-53, ]
VT <- VT[-53, ]
VT <- VT[-53, ]


colnames(IU)[4] = "Internetuse"
colnames(IU)[1] = "State"
colnames(IU)[6] = "somelocation "
colnames(IU)[8] = "fromhome"

colnames(VT)[5] = "registeredTotal"
colnames(VT)[6] = "MOE"
colnames(VT)[7] = "registeredCitizen"
colnames(VT)[8] = "MOE"
colnames(VT)[10] = "votedTotal"
colnames(VT)[11] = "MOE"
colnames(VT)[12] = "votedCitizen"
colnames(VT)[13] = "MOE"

IU$state_upper = toupper(IU$State)
#visualize data
IU[c("Internetuse")] = lapply(IU[c("Internetuse")],as.numeric)

hist(IU$Internetuse)

VT[c("votedTotal")] = lapply(VT[c("votedTotal")],as.numeric)

hist(VT$"votedTotal")

#merge to data table
df = merge(IU, VT, by.x= c("state_upper"), by.y= c("STATE"))

plot(votedTotal ~ Internetuse, data = df,pch = 16)
mod <- lm(votedTotal ~ Internetuse, data = df)
mod
abline(mod)
