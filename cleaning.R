'
Among rounds of CS2 matches, how is the round duration associated with the winning side and timing of the opening kill?
- NRV: active_round_duration_s
- NEV: opening_kill_seconds
- BCEV: winner_side
'

library(arrow)


# Download dataset
url <- "https://huggingface.co/datasets/blanchon/opencs2_dataset/resolve/main/index/rounds.parquet"

download.file(url, "Dataset/rounds.parquet", mode = "wb")

# Load dataset
df_original <- read_parquet("Dataset/rounds.parquet")

# Select only the 3 variables
df_variables <- df_original[, c(
  "round_duration_s",
  "opening_kill_seconds",
  "winner_side"
)]

# Export without cleaning
write.csv(df_variables, "Dataset/csdata.csv", row.names = FALSE)

# View dataset
View(df_variables)

head(df_variables)


# Check the data
#size
nrow(df_variables)
#datatypes
str(df_variables)
#summary
summary(df_variables)
#missing variables
colSums(is.na(df_variables))
#count winning side
table(df_variables$winner_side, useNA="ifany")

#Check for long rounds
sum(df_variables$round_duration_s > 200)
#summarize
summary(df_variables$round_duration_s[df_variables$round_duration_s > 200])
#check names
names(df_original)

# calculate active round duration prep
head(df_original[, c("round_start_tick", "freeze_end_tick", "round_end_tick", "round_duration_s")])
#Note: Uses 64 ticks per second

#calculate active round duration
df_original$active_round_duration_s <- (df_original$round_end_tick - df_original$freeze_end_tick) / 64
summary(df_original$active_round_duration_s)
sum(df_original$active_round_duration_s > 180)

# check invalid opening kills
sum(df_original$opening_kill_seconds > df_original$active_round_duration_s, na.rm = TRUE)

# remove missing values
df_clean <- df_original[!is.na(df_original$opening_kill_seconds), ]
# verify
nrow(df_clean)

# Select one round per match (random, but not random overall)
#seed
set.seed(123)
#randomize
df_clean <- df_clean[sample(nrow(df_clean)), ]
# one round per match
df_clean <- df_clean[!duplicated(df_clean$match_id), ]
#check size
nrow(df_clean)

# create cleaned dataset
df <- df_clean[, c(
  "active_round_duration_s",
  "opening_kill_seconds",
  "winner_side"
)]

#check
summary(df)
colSums(is.na(df))
table(df$winner_side)

write.csv(df, "Dataset/csdata_clean.csv", row.names = FALSE)