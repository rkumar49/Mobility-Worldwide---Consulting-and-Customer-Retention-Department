# Mobility-Worldwide---Consulting-and-Customer-Retention-Department

## 📌 Project Overview

This project explores operational data from Mobility Worldwide’s (MWW) Consulting & Customer Retention (CCR) department. Through historical data analysis, geospatial techniques, and predictive modeling, the study aims to assess office performance, optimize resource allocation, and identify opportunities for cost savings. A major goal is to determine the feasibility of establishing a new branch office in a strategically beneficial region to boost operational efficiency and profitability.

---

## 🎯 Key Objectives

### 1. Cost Evaluation
- Calculate the average operational costs of a branch office.
- Include expenses such as rent, personnel, maintenance, and other recurring expenditures.

### 2. Business Trip Visualization
- Analyze and visualize consultant business trips.
- Emphasize trips requiring overnight stays due to distance or duration.

### 3. New Branch Feasibility Assessment
- Examine the viability of opening a new branch office.
- Perform location-based analysis and cost-benefit forecasting.

---

## 🛠 Methodology

### Data Collection & Preparation
- Extract historical data from MWW’s internal **SAP Data Warehouse Cloud (DWC)** and various external data sources.
- Data includes employee information, travel records, maintenance logs, and hotel pricing.

### Cost Analysis
- Calculate average costs across existing branches.
- Factor in all major operational expenses.

### Business Trip Mapping
- Use geospatial visualization to analyze travel patterns.
- Identify trips that trigger overnight stay policies.

### Feasibility Study
- Conduct a data-driven analysis to evaluate potential new branch locations.
- Forecast cost implications and profitability impacts.

---

## 📁 Project Structure

### `Queries/`
- Contains SQL scripts for data extraction from SAP DWC.

### `Python_Scripts/`
- Includes Python code for geospatial and travel distance analysis.
- Uses Google Maps API for distance/time calculations.

---

## ⚙️ Technologies Used

- **SAP Data Warehouse Cloud (DWC)** – Central source for internal business data.
- **Google Cloud Platform (GCP)** – Used for scalable data processing and analytics.
  - **BigQuery** – Cloud-based data warehouse for querying large datasets.
  - **Looker Studio** – For creating interactive reports and dashboards.
  - **Google Maps API** – Used to compute travel distances and durations.
- **Python** – Primary language for scripting and analysis.
