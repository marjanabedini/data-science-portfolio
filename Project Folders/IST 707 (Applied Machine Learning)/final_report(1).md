### Detecting Fraud In Hawaii Airbnb Listings

### Team
Sophia Jaskoski: sjaskosk

Ber Bakermans: AnneBerberBakermans

Marjan Abedini: andia941394

Tharuni Tekula: tharunitekula

### Introduction
Airbnb is currently dealing with the issue of fraudulent listings that manage to bypass security checks. These deceptive listings can mislead users into booking properties that either don't exist or don't match the descriptions provided, causing financial losses and significant inconvenience for travelers.

Our project aims to detect fake or fraudulent Airbnb listings. We are building a model that looks at details in listings, like price, location, and hosts, to find patterns and spot anything unusual that could indicate a fake listing. The main focus is to provide Airbnb platform managers with a tool to screen and flag listings to keep guests and other hosts safe.

This need is important because fake listings can cause problems for guests, such as losing money or being stranded without a place to stay when they arrive. For Airbnb, not being able to catch these listings can lead to a loss of trust and customers. It can also hurt the reputation of the company, especially in places like Hawaii, where tourism is important but heavily regulated. If people lose trust in Airbnb, it may lose its ability to operate in Hawaii altogether.

Our solution uses unsupervised learning to find unusual patterns in Airbnb listings and flag those that look suspicious. By grouping similar listings together and spotting ones that don't fit, our model can identify potential fraud without needing labeled data. We also implement text mining to find any simlairities in listing descriptions which may indicate the same listings that are under different names. This helps Airbnb keep the platform safer and more reliable for guests.

## Key Stakeholders:
Airbnb Guests: Need assurance that they are booking genuine, reliable properties.

Airbnb Managers: Need effective tools to identify and remove fake listings to maintain a trustwordy platform.

Airbnb Hosts: Need protections for their listings to ensure a fair and competitive marketplace.

### Literature Review
The rise of online property rental and sale platforms has made it easier for people to find and book listings. However, it has also led to an increase in fake listings, which can waste time, money, and create risks for travelers. Solving this problem is important for creating a safe market and a more trustworthy place for travelers to book listings. 

The use of different fraud detection algorithms for real estate listings is still quite new, despite having success in other fields like cybersecurity and banking. Previous studies have focused more on real estate auctions, property valuations, or market trends and less on online listings. This shows the need for new techniques to help spotting fraudulent listings on these platforms.

One method that can be helpful for this issue is clustering analysis. It can help with recognizing suspicious listings by highlighting listings that do not fit the 'normal'. Because clustering does not rely on pre-existing examples of fake listings, it is especially helpful when we do not have labeled data. Because of this, it can be adjusted to new forms of fraud that the model might not have been seen before.

In the study we are looking at ("Clustering analysis for classifying fake real estate listings" editor:Tzung-Pei Hong), K-means clustering was used to classify listings and identify the differences between real and fraudulent properties. They used machine learning techniques like Random Forest and Decision Tree to test the outcomes. Their results demonstrated that the Random Forest model's accuracy was increased by 96% when K-means clustering was used, showing that this method can help with the detection of fraudulent listings.

This study showed us that clustering analysis can be a good first step in identifying fake airbnb listings. This approach is useful for our project because it allows us to detect fraudulent listings even when we don't have examples of what a fake listing looks like. The study’s success, where K-means clustering improved the accuracy of a Random Forest model, shows that clustering can be an important tool for improving fraud detection. Looking at this, we will use clustering in our project to help the process of identifying fake Airbnb listings. The ultimate goal is to help airbnb protect travelers and make the online booking market safer and more trustworthy.

### Data and Methods
**Data**

The data we are using is scraped from the Airbnb website through the Inside Airbnb Project, linked here: https://insideairbnb.com/get-the-data/. The site has data for dozens of global cities, but for the purposes of this project, we decided to use the data for Airbnb’s in Hawaii as this was one of the larger datasets available and we wanted to be able to train an unsupervised model on as much data as we could. The dataset we are using contains 35,295 rows and 75 columns, featuring 38 numeric columns (such as price, number of reviews, and ratings) and 37 non-numeric columns (including location, property type, and host information). This dataset, sourced directly from Inside Airbnb, ensures reliability due to its frequent updates and transparency, accurately reflecting current Airbnb listings. The site provides a detailed data dictionary with explanations of the metadata. Furthermore, the Inside Airbnb project is helmed by an independent advisory board which helps to ensure that its data practices are both accurate and ethical. Each listing contains only the public information directly shared by a host or reviewer on the Airbnb site, ensuring that data privacy is not being violated.

**Methods**

Successful unsupervised modeling depended on thorough data preprocessing. Our dataset contained a combination of numerical and categorical variables, text, and location data. To prepare the categorical variables, we encoded them using scikit-learn tools such as OneHotEncoder and OrdinalEncoder. For text data, we utilized scikit-learn's text mining methods, including the TfidfVectorizer, to preprocess and transform the data into meaningful representations for word similarity analysis.

During our initial exploration, we identified missing values that required imputation. Additionally, we performed feature selection and engineered new features from both categorical and numerical variables to reduce the computational complexity of our models. Metadata columns, such as those containing original listing URLs, were removed to streamline preprocessing.

We explored two primary unsupervised learning techniques: clustering and dimensionality reduction. For clustering, we tested models like K-Means, DBSCAN, and Isolation Forests for anomaly detection, each widely recognized for their effectiveness. For dimensionality reduction, we applied Principal Component Analysis (PCA) to simplify the dataset while retaining critical variance. All these methods were implemented using scikit-learn.

To evaluate clustering performance, we relied on the Silhouette Score, which measured how well data points fit within their assigned clusters compared to neighboring clusters. This metric provided valuable insights into the effectiveness of our clustering models. Additionally, we visualized clustering using PCA and UMAP.

### Results

Looking at our results we can start by looking at our first unsupervised learning technique: clustering. 

As a first step we started with applying PCA Data reduction. We decided that using 7 principal components was optimal as these componends explained 81% of the variance in the dataset. 

We wanted to analyze our PCA loadings, to get some insight on which features contribute the most to each principal component. It helps us break the data into smaller and easier to analyze pieces for clustering:

PC1: Host responsiveness

PC2: Guest satisfaction

PC3/PC4: Host behavior and property management

PC5/PC6: Reviews and property size

PC7: Booking rules and availability


After doing this we started on our first model, Isolation forest. We looked first at the isolation forest with our PCA reduced data. To evaluate our Isolation forest model we relied on the silhoutte score. This is a measure that helps show how well a data points fits into its group and how seperate it is from other groups. It ranges from -1 to +1. The +1 means that the point is well placed in the group and is also far from others. 0 means it is on the border of two groups and -1 means it is in the wrong group. For isolation forest the silhotte score will show if the algorithm has separeted the data from the anomalies well. Looking at our results from our isolation forest model we got scores of 0.633, 0.586, and 0.796  which are all moderate to good. This shows us that the isolation forest does a decent job at finding anomalies. 

After this we decided to also test the isolation forest without PCA reduced data. The silhouette scores from these tests were 0.437, 0.400, and 0.585. This tells us that the model preforms less without PCA because the silhouette scores were significantly lower when using the original feature space compared to the PCA-reduced data, even with the same algorithm parameters. This tells us that the isolation forest has a harder time finding the difference between normal data points and anomalities when the original features of the data were included. 

We found that the best model for Isolation forest was on our PCA reduced data and from these parameters:

n_estimators=500: this means that The number of trees in the forest is set to 500.

max_samples=0.2: Each tree is trained on a random sample of 20% of the dataset.

contamination=0.01: The proportion of outliers in the dataset is set to 1%.

This model gave us a silhouette score of 0.796 which is a decent result. 

After deciding on our isolation forest model, we decided to start with our second model, K-Means. K-Means is a method used to group similar items together into clusters based on their features. We started with using the elbow method to decide the optimal number of clusters. We saw that the plot generated an elbow at k=2. This means that using 2 clusters is best fitting for our data and adding more clusters doesn't make a big difference in how well the data fits into those clusters. 

We began applying k-means clustering to our PCA-reduced data. The silhouette score for k=2 was 0.85, indicating that the model performs well when dividing the data into 2 clusters. In contrast, the silhouette score for k=3 was 0.47, which is significantly lower, showing that using 3 clusters does not produce as clear or effective groupings. This confirms that the model works better with 2 clusters compared to 3.

After applying k-means with PCA, we decided to test the model without PCA as well. Even without using PCA-reduced data, the elbow method still suggested k=2 as the optimal number of clusters. The silhouette score for k=2 was 0.81, while for k=3, it dropped to 0.36, showing that k=2 was the best choice without PCA as well. Overall, the model with PCA performed slightly better than the model without PCA what was the same case for out. 

for our third model we wanted to use DBSCAN. DBSCAN does clustering  based on the density of data points. It groups points that are close to each other into clusters while marking points that are far from any cluster as noise or outliers. We decided to use DBSCAN without using PCA first. We got silhouette scores that were negative. For the parameters eps=0.5 and min_samples=20, the silhouette score was -0.30, and for eps=0.7 and min_samples=10, the score was -0.41. When silhouette scores come back negative it sugests that the model stuggles to create meaningful clusters. 

Our second DBSCAN trail we used our PCA reduced data and achieved a silhouette score of 0.82. We used the parameters of eps=7.5 and min_samples=80 what turned out to be effective. 

We created a code that would show us all the listing in the airbnb dataframe that were marked as anomalies by the our three best models. We created a dataframe called All_three_flagged and added all the listings in here that were flagged by our 3 models. 

Looking at the flagged properties we saw some interesting patterns:

- The majority of the flagged properties belong to hosts who have only a few properties listed.
- These properties tend to have a very low number of reviews, suggesting limited user interaction or new listings.
- Most properties have hosts with verified profiles and pictures, but we should pay extra attention to hosts which are unverified or do not have profile pictures as AirBnb moves towards stricter verification methods in the future.
- The flagged properties often have hosts with low response rates, possibly pointing to lower engagement or responsiveness.
- Few flagged properties have hosts with a superhost badge, indicating that these listings are not managed by highly-rated hosts.
- The prices of most flagged properties are below the average, suggesting they may be priced differently compared to typical listings.

We ended up having 236 listing flagged by all three of our models. 

**Text mining**

We wanted to see if text mining would give us some results as well that might be helpful for detecting fraudelent listings. We applied a TF-IDF (Term Frequency-Inverse Document Frequency) analysis to various text columns in our Airbnb dataset to identify the most important terms in each column. When we looked at the top terms in each column we saw some interessting insights. In the name column we saw that the most important term exsisted out of "ocean", "beach", "bedroom", "view" and "condo" what is quite like we expected for airbnb rentals in Hawaii. In the discription column terms like "br", "beach", "ocean", "resort", and "bedroom" came up. This might mean some features or attractions that are popular. For host_name, "rentals" ranked third, suggesting that many listings are managed by large rental companies rather than individual homeowners. Under amenities, 'u2013' stood out as we do not know what that is referring to. 

Afterwards we decided to do an analysis on different text colums of the airbnb dataset. We used cosine similarity to compare and measure how similar the entries were to each other. One of the most surprising findings was in the description column, where we expected the text to be unique for each property. However, we discovered pairs of properties with a similarity score of 1.0, meaning their descriptions were identical. Upon selecting one such pair, we found that it appeared to be the same property listed by two different hosts, both using the same license ID. This is unusual since Airbnb assigns a unique license ID per host and property. This finding warrants further investigation to determine if this is an error on Airbnb’s part or if there is a larger issue with how listings are managed. Many of the listings with similar descriptions were listed by the same host and were often private rooms within the same residence, so it was convenient to recycle the same listing description over and over.

Lastly, we performed N-gram analysis on the text columns of the Airbnb dataset to find common word pairs and triplets. N-grams are groups of 2 to 3 words that appear together. Normally this analysis is used to find common patterns in text that might inidicate spam ("you have won!"), so we analyzed the most common word pairs per column and found that there were no outstanding results which we wanted to investegate further. 


### Discussion

The primary goal we had for our project was to develop a model that would be able to detect fraudulent Airbnb listings in Hawaii. We wanted to do this through unsupervised learning techniques. We think that in some degree we have achieved this goal. Our silhoutte scores from especially K-means and isolation forest show that they can identify anomalities in the data quite effectivly. However, we were not able to adequately visualize the clusters, which made it difficult to really assess how good the clustering was. Additionally, it was difficult to pinpoint specific features which tended to determine whether a listing was flagged because we used principal components and not the original features. While we tried to analyze the similarities between the listings flagged by our model, to get meaningful results and make it feasible in a real-life setting there still needs to be manual validating on the Airbnb side to see if the listings popping up are actualy fake. This is a crucial step to ensure accuracy and reliability of the system.

**needs of the steakholders:** 
This project directly addresses the needs of Airbnb managers, and only indirectly affects Airbnb guests and hosts. Realistically our model could be integrated into the Airbnb platform and product managers could keep track of and evaluate listings which are flagged on the site on a daily basis. Guests and hosts will indirectly benefit from this, trusting that Airbnb is consistently screening its platform for suspicious activity.


### Limitations

Several variables, including price, maximum and minimum nights, and the number of listings per host, exhibited significant right skewness. This skewness posed challenges during analysis, particularly affecting how Principal Component Analysis (PCA) reduced the data into principal components. The uneven distribution of these variables introduced bias in dimensionality reduction, requiring us to address the skewness to improve PCA performance.

Our dataset initially consisted of 75 columns. However, encoding categorical variables expanded the feature space dramatically, leading to computational challenges and, in some cases, crashes in the code environment. To manage this issue, we strategically dropped certain columns and applied feature engineering to reduce redundancy and improve the model's efficiency while retaining critical information.

The major challenge of the project was the absence of a ground truth to identify fraudulent listings definitively. To address this, we operationalized fraud detection by defining a fraudulent listing as one flagged by all three clustering models and identified as having a high similarity score during text mining analysis. This approach allowed us to approximate fraud detection in the absence of labeled data. Ultimately, being able to actually verify if our flagged listings are indeed fraudulent is beyond the scope of this course. 

### Future work
Some further steps we would like to take would be: 
1. Validation and testing: To make sure we validate the system we would want to cross-reference flagged listings with the real-world data to confirm wheter they are actually fake listings. 
2. Explainability: Pinpoint what features are being looked at to determine why a certain property is flagged. 
3. Integration in Airbnb's system: Develop a mechanism that is implemented in Airbnb's platform to get the fraud-detection through the site. 
4. Scalability: Create the models to also work on data in different regions and not just Hawaii to make it more useful across the whole platfrom of Aribnb 

These steps will help improve the project and make it more useful for Airbnb worldwide.
























