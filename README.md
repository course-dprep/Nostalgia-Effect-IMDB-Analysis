
## The Nostalgia Effect: How Release Year and Genre Shape IMDb Movie Ratings Over Time

This project aims to explore how nostalgia influences IMDb movie ratings by analyzing the relationship between a film’s release year and audience perception, with genre as a moderating factor.  

As nostalgia increasingly shapes consumer preferences, understanding its impact on movie reception can reveal biases in ratings and cultural memory effects. This study provides insights into how audiences evaluate films over time, helping industry professionals leverage nostalgia in content creation, marketing, and distribution strategies.

## Motivation

In today’s entertainment industry, maximizing audience engagement and profitability is crucial, and nostalgia has been identified as a key factor influencing movie reception (Ulker-Demirel et al., 2018). While studies have explored whether nostalgia motivates audiences to watch remakes and reunions (Tetik & Türkelı, 2023) or influences viewer engagement (Andrade, 2023), little research has examined how nostalgia manifests in IMDb user ratings and whether it directly impacts the perceived quality of a movie.  

From an academic perspective, this study contributes to film studies, behavioral psychology, and consumer research by empirically analyzing rating patterns over time and assessing whether nostalgia bias or selective survival bias systematically influence IMDb ratings. Additionally, it examines how factors such as genre interact with this relationship, offering an understanding of audience preferences and cultural memory in film evaluation.  

From a managerial standpoint, this research has direct implications for film studios, streaming platforms, and marketers in shaping their content strategies. If older films receive higher ratings due to nostalgia rather than objective quality, this insight could influence decisions on which films to remake, re-release, or highlight in marketing campaigns.  

Streaming platforms can refine their recommendation algorithms by accounting for nostalgia-driven biases, improving user engagement and retention. Additionally, movie studios could leverage these findings to predict the potential success of sequels and franchise revivals, ensuring they appeal to audiences who value nostalgic elements. 

Understanding how genre moderates this effect also allows industry professionals to tailor their approach depending on whether certain film types (e.g., sci-fi, drama, or animation) are more influenced by nostalgia than others.   

Ultimately, this study provides a data-driven framework for maximizing audience appeal, optimizing content distribution, and making strategic investment decisions in the evolving film industry.

## Research Question
To what extent is IMDb movie user rating influenced by the movie released year? And to what extent does movie genre influence this relationship?

## Data

For this study, we used publicly available datasets from IMDb’s non-commercial dataset repository (IMDb Non-Commercial Datasets).   
Link to the website: https://developer.imdb.com/non-commercial-datasets/  
Specifically, we utilized two key datasets:  

title.ratings.tsv.gz – Provides IMDb user ratings, including:  
Average Rating (DV) from the averageRating field.  
Number of Votes from the numVotes field.   

title.basics.tsv.gz – Contains movie metadata, including:  
Release Year (IV) from the startYear field.  
Genre (Moderator Variable) from the genres field.     

Why IMDb?

IMDb provides a high-quality dataset for analyzing trends in movie ratings over time, looking at how the trend changed overtime, based on the influence of genre. The structured dataset ensures a methodologically sound approach for studying how IMDb user ratings evolve with release year and genre differences.

Our main interest was to understand how users perception of films changed over time and check whether, over different periods (we considered from 1980s until today), one genre was more famous than others, in orther to be able to provide meaningful insights into how consumers behaviour related to films and genres changed overtime.

For this study, the current amount of observations is 743629 in the sample.

| Variable Name   | Description / Operationalization |
|-----------------|--------------------------------|
| `averageRating` | Dependent Variable (DV). IMDb user rating on a 0–10 scale. This variable is used to find out the average rating per user|
| `numVotes`      | Number of votes submitted for the title (additional metric). Ranges from 0-3200000|
| `startYear`     | Independent Variable (IV). Year the title was first released. Ranges from 1980 to 2025|
| `genres`        | Moderator Variable. Primary genres listed for the title by removing any possible combination of different genres and maintaining only the first one as the indicative|

## Method

To address our research question, we implemented a structured data analysis workflow consisting of data cleaning, merging, and statistical analysis, with a focus on linear regression to quantify the impact of release year on IMDb ratings, because we were intrested in understanding whether specific films, were famous only during their release year, or whether the Nostalgia Effect kept them high over time.

We also wanted to see whether this effect changed with the effect of genre, by looking at whether genres impacted the voting, wether in specific period times some genres were more popular than others and whether this popularity was due by Nostalgia Effect, as well.

The study uses linear regression to quantify the impact of release year on IMDb ratings, with genre as a moderating factor. Descriptive analysis identifies trends, and statistical validation ensures robustness. This approach provides a clear, interpretable assessment of nostalgia effects.

## Preview of Findings 

Our preliminary analysis suggests that IMDb movie ratings exhibit a nostalgia effect, where older films tend to receive higher average ratings compared to more recent releases. This trend persists even after controlling for the number of votes and genre, indicating that audience perception of film quality is influenced by cultural memory and retrospective appreciation.

Additionally, genre plays a moderating role in this relationship. Some genres, such as classics, dramas, and sci-fi, show stronger nostalgia-driven rating inflation, whereas comedy and action films tend to maintain a more stable rating distribution over time. These findings suggest that different genres age differently in the eyes of audiences, possibly due to shifting cultural preferences and cinematic trends.

The insights from this study can be utilized in multiple ways:
    - Industry Application: Streaming platforms and movie studios can adjust recommendation algorithms and marketing strategies based on nostalgia-driven biases.
    - Content Strategy: Filmmakers can leverage nostalgia when producing remakes, reboots, or sequels to maximize audience engagement.
    - Academic Contribution: This research contributes to media psychology and consumer behavior studies by offering empirical evidence of Nostalgia’s impact on movie perception.

Understanding the nostalgia effect in movie ratings is crucial for both industry professionals and researchers. It sheds light on how cultural memory shapes audience evaluation, helping media   companies refine their content curation, marketing efforts, and strategic decision-making when promoting older films or launching new projects with nostalgic appeal. 

## Repository Overview 

```
Nostalgia-Effect-IMDB-Analysis
├── data
│   ├── datasets
├── reporting
├── src
│   ├── analysis
│   ├── data-preparation
├── .Rhistory
├── .gitignore
├── Nostalgia-Effect-IMDB-Analysis.R
├── README.md
├── makefile
```

- Functions of different scripts:
  
download-data.R – Downloads the raw IMDb datasets and ensures required packages and folders are set up.

clean.R – Cleans and filters the raw IMDb datasets by removing invalid entries and saving cleaned versions.

data_merging.R – Merges the cleaned IMDb datasets and flags entries as released or unreleased.

clean_data_merging.R – Further cleans the merged dataset by removing outliers and filtering relevant genres based on vote counts.

analysis.R – Performs statistical analyses, including regressions and assumption tests, to explore relationships between release year, genre, and IMDb ratings.

plots.R – Generates and saves visualizations illustrating trends in IMDb ratings over time and across genres.

makefile – Automates the execution of scripts in the correct order for downloading, cleaning, merging, analyzing, and visualizing IMDb data

## Dependencies 

To ensure smooth execution of this R project, confirm that you have installed the following packages. If any are missing, you can obtain them by running install.packages("packageName"). After installation, make them available in your current session by invoking the library() function.

| Install Packages |
|------------------|
| `data.table`     |
| `R.utils`        |
| `tidyverse`      |
| `lubridate`      |
| `readr`          |
| `here`           |
| `nortest`        |
| `ggplot2`        |
| `rmarkdown`      |
| `tinytex`        |
| `knitr`          |
| `car`            |
| `dplyr`          |



## Running Instructions 

To execute the analysis, follow these steps:
1. Fork this repository to your own GitHub account.
2. Clone the repository to your local machine using the command:
   ```sh
   git clone https://github.com/course-dprep/Nostalgia-Effect-IMDB-Analysis.git
   ```
3. Set your working directory to the **`Nostalgia-Effect-IMDB-Analysis`** folder:
   ```sh
   cd Nostalgia-Effect-IMDB-Analysis
   ```
4. Install Pandoc (required for document conversion and report generation) following instructions at: https://tilburgsciencehub.com/topics/computer-setup/software-installation/document-creation/pandoc/
5. Execute the following command to automate the data processing pipeline:
   ```sh
   make
   ```
6. Once `make` has successfully executed all scripts, it will generate cleaned datasets inside the `data` folder.

## About 

This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the [Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing), [Tilburg University](https://www.tilburguniversity.edu/), the Netherlands.

## Reference List
Andrade, S. (2023). The impact of nostalgia and social setting on consumer motivation to watch a movie at the cinema vs. through streaming. Handle.net. http://hdl.handle.net/10400.14/42261 

Tetik, T., & Türkeli, Ö. (2023). POPULAR CINEMA AS NOSTALGIA INDUSTRY: REUNIONS, REMAKES, AND REQUELS. Sinecine: Sinema Araştırmaları Dergisi, 14(1), 7-31. https://doi.org/10.32001/sinecine.1253910 

Ulker-Demirel, E., Akyol, A. and Simsek, G.G. (2018), "Marketing and consumption of art products: the movie industry", Arts and the Market, Vol. 8 No. 1, pp. 80-98. https://doi.org/10.1108/AAM-06-2017-0011 

The project is implemented by team < 4 > members: < Beatrice Ruggeri ID: 2146104, Dilay Alpaydin ID: , Eva Sozzi ID: 2151986, Maria Kim Capuani ID: 2063323, Zhaodi Ma 2124843>
