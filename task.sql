USE ShopDB;

-- 1. Створення нового замовлення (виконується ПОЗА транзакцією)
INSERT INTO Orders (CustomerID, Date)
VALUES (1, '2023-01-01');

-- 2. Початок транзакції для пов'язаних операцій, що потребують атомарності
START TRANSACTION;

-- Додавання товару з використанням LAST_INSERT_ID() від попереднього запиту Orders
INSERT INTO OrderItems (OrderID, ProductID, Count)
VALUES (LAST_INSERT_ID(), 1, 1);

-- Оновлення кількості товару на складі
UPDATE Products
SET WarehouseAmount = WarehouseAmount - 1
WHERE ID = 1;

-- Фіксація транзакції
COMMIT;
