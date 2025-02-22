# set up

## install the dplyr package if not installed
install.packages(c("dplyr", 'R.utils', "lubridate"))
library(data.table) 
library(R.utils)
library(tidyverse)
library(lubridate)

# Read the compressed TSV file directly --> transform value which are not correct as NA.
title_basics <- fread("https://datasets.imdbws.com/title.basics.tsv.gz", sep = "\t", na.strings ="\\N")

# Remove not needed column value --> endYear (as it is just for tv series) and original title (as we use primary title)
title_basics[, endYear :=NULL]
title_basics[, originalTitle :=NULL]

# Mantain just Movie and TVmovie
unique(title_basics$titleType) #to find which type are inside
title_basics <- title_basics %>% filter(titleType %in% c("movie", "tvMovie")) # to clean it
<<<<<<< HEAD:clean_title_basics.R

# Clean StartYear: make until current year and remove NA (108058)
current_year <- year(Sys.Date()) #Find the current year
title_basics <- title_basics %>% filter(startYear <= current_year) # to clean it


colSums(is.na(title_basics)) # to check how many NA are in each column --> there are still many NA but we are not interested in untime and genre
=======
sum(is.na(title_basics$startYear))
max(title_basics$startYear, na.rm = T)

# we need to delete either original title or primary title column
# we can remove the rows where the start year is NA
# we can remove the movies where the start year is >=2025
>>>>>>> cbe37b0ec5c064da67820b5c2f9b72a93008c6ec:src/data-preparation/clean_title_basics.R
