'
Among rounds of CS2 matches, how is the round duration associated with the winning side and timing of the opening kill?
- NRV: round_duration_s
- NEV: opening_kill_seconds
- BCEV: winner_sidelibrary(arrow)
'

# Download dataset
url <- "https://huggingface.co/datasets/blanchon/opencs2_dataset/resolve/main/index/rounds.parquet"

download.file(url, "Dataset/rounds.parquet", mode = "wb")

# Load dataset
df <- read_parquet("Dataset/rounds.parquet")

# Select only the 3 variables
df_variables <- df[, c(
  "round_duration_s",
  "opening_kill_seconds",
  "winner_side"
)]

# Export without cleaning
write.csv(df_variables, "Dataset/csdata.csv", row.names = FALSE)

# View dataset
View(df_variables)

head(df_variables)
