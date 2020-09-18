
--исправление отрицательных значений в поле Цена с дополнительными условиями фильтрации
UPDATE sale
SET price = ABS(price)
WHERE pharmacyid = (SELECT id FROM pharmacy WHERE city = 'Stavropol') AND saletime BETWEEN '01-01-2019' AND '31-01-2019'

--удаление дубликатов с дополнительными условиями фильтрации
DELETE FROM sale WHERE pharmacyid = 5 AND ctid NOT IN (SELECT MAX(ctid) FROM sale GROUP BY id)