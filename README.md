# CS2 Round Duration Analysis

An exploratory statistical analysis of professional Counter-Strike 2 (CS2) matches, investigating how round duration is associated with the timing of the opening kill and the winning side.

## Research Questions

1. How is active round duration associated with the timing of the opening kill?
2. How is active round duration associated with the winning side of the round?

## Dataset

**Source:** [OpenCS2 Dataset](https://huggingface.co/datasets/blanchon/opencs2_dataset)

The dataset contains round-level statistics from professional CS2 matches.

The analysis focuses on three variables:

| Variable | Description | Type |
|---|---|---|
| `active_round_duration_s` | Round duration in seconds, excluding freeze time | Numeric Response |
| `opening_kill_seconds` | Time until the first kill in seconds | Numeric Explanatory |
| `winner_side` | Winning side (CT or T) | Binary Categorical Explanatory |

## Data Preparation

The original dataset contained **16,527 rounds**.

The preprocessing steps included:

- Calculating active round duration from game tick data.
- Removing 14 observations with missing opening-kill times.
- Randomly selecting one round per match to reduce dependence between observations.
- Verifying the cleaned dataset for missing and invalid values.

The final dataset contains **359 observations**, representing 359 different matches.

## Analysis

The project uses R to examine the distributions of the three variables and investigate their relationships.

Descriptive analysis includes:

- Histograms of active round duration and opening-kill time.
- A scatterplot comparing opening-kill time with active round duration.
- A bar chart of winning-side frequencies.
- Side-by-side boxplots comparing active round duration by winning side.

## Project Timeline

![Project Progress](https://year-in-progress.vercel.app/year-progress?startDate=2026-09-18&endDate=2026-12-04&theme=dark)

| Milestone | Due Date | Status |
|---|---|---|
| Project Proposal | Sep 18, 2026 | ✅ Completed |
| Descriptive Analysis | Nov 6, 2026 | 🔄 In Progress |
| Final Project | Dec 4, 2026 | ⏳ Upcoming |

## Project Timeline

| Milestone | Due Date |
|---|---|
| Project Proposal | September 18, 2026 |
| Descriptive Analysis | November 6, 2026 |
| Final Project | December 4, 2026 |

## Tools

- R
- RStudio
- R Markdown
- Apache Arrow
- Git / GitHub

## Limitations

The original matches were not randomly sampled from all professional CS2 matches. Although one round was randomly selected per match, the results may not generalize to the entire professional CS2 population.

## Project Context

Developed for SDS 320E at The University of Texas at Austin.
