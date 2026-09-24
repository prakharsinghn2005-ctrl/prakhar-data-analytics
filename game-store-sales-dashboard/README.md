# Game Store Sales — Power BI Dashboard

A Power BI dashboard analysing sales for an Indian digital game store (games, gift cards, subscriptions and Steam keys) sold across multiple platforms and payment methods.

## Project Structure

```
game-store-sales-dashboard/
├── README.md
├── .gitignore
├── data/
│   └── GameStore_Sales_Dataset.xlsx   # Source data (3 sheets)
└── dashboard/
    └── game_store.pbix                # Power BI report
```

## Dataset at a Glance

`GameStore_Sales_Dataset.xlsx` has three sheets:

| Sheet | Rows | Columns |
|---|---|---|
| `Sales` | 1,400 | OrderID, OrderDate, CustomerID, CustomerName, State, CustomerType, Product, Category, Publisher, Platform, Quantity, UnitPriceINR, DiscountPct, RevenueINR, PaymentMethod, OrderStatus |
| `Customers` | 260 | CustomerID, CustomerName, State, SignupDate |
| `Products` | 20 | Product, Category, BasePriceINR, Publisher |

**Order period:** 2024-06-02 to 2025-08-31
**States (15):** Bihar, Delhi, Gujarat, Haryana, Karnataka, Kerala, Madhya Pradesh, Maharashtra, Odisha, Punjab, Rajasthan, Tamil Nadu, Telangana, Uttar Pradesh, West Bengal
**Categories:** Action, Gift Card, RPG, Sandbox, Shooter, Sports, Steam Key, Subscription
**Platforms:** Mobile, PC (Direct), PlayStation, Steam, Xbox
**Payment methods:** Credit Card, Debit Card, Net Banking, UPI, Wallet
**Order status:** Completed, Cancelled, Refunded
**Customer type:** New, Returning

## Using the Dashboard

1. Install [Power BI Desktop](https://powerbi.microsoft.com/desktop/) (Windows).
2. Open `dashboard/game_store.pbix`.
3. If Power BI shows a data source error, go to **Home → Transform data → Data source settings** and point the source to `data/GameStore_Sales_Dataset.xlsx` on your machine.

## Tools

- Power BI Desktop
- Microsoft Excel (source data)
