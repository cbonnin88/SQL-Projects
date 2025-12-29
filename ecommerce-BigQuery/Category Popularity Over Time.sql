WITH MonthlyCategorySales AS (
  SELECT
    FORMAT_DATE('%Y-%m',o.order_date) AS sales_month,
    p.category,
    ROUND(SUM(o.quantity * p.price),2) AS revenue
  FROM
    `e_commerce.orders` AS o
  JOIN `e_commerce.products` AS p
    ON o.product_id = p.product_id
  GROUP BY 1,2
),
RankedSales AS (
  SELECT
    *,
    RANK() OVER(PARTITION BY sales_month ORDER BY revenue DESC) AS rank_in_month
  FROM MonthlyCategorySales
)
SELECT *
FROM RankedSales
WHERE rank_in_month = 1
ORDER BY sales_month;