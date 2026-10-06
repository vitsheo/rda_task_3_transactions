USE ShopDB;

-- Початок транзакції для забезпечення цілісності всіх пов'язаних даних
START TRANSACTION;

-- 1. Створення нового замовлення для клієнта з ID 1
INSERT INTO Orders (CustomerID, Date)
VALUES (1, '2023-01-01');

-- Зберігаємо ID щойно створеного замовлення у змінну
SET @last_order_id = LAST_INSERT_ID();

-- 2. Додавання товару AwersomeProduct (ID: 1) у кількості 1 шт. (Count = 1)
INSERT INTO OrderItems (OrderID, ProductID, Count)
VALUES (@last_order_id, 1, 1);

-- 3. Зменшення кількості товару на складі на 1 шт.
UPDATE Products
SET WarehouseAmount = WarehouseAmount - 1
WHERE ID = 1;

-- Фіксація транзакції
COMMIT;
