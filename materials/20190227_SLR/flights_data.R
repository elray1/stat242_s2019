library(nycflights13)
library(tidyverse)

flights %>% count(carrier, origin) %>% spread(origin, n)
flights %>%
  filter(carrier == "9E", origin == "JFK") %>%
  filter(month == 1) %>%
  distinct(distance)

flights %>%
  filter(carrier == "9E", origin == "JFK") %>%
  filter(month == 1) %>%
  ggplot() +
    geom_point(mapping = aes(x = distance, y = air_time))


flights %>%
  filter(carrier == "9E", origin == "JFK") %>%
  filter(month == 1) %>%
  count(distance) %>%
  as.data.frame()

flights_subset <- flights %>%
  filter(carrier == "9E", origin == "JFK", month == 1) %>%
  filter(distance %in% c(1029, 589, 765)) %>%
  select(distance, air_time) %>%
  drop_na()

setwd("~/Documents/teaching/2018/fall/stat140/stat140_f2018/materials/20181126_slr_sampling_dist/")
write_csv(flights_subset, "flights_endeavor_jfk_jan2013.csv")

fit <- lm(air_time ~ distance, data = flights_subset)
flights_subset2 <- flights_subset %>%
  mutate(
    residual = residuals(fit)
  )

ggplot(data = flights_subset2, mapping = aes(x = residual, color = factor(distance))) +
  geom_density()

flights_subset <- flights %>%
  filter(origin == "JFK") %>%
  select(distance, air_time) %>%
  drop_na()

setwd("~/Documents/teaching/2018/fall/stat140/stat140_f2018/materials/20181126_slr_sampling_dist/")
write_csv(flights_subset, "flights_jfk.csv")
