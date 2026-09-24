# YouTube Audience & Content Analysis (Excel)

An Excel-based analytics project that helps a YouTube creator decide **what content to make, when to publish it, and who is watching**, so that views, engagement and subscribers grow faster.

> **Data disclaimer:** the 144 videos and the audience figures are simulated for learning purposes. They do not describe a real channel.

## Project Structure

```
youtube-audience-content-analysis/
├── README.md
├── .gitignore
└── excel/
    └── YouTube_Audience_Content_Analysis.xlsx
```

## Objectives

- Measure channel performance with KPIs: views, watch time, CTR, engagement rate and subscriber conversion.
- Compare content categories, formats (Long-form vs Shorts) and video-length buckets.
- Find the best publishing days and understand monthly growth, with a simple 3-month trend forecast.
- Profile the audience by age, gender, country, device and traffic source.
- Test relationships between variables using correlation and regression.
- Turn the findings into clear, data-backed content and publishing recommendations.

## Workbook Guide

| Sheet | What it contains |
|---|---|
| `README` | Project overview, KPI definitions, methodology and assumptions |
| `Dashboard` | KPI tiles and 8 charts summarising the whole project |
| `Videos_Data` | 144 videos (Sep 2025 – Aug 2026). Raw data columns plus calculated columns (formulas) |
| `Audience_Data` | Age × gender matrix, geography, device and traffic-source tables |
| `Content_Analysis` | Category, format and duration-bucket performance |
| `Timing_Trends` | Publishing-day, weekend vs weekday, monthly trend and linear forecast |
| `Top_Performers` | Top 10 by views, top 10 by engagement, bottom 5 by views |
| `Stats_Correlation` | Descriptive statistics, correlation matrix, regression and a what-if predictor |
| `Insights` | Auto-updating findings, recommendations and limitations |

## KPI Definitions

| KPI | Formula |
|---|---|
| CTR | Views / Impressions |
| Engagement Rate | (Likes + Comments + Shares) / Views |
| Avg View Duration | Watch Time (hrs) × 60 / Views |
| Avg % Viewed | Avg View Duration / Video Duration |
| Subscriber Conversion | Subscribers Gained / Views |

Duration buckets: Under 1 min, 1–5, 5–10, 10–20 and 20+ min. Weekend = Saturday and Sunday.

## Methodology

1. **Data:** collect video-level and audience data (YouTube Studio → Analytics → Advanced mode → Export).
2. **Clean and enrich:** add calculated columns (month, weekday, CTR, engagement, buckets).
3. **Analyse:** `SUMIFS`, `COUNTIFS`, `AVERAGEIFS`, `RANK`, `LARGE` / `SMALL` with `INDEX` / `MATCH`, `CORREL`, `SLOPE`, `RSQ`, `FORECAST`.
4. **Visualise:** dashboard with charts and conditional formatting.
5. **Recommend:** dynamic insight text driven by the analysis tables.

## How to Use

1. Download `excel/YouTube_Audience_Content_Analysis.xlsx` and open it in Microsoft Excel. GitHub's file preview does not show the charts.
2. All analysis tables, dashboard tiles and insights are live formulas, so they update if the data changes.
3. Blue text on a yellow background marks input cells you can change (audience shares, average durations, opening subscribers, what-if impressions).
4. To use your own data, paste your export over columns A–M of `Videos_Data`, keeping the same column order and formats. If you add rows, insert them inside the table and copy the green formulas down.

## Tools

- Microsoft Excel (formulas, charts, conditional formatting)

## Possible Extensions

- Add Power Query, PivotTables and slicers for category and month.
- Run a t-test on weekend vs weekday views, or compare thumbnail and title styles.
- Add competitor benchmarking and cohort analysis of subscribers gained per upload.
