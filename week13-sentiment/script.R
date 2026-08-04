# Adela would prefer if we worked in the same directory, but with different scripts for each lesson
library(tidyverse)
library(here)
dir.create("data")
# R reads the .csv, but it does not load it into the program
read_csv("data/SAFI_clean.csv")
# We need to make the .csv file into an object if we want to work with it permanently
interviews <- read_csv("data/SAFI_clean.csv")
interviews
# A tibble/tbl is a table that interperates each columns data type. It is good because it can combine columns of different types in one table
# First we want to inspect our data set
class(interviews)
dim(interviews)
ncol(interviews)
# Another good function to run is head(). It shows the first six rows so you can check the data set out
head(interviews)
# Adela recommends this function the most. Shows the spreadsheet sideways. This way you can see all the data types and values more clearly
glimpse(interviews)

# Subsetting
# [] allows you to pull data out of objects
interviews[7:8 ,c(2:5, 7,10) ]
smart_column <- interviews[7:8 ,c(2:5, 7,10) ]
# Sometimes you want to eliminate values. Eliminates the first row
interviews[-1,]
# Eliminates the first 10 rows
interviews[-c(1:10),]
# Calling out columns by their name
interviews["village"]
interviews[,2]
interviews$no_membrs
mean(interviews$no_membrs, na.rm=TRUE)

interviews100 <- interviews[100,]
last_row <- interviews[131,]
last_row <- interviews[nrow(interviews),]

# We are skipping the factors and lubridates sections so i might have to go back to those

# Starting with dplr
# select function legible and transferable way of pulling out columns
select(interviews, village, no_membrs, rooms)
# filter function works on rows
filter(interviews,rooms>2)
# 39 of the interviews are conducted in Chrirodzo, i can see this by the number of rows
filter(interviews,village=="Chirodzo")
# from the Chirodzo where the number of rooms are greater than 2. There are 11 interviews, i can see this by the number of rows
filter(interviews,village=="Chirodzo",rooms>2)
# from Chirodzo and Ruace there are 20 interviews with more than 2 rooms
filter(interviews,village=="Ruaca"|village=="Chirodzo",rooms>2)
rooms_over2 <- filter(interviews,village=="Ruaca"|village=="Chirodzo",rooms>2)

# Pipes %>% write the name of the object that you wish to subset and subject it to a series of functions. Pipe is weird and you need to use enter
interviews %>% 
  select(village,rooms) %>% 
  filter(rooms>2)

# Exercise. I did it correctly yay!
interviews %>% 
  filter(memb_assoc=="yes") %>% 
  select(affect_conflicts,liv_count,no_meals)

interview_new <- interviews %>% 
  filter(memb_assoc=="yes") %>% 
  select(affect_conflicts,liv_count,no_membrs,rooms) %>% 
  mutate(people_per_room=no_membrs/rooms)
