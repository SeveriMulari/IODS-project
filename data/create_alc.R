data_mat <- read.csv("C:\\Users\\sever\\OneDrive\\Desktop\\IODS-project\\data\\student-mat.csv", sep = ";", header = TRUE)
data_por <- read.csv("C:\\Users\\sever\\OneDrive\\Desktop\\IODS-project\\data\\student-por.csv", sep = ";", header = TRUE)

str(data_mat)
str(data_por)
#Variables are same in both datasets


dim(data_por)
#395 observations and 33 variables
dim(data_mat)
#649 observations and 33 variables

summary(data_mat)
summary(data_por)

library(dplyr)

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet") 
mat_por <- inner_join(data_mat, data_por, by = join_by, suffix = c(".data_mat", ".data_por"))

str(mat_por)
dim(mat_por)
#382 observations and 53 variables

alc <- select(mat_por, one_of(join_by))
notjoined_columns <- colnames(data_mat)[!colnames(data_mat) %in% join_by]
notjoined_columns


for(column_name in notjoined_columns) {
  two_columns <- select(mat_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
if(is.numeric(first_column)) {
  alc[column_name] <- round(rowMeans(two_columns))
} else {
  alc[column_name] <- first_column
 }
}  
  
glimpse(alc)
  
library(dplyr); library(ggplot2)

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc)

write.csv(alc)

write.table(alc, file = "create_alc2")






