#Severi Mulari 09.12.2018
#This is the data wrangling exercise for week 6:


# 1) Loading the data into R:

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = TRUE, sep = " ")
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = "\t")

#Let's have a look at the data:

names(BPRS)
str(BPRS)
summary(BPRS)

#As is apparrent, the BPRS data depicts 40 patients and their BPRS-scores over an 8-week period. It appears that there is a declining trend in the patients' median BPRS scores.

names(RATS)
str(RATS)
summary(RATS)

#Here we have a dataset depicting three groups of rats in a nutrition study, where the rats' weights were measured repeatedly. It appears there is an increasing trend in the median weight of the rats.

# 2) Converting categorical variables to factors:

library(dplyr)
library(tidyr)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# 3) Converting data sets to long form:

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
RATSL <-  RATS %>% gather(key = WD, value = rats, -ID, -Group)

#Adding variable "week" to BPRS and "Time" to RATS:

BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))
RATSL <- RATSL %>% mutate(Time = as.integer(substr(WD,3,4)))

# 4) Let's have a serious look at the data sets in their long form:

names(BPRSL)
str(BPRSL)
summary(BPRSL)

names(RATSL)
str(RATSL)
summary(RATSL)

#We now fully appreciate the crucial differences between the wide and long forms, great!

#let's save the BPRSL and RATSL dataset for subsequent use:

write.table(BPRSL, file = "BPRSL")
write.table(RATSL, file = "RATSL")

#let's move to the analysis exercise!

#THE END.
