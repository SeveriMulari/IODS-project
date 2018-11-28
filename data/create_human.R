#Week 4; data wrangling assessment: (Week 5 assessment also, see below!)

# 1) File created
# 2) Reading data into R:

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# 3) Exploring the datasets:

dim(hd)
str(hd)

#The hd-dataset contains data on 194 countries, including details on their respective human development indexes, expected years of education, gross national income etc. Altogether 195 obs. across 8 variables.

dim(gii)
str(gii)

#The gii-dataset contains data on 194 countries, including details on their respective gender inequality indexes, maternal mortality ratios, female representation in parliament etc. Altogether 195 obs. across 10 variables.

#Let's create summaries of the variables included in the above-mentioned datasets:

summary(hd)
summary(gii)

# 4) Renaming variables

colnames(hd) <- c("HDI_rank", "country", "HDI", "exp_life", "exp_educ", "educ", "GNIpc", "GNIHDI_rank")
colnames(gii) <- c("GII_rank", "country", "GII", "mortality_maternal", "birth_adolescent", "female_parliament", "female_secondary", "male_secondary", "female_work", "male_work")

# 5) Creating new variables:

library(dplyr)
gii <- mutate(gii, sex_secondary = (female_secondary/male_secondary))
gii <- mutate(gii, sex_work = (female_work/male_work))

# 6) Joining the two datasets:

join_by <- "country"
hd_gii <- inner_join(hd, gii, by = join_by)
dim(hd_gii)

#We now have 195 obs. across 19 variables, as we should have.

#Let's rename the data and save it to a specified folder:

human <- hd_gii
write.table(human, file = "human")

dim(human)
str(human)

# So there is 195 observations and 19 variables in human data. Human data includes data from health and education.

install.packages("stringr")
library(stringr)

#Transfering GNI variable to numeric
str(human$GNIpc)
str_replace(human$GNIpc, pattern=",", replace ="") %>% as.numeric

#Now lets exclude some unneeded variables

install.packages("dplyr")
library(dplyr)

keep <- c("country", "sex_secondary", "sex_work", "exp_educ", "exp_life", "GNIpc", "mortality_maternal", "birth_adolescent", "female_parliament")
human <- select(human, one_of(keep))

#removing missing values

complete.cases(human)

data.frame(human[-1], comp = complete.cases(human))

human_ <- filter(human, complete.cases(human))

# removing observations which are related to regions instead of countries
tail(human, 10)

last <- nrow(human_) - 7
human_ <- human_[1:last, ]

#adding coutries as row names
rownames(human_) <- human_$Country


install.packages("dplyr")
library(dplyr)

#removing the country variable

rownames(human_) <- human_$country
human_ <- select(human_, -country)

#Overwriting and saving

human <- human_
write.table(human, file = "human")




#THE END of week 5.
