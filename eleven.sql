-- one
START TRANSACTION;
SET @a = 10;
SET @b = 15;
SET @c = 0;

IF @c >= 0 THEN
    SET @sum = @a + @b;
    SELECT @sum AS 'Сумма a и b';
ELSE
    ROLLBACK;
END IF;

COMMIT;


-- table creation
CREATE TABLE customers (
  id INT NOT NULL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  has_debt BOOLEAN NOT NULL
);
CREATE TABLE orders (
  id INT NOT NULL PRIMARY KEY,
  customer_id INT NOT NULL,
  FOREIGN KEY (flower_id) REFERENCES flowers(id),
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- fill out tables
INSERT INTO customers (id, name, has_debt) VALUES (1, 'John', false), (2, 'Mary', true), (3, 'Bob', false);

-- two
START TRANSACTION;
INSERT INTO customers (id, has_debt) VALUES (4, false);
ROLLBACK;

-- three
START TRANSACTION;
DECLARE @has_debt BOOLEAN;
SELECT has_debt INTO @has_debt FROM customers WHERE id = 1;
IF @has_debt THEN
  ROLLBACK;
ELSE
  INSERT INTO orders (id, customer_id) VALUES (1, 1);
  COMMIT;
END IF;


