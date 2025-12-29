WITH CustomerSpend AS (
  SELECT
    c.countries,
    c.customer_id,
    ROUND(SUM(o.quantity * p.price),2) AS total_spend
  FROM
    `e_commerce.orders` AS o
  JOIN `e_commerce.customers` AS c
    ON o.customer_id = c.customer_id
  JOIN `e_commerce.products` AS p
    ON o.product_id = p.product_id
  GROUP BY 1,2
)
SELECT *
FROM CustomerSpend
ORDER BY
  countries,
  total_spend DESC
LIMIT 12;