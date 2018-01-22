library(ggplot2)


setwd("D:/Data Science/Course 2 - Statistics & Exploratory Data Analytics/Group Project - Loan Default")
input <- read.csv("loan.csv", stringsAsFactors = FALSE)

#remove columns with all NAs
input_NoNAs <-  input[, colSums(is.na(input)) < nrow(input)]

#removing columns which are of no use (like most of those are 0 values, values of no importance)

input_subset <- subset( input_NoNAs, select = -pymnt_plan )
input_subset <- subset( input_subset, select = -url )
input_subset <- subset( input_subset, select = -initial_list_status )
input_subset <- subset( input_subset, select = -collections_12_mths_ex_med )
input_subset <- subset( input_subset, select = -policy_code )
input_subset <- subset( input_subset, select = -application_type )
input_subset <- subset( input_subset, select = -acc_now_delinq )
input_subset <- subset( input_subset, select = -chargeoff_within_12_mths )
input_subset <- subset( input_subset, select = -delinq_amnt )
input_subset <- subset( input_subset, select = -tax_liens )

#To have a view of how many loans are in 36 and 60 months bracket
ggplot(input_subset, aes(x = term)) + geom_bar(stat = "count") + 
  geom_text(stat = 'count', aes(label = ..count..), vjust = -0.5)

# To have a view on different status of loan
ggplot(input_subset, aes(x = loan_status)) + geom_bar(stat = "count") + 
  geom_text(stat = 'count', aes(label = ..count..), vjust = -0.5)

#Only the charged of we are interested
charged_off <- subset(input_subset, loan_status == "Charged Off")

#To have a view on the status per state
ggplot(charged_off, aes(x = addr_state)) + geom_bar(stat = "count") + 
  geom_text(stat ='count', aes(label = ..count..), vjust = -1)
#from this it is clear that "CA" state is one of the driving factor for default loan

#To have a view based on the grade
ggplot(charged_off, aes(x = grade)) + geom_bar(stat = "count")
#there could be a conclusion that grades with B, C,D are driving factors for default

#to have a view with respect to verification status
ggplot(input_subset, aes(x = verification_status, col = loan_status)) + geom_bar(stat = "count")
#looks like verification status is not having influence