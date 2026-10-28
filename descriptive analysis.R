#Descriptive Analysis of Response Variable:
hist(df$active_round_duration_s, 
     main = "Active Round Duration Distribution",
     xlab = "Active Round Duration (s)",
     ylab = "Frequency",
     col = "#eda338")
summary(df$active_round_duration_s)
sd(df$active_round_duration_s)

#Investigation of Numeric Explanatory Variable:
hist(df$opening_kill_seconds,
     main = "Opening Kill Distribution",
     xlab = "Opening Kill Distribution (s)",
     ylab = "Frequency",
     col = "#eda338")
summary(df$opening_kill_seconds)
sd(df$opening_kill_seconds)
plot(df$active_round_duration_s ~ df$opening_kill_seconds, data = df,
     main = "Opening Kill (s) vs Active Round Duration (s)",
     xlab = "Opening Kill (s)",
     ylab = " Active Round Duration (s)",
     col = "#eda338")

#Investigation of Categorical Explanatory Variable:
winner_table <- table(df$winner_side)
barplot(winner_table,
        main = "Winning Side Distribution",
        xlab = "Winning Side",
        ylab = "Frequency",
        col = c("#5d79ae", "#eda338"))
winner_table
prop.table(winner_table)
boxplot(df$active_round_duration_s ~ df$winner_side, data = df,
        main = "Active Round Duration by Winning side",
        xlab = "Winning Side",
        ylab = "Active Round Duration (s)",
        col = c("#5d79ae", "#eda338"))

        