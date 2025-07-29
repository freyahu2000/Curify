# Curify Business Metrics Dashboard

This is a simple internal dashboard for visualizing business and user engagement metrics on Curify Studio. It is built with **FastAPI** (Python backend) and a responsive **HTML/Chart.js** frontend.


## 📊 Metrics Tracked

- **Daily Active Users (DAU):**  
  Unique users who created at least one project on the selected date.  
  → Based on `project.created_at`.

- **Weekly Active Users (WAU):**  
  Unique users who created projects in the past 7 days ending on the selected date.

- **New Registrations:**  
  Number of new users created on the selected date.  
  → From `user.created_at`.

- **Daily Revenue ($):**  
  Total revenue generated from transactions on the selected date.  
  → From `transaction.created_at`.

- **Monthly Revenue ($):**  
  Total revenue generated in the **last 30 days** ending on the selected date.

- **Paid Users:**  
  Number of distinct users who made a transaction on the selected date.

- **User Distribution (Free vs Pro):**  
  Based on active subscriptions in the `subscription` table.


## 🧠 Assumptions & Notes

- Metrics are based on project/user/transaction timestamps in UTC.
- Users without active `Pro` subscriptions are categorized as **Free**.
- Monthly revenue is **rolling 30-day**, not calendar-based.
- The dashboard works with a local PostgreSQL database (`curify_local`) and assumes standard table structure.



## ⚙️ Tech Stack

- **FastAPI** for backend APIs
- **PostgreSQL** for metrics data
- **Chart.js** for frontend visualizations
- **Vanilla HTML/CSS/JS** with responsive styles



## 📥 Setup Instructions

- **Install dependencies:** pip install fastapi psycopg2 uvicorn

- **Run FastAPI backend:** uvicorn main:app --reload



- **Open browser at: http://127.0.0.1:8000**


flowchart TD
    User[User in browser]
    User -->|Requests page| Frontend[Static HTML + JS (index.html)]
    Frontend -->|Fetch metrics with date param| FastAPI[FastAPI backend (/admin/metrics/business)]
    
    FastAPI -->|Connects| PostgreSQL[(PostgreSQL DB)]
    PostgreSQL -->|project.created_at| DAU[Daily Active Users]
    PostgreSQL -->|project.created_at| WAU[Weekly Active Users]
    PostgreSQL -->|user.created_at| NewUsers[New Registrations]
    PostgreSQL -->|transaction.created_at| DailyRev[Daily Revenue]
    PostgreSQL -->|transaction.created_at| MonthlyRev[Monthly Revenue]
    PostgreSQL -->|transaction.created_at| PaidUsers[Paid Users]
    PostgreSQL -->|subscription| Bucket[Free vs Pro Users]

    FastAPI -->|Returns JSON| Frontend
    Frontend -->|Render Cards + Charts| ChartJS[Chart.js Visualizations]


- **The HTML file is served from `/static/index.html`**
