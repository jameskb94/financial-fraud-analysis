# Transaction Fraud: Risk & Detection Analysis
An interactive Power BI dashboard analysing 6.36 million simulated financial transactions to assess fraud incidence, financial exposure and the effectiveness of an existing rule-based detection mechanism.

[Screenshots coming soon]

## Project Overview
We are addressing the issue of transaction fraud from within a simulated financial transaction dataset. The project examines a hypothetical financial services provider with substantial exposure to fraudulent transactions and evaluates the effectiveness of an existing rule-based fraud detection mechanism. The purpose of this project is to identify just how much fraud is being missed, the overall monetary exposure to fraud, as well as to provide hypothetical recommendations to improve fraud detection rates. The intended audience of this report would be a key decision maker such as a Fraud Operations Manager, Risk Analyst or a Head of Financial Crime. The dashboard serves mainly as a tool for assessing fraud detection performance, but also provides metrics for ongoing monitoring. The dashboard supports decisions about where fraud monitoring resources should be prioritised and provides a basis for evaluating existing detection methods.

## Dataset and tools

This project uses a synthetic transaction dataset generated using PaySim to address the challenge of obtaining real-world transaction data, which is inherently private. This dataset is constructed from aggregate data of a private dataset to mimic normal transaction operations, with malicious behaviour introduced later to assess the effectiveness of fraud detection methods. Simulated over a 30-day period of typical business activity, the dataset comprises 6.36 million records and includes 11 different variables. These columns cover details such as payment type, transaction amount, whether a transaction is detected as fraud, and whether it is actually fraudulent. Of the 6.36 million records 8,213 of them are confirmed fraudulent transactions.

Given the sheer size of the dataset, R was the most logical choice for conducting the initial exploration and validation. Although minimal, some data preparation was done using Power Query, while DAX was employed to create reusable measures. Power BI was used as the interactive interface for communicating the findings.

## Approach and methodology
I first undertook a quick analysis of the data using RStudio. Initial validation identified no missing values or duplicate records across the 6.36 million transactions. Data types for each of the 11 columns were checked, and some basic descriptive analysis was undertaken to understand the profile and distribution of each variable. This would inform some of the future measures that would need to be created as well as what visuals would work best in the final report.

The final Power BI report consists of two pages, with the first solely on overall fraud rates and exposure. Before pulling together the final report in Power BI I created a number of DAX measures. These included:
- `Fraud Transactions` - represents the raw count of all transactions which are confirmed fraud cases.
- `Fraud Rate` - represents the number of fraudulent transactions as a percentage of the overall number of transactions in the dataset.
- `Fraud Exposure` - represents the total value of confirmed fraudulent transactions.
Among these, some other basic measures were created to capture the total number of transactions as well as the total transaction value across the dataset.

The second page of the Power BI report is setup to evaluate the existing detection rules. To prepare this page I had to setup some more DAX measures:
- `Flagged Transactions`- represents the number of transactions flagged under the detection rules. This measure would include incorrectly flagged false positives.
- `Detected Fraud` - represents the number of fraudulent transactions which were correctly flagged by the detection rules.
- `Detected Fraud Exposure` - represents the transaction value of all correctly flagged fraudulent transactions.
Comparing the `Flagged Transactions` and `isFlaggedFraud` variables allowed me to construct a confusion matrix and evaluate the existing rule using precision, recall and the value of fraudulent transactions left unflagged.

## Key findings

**Finding 1 - Fraud instances are relatively rare but are financially significant:** Fraudulent transactions represent just 0.13% of transaction volume but account for approximately 1.05% of total transaction value. Measuring fraud solely by transaction count leads to all fraud cases being treated equally regardless of their size. Notably, fraudulent transactions are roughly 8.2 times larger than the average legitimate one.

**Finding 2 - Fraud incidence differs by transaction type:** Although TRANSFER and CASH_OUT transactions account for approximately equal numbers of fraudulent cases, their fraud rates differ substantially: 0.77% and 0.18%, respectively. Both categories also contribute approximately equal financial exposure. This demonstrates why monitoring priorities should consider fraud frequency, transaction-level risk and financial exposure rather than relying on any single metric.

**Finding 3 - Existing detection rules have extremely limited coverage:** Overall precision for detection was 100% meaning that there were no false positives, however this figure is based on only 16 flagged transactions. Detection recall was observed to be an incredibly small 0.19%, meaning that 99.8% of all fraud cases were missed, leading to 99.35% of fraudulent transaction value remaining unflagged. Although the detection rule produces no false positives in this dataset, its extremely low recall substantially limits its effectiveness as a comprehensive fraud detection mechanism.

## Recommendations
1. Prioritise fraud monitoring across TRANSFER and CASH_OUT transactions using both fraud incidence and financial exposure. Although transfers exhibit a higher fraud rate, cash-outs account for a comparable amount of fraudulent transaction value and should not be deprioritised solely because of their lower fraud rate.
2. Evaluate additional detection rules or revised thresholds to improve fraud coverage. Any proposed changes should be assessed against their impact on recall, precision, false-positive volumes and investigation workload.

## Limitations
1. The simulated transactions captured within the PaySim software may not represent real-world transaction or fraud patterns.
2. The dataset is ordered chronologically by a 'step' variable, but irregular daily transaction volumes complicate the interpretation of time-based fraud rates and trends, particularly where transaction counts are unusually low.
3. The dataset does not establish the operational outcomes of each transaction i.e. whether they were blocked, investigated, recovered or resulted in financial losses.

## Data Attribution
Synthetic Financial Datasets For Fraud Detection by [Edgar Lopez-Rojas](https://www.kaggle.com/ealaxi)
Available on Kaggle: https://www.kaggle.com/datasets/ealaxi/paysim1

This dataset is part of a paper on the PaySim software.

E. A. Lopez-Rojas , A. Elmir, and S. Axelsson. "PaySim: A financial mobile money simulator for fraud detection". In: The 28th European Modeling and Simulation Symposium-EMSS, Larnaca, Cyprus. 2016

## Technical Implementation
Coming soon
