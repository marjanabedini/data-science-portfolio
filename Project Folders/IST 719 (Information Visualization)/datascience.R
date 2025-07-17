
# Data Science Salary Insights: Trends Across Roles, Experience, and Remote Work(US)

# my data: https://www.kaggle.com/datasets/saurabhbadole/latest-data-science-job-salaries-2024


my.file <- file.choose()
data <- read.csv(my.file, header=T, stringsAsFactors=F)
View(data)

# Display structure and summary
str(data)
summary(data)

#------------------------------------------------------
# clean my data:

# Count missing values in each column
colSums(is.na(data))

# Rename columns to lower case and replace spaces with underscores
colnames(data) <- tolower(gsub(" ", "_", colnames(data)))

# Remove duplicate rows
data <- data[!duplicated(data), ]

data$salary <- as.numeric(data$salary)

# Detect outliers in salary
boxplot(data$salary, main = "Salary Distribution", horizontal = TRUE)

# Optionally remove outliers
iqr <- IQR(data$salary, na.rm = TRUE)
upper <- quantile(data$salary, 0.75, na.rm = TRUE) + 1.5 * iqr
lower <- quantile(data$salary, 0.25, na.rm = TRUE) - 1.5 * iqr
data <- subset(data, salary >= lower & salary <= upper)

# Load the dplyr package
library(dplyr)

# Rename the columns in the data frame using recode
data <- data %>%
  mutate(
    # Experience Level
    experience_level = recode(
      experience_level,
      "EN" = "Entry-level",
      "MI" = "Mid-level",
      "SE" = "Senior-level",
      "EX" = "Expert-level"
    ),
    # Employment Type
    employment_type = recode(
      employment_type,
      "PT" = "Part-time",
      "CT" = "Contract",
      "FT" = "Full-time",
      "FL" = "Freelance"
    ),
    
    # Remote Ratio
    remote_ratio = recode(remote_ratio,
                          `0` = "Onsite",
                          `50` = "Hybrid",
                          `100` = "Remote"
    ),
    
    # Company Size
    company_size = recode(
      company_size,
      "S" = "Small",
      "M" = "Medium",
      "L" = "Large"
    )
  )

str(data)

#---------------------------------------------------

# 1. A world map  to show the number of job titles in different countries

library(ggplot2)
library(rnaturalearth)
library(rnaturalearthdata)
library(sf)

# Summarize the data using aggregate
job_count <- aggregate(job_title ~ employee_residence, data, length)
colnames(job_count) <- c("employee_residence", "num_jobs")  # Rename columns for clarity

job_count_sorted <- job_count[order(-job_count$num_jobs), ]  # Descending order

# Load the world map
world_map <- ne_countries(scale = "medium", returnclass = "sf")

# Merge the summarized data with the world map
world_map <- merge(world_map, job_count, by.x = "iso_a2", by.y = "employee_residence", all.x = TRUE)


# Check the distribution of num_jobs
summary(world_map$num_jobs)
table(world_map$num_jobs)

# Plot with adjusted color scale
ggplot(data = world_map) +
  geom_sf(aes(fill = ifelse(num_jobs > 0, num_jobs, NA))) +
  scale_fill_gradient(
    low = "#FFB6C1",  
    high = "#8B0000", 
    na.value = "lightgrey", 
    trans = "log", 
    name = "Number of Jobs"
  ) +
  theme_minimal() +
  theme(legend.position = "none")


ggsave(
  filename = "Distribution of Job Titles Across Countries.png",   # File name
  plot = last_plot(),                     # The plot to save
  width = 10,                             # Width in inches
  height = 8,                             # Height in inches
  dpi = 300,                               # Resolution in dots per inch (300 is print-quality)
  bg = "white"                            # Set background to white
)

# Filter data for the United States
us_jobs <- subset(data, employee_residence == "US")
nrow(us_jobs)

#----------------------------------------------------


# 2. Top 20 Job Titles by Average Salary (US)

library(dplyr)
library(ggplot2)
library(scales)
library(stringr)

# Filter data for US-based employees
us_data <- subset(data, employee_residence == "US")

# Calculate average salary by job title
job_salary <- aggregate(salary_in_usd ~ job_title, data = us_data, FUN = mean, na.rm = TRUE)

# Sort the results by average salary in descending order
job_salary <- job_salary[order(-job_salary$salary_in_usd), ]

# Select the top 20 job titles
top_20_jobs <- head(job_salary, 20)

# Plot the top 20 job titles by average salary

ggplot(top_20_jobs, aes(x = reorder(job_title, salary_in_usd), y = salary_in_usd, fill = salary_in_usd)) +
  geom_bar(stat = "identity") +
  geom_text(
    aes(label = scales::comma(round(salary_in_usd))),  # Format salary values with commas
    hjust = 1.1,  # Adjust position of the labels
    color = "white",  # Change text color to white
    size = 3.5      # Adjust font size
  ) +
  coord_flip() +  # Flip the coordinates for better readability
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  scale_y_continuous(labels = scales::label_comma()) +  # Format y-axis to show commas
  labs(x = NULL, y = NULL) +  # Remove x and y axis titles
  theme_minimal()+
  theme(legend.position = "none")


ggsave(
  filename = "Top 20 Job Titles by Average Salary (US).png",   # File name
  plot = last_plot(),                     # The plot to save
  width = 10,                             # Width in inches
  height = 8,                             # Height in inches
  dpi = 300,                               # Resolution in dots per inch (300 is print-quality)
  bg = "white"                            # Set background to white
)

#-------------------------------------------------------

# 3. What is the salary trend across different experience levels over the years?


library(ggplot2)


# Step 1: Aggregate salary by year and experience level
salary_trend <- aggregate(salary_in_usd ~ work_year + experience_level, data = data, FUN = mean)

# Step 2: Plot the salary trend by experience level over the years
ggplot(salary_trend, aes(x = work_year, y = salary_in_usd, color = experience_level, group = experience_level)) +
  geom_line(size = 1.2) +  # Create line plot for trends
  geom_point(size = 3) +
  scale_y_continuous(labels = scales::label_comma()) +  # Format y-axis to show commas
  labs(x = NULL, y = NULL)+
  theme_minimal() +  # Use minimal theme
  theme(legend.title = element_blank())+
  scale_color_manual(values = c("Entry-level" = "#ADD8E6",  # Light blue
                                "Mid-level" = "#87CEEB",    # Sky blue
                                "Senior-level" = "#4682B4", # Steel blue
                                "Expert-level" = "#211d9e"))   # Pure blue


ggsave(
  filename = "Yearly Salary Trend by Experience Level.png",   # File name
  plot = last_plot(),                     # The plot to save
  width = 10,                             # Width in inches
  height = 8,                             # Height in inches
  dpi = 300,                               # Resolution in dots per inch (300 is print-quality)
  bg = "white"                            # Set background to white
)
#----------------------------------------------------------

# 4. Plot salary distribution by experience level

library(ggplot2)

# Plot the salary distribution by experience level using a violin plot
ggplot(us_data, aes(x = experience_level, y = salary_in_usd, fill = experience_level)) +
  geom_violin(trim = FALSE) +  # Create the violin plot
  scale_y_continuous(labels = scales::label_comma()) +  # Format y-axis to show commas
  labs(x = NULL, y = NULL)+
  theme_minimal()+
  theme(legend.position = "none")+
  scale_fill_manual(values = c("Entry-level" = "#ADD8E6",  # Light blue
                               "Mid-level" = "#87CEEB",    # Sky blue
                               "Senior-level" = "#4682B4", # Steel blue
                               "Expert-level" = "#211d9e"))   # Pure blue



ggsave(
  filename = "Salary Distribution by Experience Level(US).png",   # File name
  plot = last_plot(),                     # The plot to save
  width = 10,                             # Width in inches
  height = 8,                             # Height in inches
  dpi = 300,                               # Resolution in dots per inch (300 is print-quality)
  bg = "white"                            # Set background to white
)


View(us_data)
# Count experience levels in us_data
experience_count <- table(us_data$experience_level)


#----------------------------------------------


library(ggplot2)

# Aggregate average salary by job title and experience level
agg_data <- aggregate(salary_in_usd ~ job_title + experience_level, data = data, FUN = mean)

# Filter the top 10 job titles with the highest salaries for Entry-level experience
top_jobs <- agg_data[agg_data$experience_level == "Entry-level", ] %>%
  arrange(desc(salary_in_usd)) %>%
  head(10) %>%
  .$job_title

# Filter the aggregated data to include only the top 10 job titles
filtered_data <- agg_data[agg_data$job_title %in% top_jobs, ]

# Create the grouped bar plot
ggplot(filtered_data, aes(x = reorder(job_title, salary_in_usd), y = salary_in_usd, fill = experience_level)) +
  geom_bar(stat = "identity", position = "dodge") +  # Grouped bar chart
  coord_flip() +  # Flip coordinates for better readability
  labs(
    title = "Top 10 High Paid Jobs in Data Science by Experience Level",
    x = "Job Title",
    y = "Average Salary (USD)",
    fill = "Experience Level"
  ) +
  scale_y_continuous(labels = scales::label_comma()) +  # Format salary axis
  theme_minimal()+
  scale_fill_manual(values = c("Entry-level" = "#ADD8E6",  # Light blue
                               "Mid-level" = "#87CEEB",    # Sky blue
                               "Senior-level" = "#4682B4", # Steel blue
                               "Expert-level" = "#211d9e"))   # Pure blue



library(treemapify)
# Create the treemap
ggplot(filtered_data, aes(area = salary_in_usd, fill = experience_level, label = job_title)) +
  geom_treemap() +
  geom_treemap_text(
    fontface = "bold",
    colour = "white",
    place = "center",
    grow = TRUE
  ) +
  labs(
    title = "Top 10 High Paid Jobs in Data Science by Experience Level",
    subtitle = "Treemap Visualization",
    fill = "Experience Level"
  ) +
  scale_fill_manual(values = c("Entry-level" = "#ADD8E6",  # Light blue
                               "Mid-level" = "#87CEEB",    # Sky blue
                               "Senior-level" = "#4682B4", # Steel blue
                               "Expert-level" = "#211d9e")) + # Pure blue
  theme_minimal()



#-----------------------------------------------------

# 5. What are the top-paying job titles, and how do they differ by experience level and remote working ratio?


# Load required libraries
library(ggplot2)
library(ggalluvial)
library(dplyr)



# Aggregate average salary by job title, experience level, and remote ratio(US)
agg_data <- aggregate(salary_in_usd ~ job_title + experience_level + remote_ratio, data = us_data, FUN = mean)

# Filter the top 10 job titles with the highest salaries
top_jobs <- agg_data %>%
  group_by(job_title) %>%
  summarize(avg_salary = mean(salary_in_usd)) %>%  # Calculate overall average salary for each job title
  arrange(desc(avg_salary)) %>%
  slice(1:10) %>%  # Select top 10 highest-paying job titles
  pull(job_title)


# Filter the aggregated data to include only the top 10 job titles(US)
filtered_data <- agg_data %>%
  filter(job_title %in% top_jobs)

# Define a custom color palette for experience levels
custom_colors <- c(
  "Entry-level" = "#ADD8E6",  # Light Blue
  "Mid-level" = "#87CEEB",    # Sky Blue
  "Senior-level" = "#4682B4", # Steel Blue
  "Expert-level" = "#211d9e"    # Pure Blue
)

# Create the alluvial plot

ggplot(
  filtered_data,
  aes(axis1 = experience_level, axis2 = job_title, axis3 = remote_ratio, y = salary_in_usd, fill = job_title)
) +
  geom_alluvium(aes(fill = experience_level), width = 1/8, alpha = 0.8) +  # Adjust transparency
  geom_stratum(width = 2/8, fill = "gray90", color = "white") +  # Neutral strata color
  geom_text(stat = "stratum", aes(label = after_stat(stratum)), size = 2) +  # Add text labels
  scale_y_continuous(labels = scales::label_comma()) +  # Keep y-axis numbers with comma format
  scale_fill_manual(values = custom_colors) +  # Apply custom color palette
  labs(
    x = NULL,  # Remove x-axis label
    y = NULL,  # Remove y-axis label
    fill = "Experience Level"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_blank(),  # Remove x-axis numbers
    axis.title.y = element_blank(),  # Remove y-axis label
    legend.position = "none"         # Remove legend
  )




ggsave(
  filename = "Top 10 High Paid Jobs in Data Science by Experience Level and Remote Ratio(US).png",   # File name
  plot = last_plot(),                     # The plot to save
  width = 10,                             # Width in inches
  height = 8,                             # Height in inches
  dpi = 300,                               # Resolution in dots per inch (300 is print-quality)
  bg = "white"                            # Set background to white
)

#-------------------------------------------------------

# 6. salary by employment type(US)

library(ggplot2)

# Create a boxplot to visualize salary distribution by employment type
ggplot(us_data, aes(x = employment_type, y = salary_in_usd, fill = employment_type)) +
  geom_boxplot() +  # Create the boxplot
  scale_y_continuous(labels = scales::label_comma()) +  # Format y-axis to show commas
  theme_minimal() +
  scale_fill_manual(values = c("Part-time" = "#ADD8E6",  # Light Blue
                               "Contract" = "#87CEEB",  # Sky Blue
                               "Full-time" = "#4682B4", # Steel Blue
                               "Freelance" = "#211d9e"))+  # Custom colors
  labs(
    x = NULL,  # Remove x-axis label
    y = NULL   # Remove y-axis label
  ) +
  theme(
    legend.position = "none",        # Remove legend
    axis.title.x = element_blank(), # Ensure x-axis label is removed
    axis.title.y = element_blank()  # Ensure y-axis label is removed
  )




ggsave(
  filename = "Salary Distribution by Employment Type(US).png",   # File name
  plot = last_plot(),                     # The plot to save
  width = 10,                             # Width in inches
  height = 8,                             # Height in inches
  dpi = 300,                               # Resolution in dots per inch (300 is print-quality)
  bg = "white"                            # Set background to white
)

# Count the number of each employment type in the dataset
employment_type_count <- table(us_data$employment_type)

#-------------------------------------------------------

# 7. salary by remote_ratio(US)

# Aggregate average salary by remote ratio
agg_salary_remote <- aggregate(salary_in_usd ~ remote_ratio, data = us_data, FUN = mean)

# Calculate percentage for each remote ratio
agg_salary_remote$percentage <- (agg_salary_remote$salary_in_usd / sum(agg_salary_remote$salary_in_usd)) * 100

library(ggplot2)

# Create the donut plot
ggplot(agg_salary_remote, aes(x = 2, y = percentage, fill = remote_ratio)) +  # Set x to 2 for donut effect
  geom_bar(stat = "identity", width = 0.5, color = "white") +  # Adjust width for the donut
  coord_polar("y", start = 0) +  # Convert to polar coordinates for donut shape
  theme_void() +  # Simplify theme for pie chart
  scale_fill_manual(
    values = c(
      "Onsite" = "#87CEFA",  # Light Sky Blue
      "Hybrid" = "#4682B4",  # Steel Blue
      "Remote" = "#1E90FF"   # Dodger Blue
    )
  ) +
  theme(
    plot.title = element_text(hjust = 0.5),  # Center the title
    legend.position = "none"  # Remove legend
  ) +
  # Add center text for donut
  annotate("text", x = 0, y = 0, label = "Average Salary", size = 6, fontface = "bold", color = "black") +
  # Add percentage labels
  geom_text(
    aes(
      x = 2, 
      y = cumsum(percentage) - percentage / 2,  # Position labels at the middle of each slice
      label = paste0(round(percentage, 1), "%")  # Format percentage labels
    ),
    color = "white",  # Text color
    size = 3,         # Text size
    fontface = "bold"  # Bold text for better readability
  )


ggsave(
  filename = "Proportion of Average Salary by Remote Ratio(US).png",   # File name
  plot = last_plot(),                     # The plot to save
  width = 10,                             # Width in inches
  height = 8,                             # Height in inches
  dpi = 300,                               # Resolution in dots per inch (300 is print-quality)
  bg = "white"                            # Set background to white
)


round(agg_salary_remote$percentage)





# Aggregate average salary by year and remote ratio
agg_salary_remote_year <- aggregate(salary_in_usd ~ work_year + remote_ratio, data = data, FUN = mean)+
  

# Calculate the percentage of salary for each remote_ratio within each year
agg_salary_remote_year <- agg_salary_remote_year %>%
  group_by(work_year) %>%
  mutate(percentage = salary_in_usd / sum(salary_in_usd) * 100)

# Create the donut plot
ggplot(agg_salary_remote_year, aes(x = 2, y = percentage, fill = remote_ratio)) +
  geom_bar(stat = "identity", width = 1, color = "white") +  # Bar chart for pie
  coord_polar(theta = "y") +  # Convert to circular (pie)
  xlim(1, 2.5) +  # Create a hole in the middle for donut effect
  facet_wrap(~ work_year) +  # Separate donut plots for each year
  labs(
    title = "Proportion of Average Salary by Remote Ratio and Year",
    fill = "Remote Ratio"
  ) +
  theme_void() +  # Simplify the plot for a clean look
  theme(
    legend.position = "bottom",
    plot.title = element_text(hjust = 0.5, size = 16)
  ) +
  scale_fill_manual(values = c("Onsite" = "#87CEFA", "Hybrid" = "#4682B4", "Remote" = "#1E90FF"))  # Custom blue color palette



#-------------------------------------------------------

# 8. The most common words in job titles


library(RColorBrewer)
library(wordcloud2)




# Prepare data: count job titles
job_title_count <- us_data %>%
  group_by(job_title) %>%
  summarise(freq = n()) %>%
  arrange(desc(freq))

# Create the word cloud
wordcloud2(data = job_title_count, 
           size = 0.5,  # Adjust size of the words
           color = "random-light",  # Color palette
           backgroundColor = "darkblue")  # Background color


#------------------------------------------------------
# 9. How does the salary distribution differ across employment level?


# Load necessary library
library(ggplot2)

# Step 1: Create the KDE plot for salary distribution by company size(US)
ggplot(us_data, aes(x = salary_in_usd, fill = company_size)) +
  geom_density(alpha = 0.6) +  # Alpha adjusts the transparency
  labs(
    fill = "Company Size"
  ) +
  theme_minimal() +  # Clean theme
  scale_fill_manual(
    values = c(
      "Small" = "#87CEEB",    # Light blue
      "Medium" = "#4682B4",   # Steel blue
      "Large" = "#1E90FF"     # Dodger blue
    )
  ) +
  scale_x_continuous(
    breaks = seq(0, max(data$salary_in_usd, na.rm = TRUE), by = 50000),
    labels = scales::label_comma()
  ) +  # Adjust x-axis ticks and format labels
  scale_y_continuous(
    breaks = seq(0, max(density(data$salary_in_usd)$y, na.rm = TRUE), by = 0.00002),
    labels = scales::label_comma()
  ) +  # Adjust y-axis ticks
  theme(
    legend.position = "bottom",
    plot.title = element_text(hjust = 0.5, size = 16),
    axis.title.x = element_blank(),   # Remove x axis label
    axis.title.y = element_blank()    # Remove y axis label
  )


ggsave(
  filename = "Salary Distribution by Company Size(US).png",   # File name
  plot = last_plot(),                     # The plot to save
  width = 10,                             # Width in inches
  height = 8,                             # Height in inches
  dpi = 300,                                # Resolution in dots per inch (300 is print-quality)
  bg = "white"                            # Set background to white
)


company_size_count <- table(us_data$company_size)

#-------------------------------------------------------



