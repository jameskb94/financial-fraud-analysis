library(dplyr)

transactions <- read.csv("data.csv")

## Missing values per column ####

missingValues <- colSums(is.na(transactions))

# no missing values...

## Count total records ####

nRecords <- nrow(transactions)

# 6,362,620 records...

## Check for duplicate rows ####

nDuplicates <- sum(duplicated(transactions))

# 0 duplicates detected...

# Distributions ####

## Overall fraud rate ####

totalFraudRate <- transactions %>%
  count(isFraud) %>%
  mutate(percentage = n / sum(n) * 100)

# Only ~8000ish records are true fraud...
# comprises about 0.13% of all transactions...

## transaction type frequency ####

transactionType <- transactions %>%
  count(type, sort = TRUE) %>%
  mutate(percentage = n / sum(n) * 100)

# Financial exposure ####

exposure <- transactions %>%
  group_by(isFraud) %>%
  summarise(
    transactions = n(),
    total_value = format(sum(amount),scientific = FALSE),
    mean_value = mean(amount),
    median_value = median(amount),
    .groups = "drop"
  )

exposureRatio <- (as.numeric(exposure[2,3])/as.numeric(exposure[1,3]))
# fraudulent transaction value accounts for 1.06% of total transaction value despite making up only 0.13% of all transactions

# Fraud by transaction type ####

fraudByTransactionType <- transactions %>%
  group_by(type) %>%
  summarise(
    transactions = n(),
    fraud_count = sum(isFraud),
    fraud_rate = mean(isFraud),
    fraud_value = sum(amount[isFraud==1]),
    .groups = "drop"
  ) %>%
  arrange(desc(fraud_value))

#fraudulent transactions are roughly 8.2x the average legitimate transaction in value
#fraud is concentrated around 'Transfer' and 'Cash out' transfer types
#fraud rate is 0.1% for cash out, and 0.7% for transfers
#financial exposure is similar across both types

# assessing the flaggedFraud field

flaggedFreq <- transactions %>%
  count(isFraud, isFlaggedFraud)

#very low detection rate of 0.19% - 16 of 8213 fraudulent transactions caught
# 100% precision; no recall
