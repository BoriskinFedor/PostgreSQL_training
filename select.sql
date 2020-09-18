
--средняя цена типов товаров по всем аптекам (от большей цены к меньшей)
SELECT product.type AS Type, AVG(sale.price) AS AveragePrice
FROM product
JOIN sale ON sale.productid = product.id
GROUP BY Type
ORDER BY AveragePrice DESC;

--10 самых продаваемых товаров (по кол-ву упаковок) за май 2019 года
--по всем аптекам города Краснодара
SELECT subname
FROM (
SELECT product.name AS subname, SUM(sale.packsnumber) AS packssum
FROM product
JOIN sale ON sale.productid = product.id
JOIN pharmacy ON pharmacy.id = sale.pharmacyid
WHERE pharmacy.city = 'Krasnodar' AND sale.saletime BETWEEN '2019-05-01' AND '2019-05-31'
GROUP BY subname
ORDER BY packssum DESC) AS namedsum
LIMIT 10;

--товары и кол-во уникальных аптек, где данный товар продавался в течение 2019 года
SELECT subname AS Name, COUNT(*) AS Pharmas
FROM (
SELECT DISTINCT ON (sale.pharmacyid, product.name)product.name AS subname, sale.pharmacyid
FROM product
JOIN sale ON sale.productid = product.id
WHERE sale.saletime BETWEEN '01-01-2019' AND '31-12-2019') AS subrequest
GROUP BY Name;

--товары, которые в 2018 году не продавались в городе Краснодаре, но продавались в других городах
SELECT product.name AS name
FROM sale
JOIN product ON product.id = sale.productid
JOIN pharmacy ON pharmacy.id = sale.pharmacyid
WHERE pharmacy.city <> 'Krasnodar' AND sale.saletime BETWEEN '01-01-2018' AND '31-12-2018';

--3 города, в которых находится больше всего аптек
SELECT city, COUNT(*) AS pharmacount
FROM pharmacy
GROUP BY city
ORDER BY pharmacount DESC
LIMIT 3;