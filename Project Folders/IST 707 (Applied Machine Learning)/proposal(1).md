# Detecting Fraudulent Listings on Airbnb
## Team
__POC:__ Sophia Jaskoski

__Members:__

Ber Bakermans - AbBakermans 

Sophia Jaskoski - sjaskoski

Marjan Abedini - andia941394 

Tharuni Tekula - ttekula 

## Introduction
The purpose of this project is to be able to detect fraudulent or fake Airbnb listings. We will build 
a model which analyzes patterns among variables included in a standard Airbnb listing like price, location, and amenities to cluster similar listings and identify anomalies among them which may indicate fraudulent activity.

Our approach uses unsupervised learning to flag suspicious Airbnb listings by grouping and profiling similar listings. Listings which deviate from a profiled behavior (e.g. a listing which is $20 per night listing in a part of town where the average rent per night is $100) will be flagged for further investigation. Airbnb’s current system focuses on stopping fake listings before they go live. Our approach aims to catch fraud that slips through the cracks. By looking at unusual patterns in factors like price, location, and ratings, it can adapt and identify new types of fraud. Since we are not relying on labeled data, our method is more flexible in discovering fraud patterns that are not yet known.

The outcome of this project has the opportunity to impact Airbnb guests, hosts, the Airbnb brand, and the local community where these listings exist. Airbnb guests who unwittingly rent from a fraudulent host are at risk of having their personal information stolen and may end up stranded if they arrive in a city only to find their accommodation does not exist. Genuine hosts on the Airbnb platform may have their reputations questioned and their businesses usurped by fraudsters who may steal their photos and listing details or attempt to list a place for a cheaper price. Additionally, the Airbnb company faces potential loss of clientele and must answer questions about failing to protect its users from fraud. And in an age where certain cities like New York are already making moves to smother the short term rental market, negative sentiment towards platforms like Airbnb may inadvertently affect the local tourism economy as travelers are priced out by hotels or subject to limited lodging availability.

## Literature Review
Per Airbnb’s website, they currently use a machine learning model which aims to prevent fake listings before they ever go live[^1]. They consider host reputation, template messaging, and look for duplicate photos before letting a site go live. Beyond that, they have added educational messaging to their site in order to make patrons aware of common scam tactics. If users suspect suspicious behavior, they are also able to flag a listing to be manually reviewed. This policy has been in place since 2017, but articles such as one from USA Today in 2023 reveal that in spite of this, fraudulent listings still manage to slip through the cracks[^2].


While it is not clear whether Airbnb has attempted to upgrade their methods to protect against fraud, a publication from 2019 from The Journal of Scientific and Engineering Research proposed combining Machine Learning and Big Data practices to detect fraud in online travel platforms in real-time[^3]. While this journal did not provide a specific use case, a similar study published in 2024 was performed on real estate listings in Malaysia and was shown to have success in using clustering analysis to classify listings as fake[^4]. We hope to build upon this work by analyzing the standard features of a listing (price, occupancy, location, etc) along with the text from the listing title and details section. In this way, we hope to find relationships among similarly used words or phrasing, which was not attempted in the studies we researched.

The following stakeholders have been identified for this project - 

__Guests:__
Guests seek assurance that the listings they are considering are legitimate. This assurance is vital for making informed choices and avoiding potential scams.

__Hosts:__
Fraudulent activities can damage their reputation and income, making effective fraud detection essential for their business.

__Airbnb:__
Platform managers require effective tools to minimize fraud and enhance overall user trust. These tools are essential for the platform’s long-term viability.


## Data and Methods
__Data__

The data we are using is scraped from the Airbnb website through the Inside Airbnb Project, linked here: https://insideairbnb.com/get-the-data/. The site has data for dozens of global cities, but for the purposes of this project, we decided to use the data for Airbnb’s in Hawaii as this was one of the larger datasets available and we wanted to be able to train an unsupervised model on as much data as we could. The dataset we are using contains __35,295 rows and 75 columns__, featuring 38 numeric columns (such as price, number of reviews, and ratings) and 37 non-numeric columns (including location, property type, and host information). This dataset, sourced directly from Inside Airbnb, ensures reliability due to its frequent updates and transparency, accurately reflecting current Airbnb listings. The site provides a detailed data dictionary with explanations of the metadata, linked here: Inside Airbnb Data Dictionary . Furthermore, the Inside Airbnb project is helmed by an independent advisory board which helps to ensure that its data practices are both accurate and ethical. Each listing contains only the public information directly shared by a host or reviewer on the Airbnb site, ensuring that data privacy is not being violated.

__Methods__

Successful unsupervised modeling relies on properly preprocessed data. In our dataset we have a mixture of numerical and categorical variables, text, and location data. We will need to ensure that our categorical data is properly encoded using methods from the scikit-learn library like OneHotEncoder and OrdinalEncoder. To make use of our text, scikit-learn has text mining and classification methods like TfidVectorizer and CountVectorizer to preprocess and transform our data for word frequency analysis. Additionally, we can see from an initial view of our data that we have some missing values which will need to be imputed. We will also need to perform feature selection and feature engineering on certain categorical and numerical variables to reduce the computational complexity of our model. We can likely remove columns which contain metadata like the original listing url.

Among unsupervised learning techniques, there are two main techniques; clustering and dimensionality reduction. We will test our unsupervised learning models using methods including K-Means Clustering, DBSCAN, and Isolation Forests for anomaly detection, which are popular clustering techniques. Principal Component Analysis is an example of a dimensionality reduction model, which we will test as well. All of these methods are included in scikit-learn.

As far as evaluation metrics, for clustering techniques we will consider the Silhouette Coefficient, which measures how similar an object is to its own cluster compared to other clusters. Additionally we can use root mean square error, which will tell us the accuracy of the clustering. For dimensionality reduction models where the goal is to retain as much information as possible, evaluation metrics like Trustworthiness can be implemented to measure the ‘quality’ of the reduction technique.

## Project Plan

| Period             | Activity | Milestone|
| :---------------- | :------ | ----: |
| 10/9-10/30       |   Stakeholder Analysis, EDA, Data Cleaning and Preprocessing  | Stakeholders are clearly outlined, data is preprocessed for model experimentation, and all relevant data has been identified |
| 10/31-11/7           |   Initial model experimentation, Hyperparameter testing   | Appropriate model will be selected along with hyperparameters for model optimization |
| 11/8-11/20    |  Final model selection, Model evaluation, Model predictions   | Model will meet evaluation criteria outlined in Methods section, a list of suspicious properties will be identified |
| 11/20-12/4 |  Finalize report, Findings presentation   | Project iteration is completed and findings are presented to the stakeholders |




## Risks

We are trying to construct an unsupervised learning model to detect fraud among listings. Unsupervised models rely heavily on data quality and quantity, so we need to spend an adequate time on the data cleaning and preprocessing phase to avoid inadvertently misleading results. Unlike a supervised model, we don’t know which, if any, of the reviews are fraudulent, so it is possible that our model may not produce particularly meaningful results. We must also be wary of overfitting because there is no labeled data to provide feedback to the model. Additionally, we are performing this analysis on data from listings across one city, so we recognize that this model may be limited in terms of scalability to other cities or rental markets. 

If we find that our unsupervised model is overfitting, we will address that through feature selection and hyperparameter tuning. If we find that we do not have enough training data to make a generalized model, the Inside Airbnb project provides us with supplemental data sets which contain the same variables for other cities. We can easily pivot to combining data from multiple similar cities, such as Boston and Cambridge, Massachusetts. 
Grading 

## Footnotes

[^1]: Airbnb Newsroom. (2023, March 8). What we're doing to prevent fake listing scams. *Airbnb Newsroom*. https://news.airbnb.com/what-were-doing-to-prevent-fake-listing-scams/


[^2]:Rodriguez, J. (2023, March 8). How to avoid Airbnb scams: What you need to know before booking your next rental. *USA Today*. https://www.usatoday.com/story/travel/2023/03/08/airbnb-scams-booking-rental/11277486002/


[^3]: Mantri, A., & Chaurasia, P. (2023). Investigating fraud detection bid data pipeline in online travel platforms. *ResearchGate*. https://www.researchgate.net/publication/382915239_Investigating_Fraud_Detection_Bid_Data_Pipeline_in_Online_Travel_Platforms

[^4]: Ahuja, R., Dubey, A., & Laxmi, V. (2023). Identifying fraudulent accounts in online social networks using machine learning. *PeerJ Computer Science*, *9*, e2019. https://doi.org/10.7717/peerj-cs.2019