# SMITH Competition – Claude Configuration

## Project Overview

This is the **Students Mastering Intriguing Testable Hypotheses (SMITH)** competition, an annual Laurier Economics undergraduate forecasting competition. Participants predict end-of-season NHL team winning percentages using data available at the start of the season, scored by RMSE.

## Tech Stack

- **R** – primary language for data processing and report generation
- **Quarto** – static website (renders `.qmd` files to HTML)
- **renv** – R dependency management (`renv.lock` pins all packages)
- **GitHub Actions** – CI/CD; auto-publishes to `gh-pages` on push and daily at 3:59 UTC
- **Google Drive** – stores participant submissions (accessed via `googledrive` package)

## Key Files

| File | Purpose |
|------|---------|
| `index.qmd` | Main competition page (rules, timeline, prizes, data links) |
| `report.qmd` | Dynamic leaderboard – downloads submissions, validates, scores, and displays rankings |
| `help.qmd` | Tutorial page with embedded instructional videos |
| `_quarto.yml` | Quarto site config (theme, navigation, social metadata) |
| `data/train.csv/.dta` | Training data (2014–15 through 2023–24 NHL seasons) |
| `data/eval.csv/.dta` | Evaluation data (2024–25 season, no target variable) |
| `data/teams.xlsx` | Registry of participating teams and year levels |
| `data/NHL_Data_Dictionary.xlsx` | Variable documentation |
| `updatermse.R` | Utility: calculates RMSE from predictions.xlsx, appends to results.csv |
| `.github/workflows/publish.yml` | GitHub Actions workflow |

## Submission & Scoring Pipeline (in `report.qmd`)

1. Downloads submission files from Google Drive (secret: `DATA_FOLDER`)
2. Fuzzy-matches filename to registered team in `teams.xlsx` (edit distance ≤ 2)
3. Validates CSV/Excel structure and column names
4. Compares predictions to true outcomes (secret: `EVAL_FILE`)
5. Scores with RMSE; displays rankings overall and by year level
6. Reports per-submission errors in a "Submission Issues" table

## Development Notes

- The site is rendered and published automatically via GitHub Actions — local `quarto render` is for previewing only
- R packages are managed with `renv`; run `renv::restore()` after cloning
- Secrets (`EVAL_FILE`, `DATA_FOLDER`) are GitHub Actions secrets and not available locally
- `teams.xlsx` is updated manually each year as teams register
- The `.claude/worktrees/` directory is used by Claude Code for isolated agent work and is git-ignored
