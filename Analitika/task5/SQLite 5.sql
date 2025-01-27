--Вывести покупателей с количеством осуществленных покупок
SELECT c.first_name, c.last_name, COUNT(p.purchase_id) AS purchase_count
FROM Customers c
LEFT JOIN Purchases p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY purchase_count DESC;

-- Общую стоимость товаров для каждого покупателя и отсортировать результат в порядке убывания
SELECT c.first_name, c.last_name, SUM(p.price) AS total_spent
FROM Customers c
JOIN Purchases ps ON c.customer_id = ps.customer_id
JOIN Products p ON ps.product_id = p.product_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;

-- Получить покупателей, купивших только один товар
SELECT c.first_name, c.last_name
FROM Customers c
JOIN (
    SELECT customer_id
    FROM Purchases
    GROUP BY customer_id
    HAVING COUNT(DISTINCT product_id) = 1
) AS single_product_buyers ON c.customer_id = single_product_buyers.customer_id;