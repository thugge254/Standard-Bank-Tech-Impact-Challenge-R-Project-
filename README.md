Standard Bank Tech Impact Challenge

Project Overview

The Standard Bank Tech Impact Challenge is a competition aimed at predicting the likelihood of credit default for e-commerce clients. This challenge was hosted in collaboration with Xente, a Ugandan e-commerce startup, and Standard Bank. The objective of the challenge is to build a machine learning model that predicts which individuals are most likely to default on their loans based on loan repayment behavior and e-commerce transaction activity.

Problem Statement

The Uganda FinScope 2018 survey revealed that 46% (8.5 million) of adults borrowed money in the past 12 months, with the majority borrowing to cover living expenses. Most of this borrowing comes from informal lenders. Xente provides an opportunity for consumers to access loans via their mobile phones, but there is a need for a more robust credit risk assessment system to ensure responsible lending and reduce financial risk.

Objectives

Develop a predictive model to determine the probability of loan default.

Improve Xente's credit decision processes.

Enhance financial inclusion by increasing access to credit for creditworthy customers.

Reduce non-performing loans and improve financial sustainability.

Data

The dataset provided for this challenge includes:

Transaction Data: Contains records of customer transactions.

Loan Repayment Data: Contains historical information on previous loans and repayment patterns.

Demographic Data: Contains basic customer information such as age, location, and financial history.

Data Format

TransactionId

IsDefaulted

TransactionId_925

0

TransactionId_1080

1

TransactionId_2315

0

TransactionId_1466

0

TransactionId_337

1

The target variable IsDefaulted is a binary classification label where:

1 indicates that the client defaulted on their loan.

0 indicates that the client successfully repaid their loan.

Evaluation Metric

The evaluation metric for this challenge is the Area Under the Curve (AUC), which measures the model's ability to distinguish between defaulters and non-defaulters.

Rules & Guidelines

Participants can use only the provided datasets for model training.

Publicly available, open-source packages can be used.

Teams must comply with competition guidelines.

Maximum 10 submissions per day (increased to 30 after the competition closed).

Timeline

Standard Bank Tech Impact Challenge

Competition Start: August 30, 2019, 8:00 AM SAST

Competition End: August 30, 2019, 1:00 PM SAST

Points Competition

Reopened: After the Standard Bank Tech Impact Challenge

Final Submission Deadline: December 1, 2019 (11:59 PM GMT)

Prizes

No cash prizes were awarded for this challenge.

Top 10 submissions earned up to 2000 Zindi Points.

How to Use This Repository

This repository contains the code and documentation related to the Standard Bank Tech Impact Challenge. It includes:

Data Preprocessing: Cleaning and transforming raw data.

Exploratory Data Analysis (EDA): Visualizing trends and distributions.

Feature Engineering: Creating meaningful variables to improve predictions.

Model Training: Building and evaluating machine learning models.

Submission: Generating final predictions for evaluation.

Technologies Used

Python (pandas, NumPy, scikit-learn, XGBoost, LightGBM)

Jupyter Notebook for data exploration and modeling

GitHub for version control and collaboration

About Xente

Xente is a Ugandan fintech company providing e-commerce and financial services, including loans, bill payments, and mobile transactions.

About Standard Bank Tech Impact Challenge

The Standard Bank Tech Impact Challenge (SBTIC) is a South African student competition aimed at testing programming, teamwork, and problem-solving skills in the field of AI and machine learning.

For more details, visit the Standard Bank Tech Impact Challenge website (link placeholder).
