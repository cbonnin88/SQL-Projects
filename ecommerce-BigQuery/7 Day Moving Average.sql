WITH DailySales AS (
  SELECT
    order_date,
    SUM(o.quantity * p.price) AS daily_revenue
  FROM
    `e_commerce.orders`AS o
  JOIN `e_commerce.products` AS p
    ON o.product_id = p.product_id
  GROUP BY
    order_date
)
SELECT
  order_date,
  ROUND(daily_revenue,1) AS daily_revenue,
  AVG(daily_revenue) OVER(
    ORDER BY order_date
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
  ) AS moving_avg_7_day
FROM DailySales
ORDER BY
  order_date;