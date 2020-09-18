
--функции для добавления/изменения/удаления товаров

CREATE OR REPLACE FUNCTION product_add(prod_name VARCHAR, prod_vital VITAL, prod_type VARCHAR,
									   prod_prescription varchar DEFAULT 'not defined') RETURNS VOID AS $$
BEGIN
	IF prod_name = '' OR prod_type = '' OR prod_prescription = '' THEN
	RAISE EXCEPTION 'Обнаружены пустые строки';
	END IF;
	INSERT INTO product (prodname, vital, prodtype, prescription)
	VALUES (prod_name, prod_vital, prod_type, prod_prescription);
EXCEPTION
WHEN SQLSTATE '23502' THEN
RAISE INFO 'Действие не было выполнено';
RAISE INFO 'Все поля кроме prescription - обязятельны к заполнению';
WHEN SQLSTATE '23505' THEN
RAISE INFO 'Действие не было выполнено';
RAISE INFO 'Товар с таким наименованием уже добавлен в таблицу';
WHEN SQLSTATE 'P0001' THEN
RAISE INFO 'Действие не было выполнено';
RAISE INFO 'Обнаружены пустые строки';
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION product_change(prod_id int, prod_name VARCHAR, prod_vital VITAL, prod_type VARCHAR,
									   prod_prescription varchar) RETURNS VOID AS $$
BEGIN
	IF prod_name = '' OR prod_type = '' OR prod_prescription = '' THEN
	RAISE EXCEPTION 'Обнаружены пустые строки';
	END IF;
	UPDATE product
	SET prodname = prod_name,
	vital = prod_vital,
	prodtype = prod_type,
	prescription = prod_prescription
	WHERE id = prod_id;
EXCEPTION
WHEN SQLSTATE '23502' THEN
RAISE INFO 'Действие не было выполнено';
RAISE INFO 'Все поля кроме prescription - обязятельны к заполнению';
WHEN SQLSTATE '23505' THEN
RAISE INFO 'Действие не было выполнено';
RAISE INFO 'Товар с таким наименованием уже добавлен в таблицу';
WHEN SQLSTATE 'P0001' THEN
RAISE INFO 'Действие не было выполнено';
RAISE INFO 'Обнаружены пустые строки';
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION product_delete(prod_id int) RETURNS VOID AS $$
BEGIN
	DELETE FROM product
	WHERE id = prod_id;
END;
$$ LANGUAGE plpgsql;