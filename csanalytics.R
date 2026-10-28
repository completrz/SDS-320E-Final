library(arrow)

# Download dataset
url <- "https://huggingface.co/datasets/blanchon/opencs2_dataset/resolve/main/index/rounds.parquet"

download.file(url, "rounds.parquet", mode = "wb")

# Load dataset
df <- read_parquet("rounds.parquet")

# Select only the 3 variables
df_variables <- df[, c(
  "opening_kill_seconds",
  "n_kills",
  "winner_side"
)]

# Export without cleaning
write.csv(df_final, "csdata.csv", row.names = FALSE)

# View dataset
View(df_final)