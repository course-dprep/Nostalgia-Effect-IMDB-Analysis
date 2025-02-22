# set up

## install the deplyr package if not installed
install.packages("dplyr")
library(data.table) # as it is the best method for large datasets
install.packages('R.utils')
library(R.utils)
library(tidyverse)


# Read the compressed TSV file directly --> transform value which are not correct as NA.
title_basics <- fread("https://datasets.imdbws.com/title.basics.tsv.gz", sep = "\t", na.strings ="\\N")
colSums(is.na(title_basics)) # to check how many columns are there

# Remove not needed column value --> for now just endYear (as it is just for tv series) and primary title git pu
title_basics[, endYear :=NULL]
View(title_basics)

# Mantain just Movie and TVmovie
unique(title_basics$titleType) #to find which type are inside
title_basics <- title_basics %>% filter(titleType %in% c("movie", "tvMovie")) # to clean it
sum(is.na(title_basics$startYear))
max(title_basics$startYear, na.rm = T)

# we need to delete either original title or primary title column
# we can remove the rows where the start year is NA
# we can remove the movies where the start year is >=2025