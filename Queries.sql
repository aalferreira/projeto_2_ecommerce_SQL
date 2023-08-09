-- Recuperar o nome e o valor total dos pedidos de cada cliente:
SELECT c.Fname, c.Lname, SUM(o.sendValue) AS TotalOrderValue
FROM clients c
INNER JOIN orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient;

-- Listar os produtos da categoria 'Vestimenta' com avaliação acima de 3 e ordená-los pelo nome:
SELECT Pname, avaliacao
FROM product
WHERE category = 'Vestimenta' AND avaliacao > 3
ORDER BY Pname;

-- Calcular o valor médio dos pedidos para cada status de pedido, apenas para pedidos confirmados ou em processamento:
SELECT orderStatus, AVG(sendValue) AS AvgOrderValue
FROM orders
WHERE orderStatus IN ('Confirmado', 'Em processamento')
GROUP BY orderStatus;

-- Recuperar a quantidade total de produtos em estoque para cada categoria, com limite de 100 produtos no estoque:
SELECT p.category, SUM(ps.quantity) AS TotalQuantity
FROM productStorage ps
INNER JOIN product p ON ps.idProdStorage = p.idProduct
GROUP BY p.category
HAVING TotalQuantity <= 100;

-- Listar os vendedores que têm mais de 3 produtos disponíveis para venda:
SELECT s.SocialName, COUNT(ps.idProduct) AS NumProducts
FROM seller s
INNER JOIN productSeller ps ON s.idSeller = ps.idPseller
WHERE ps.prodQuantity > 3
GROUP BY s.idSeller;

-- Recuperar o nome e a quantidade de pedidos para cada cliente que fez mais de um pedido:
SELECT c.Fname, c.Lname, COUNT(o.idOrder) AS NumOrders
FROM clients c
INNER JOIN orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient
HAVING NumOrders > 1;

-- Listar os fornecedores que fornecem produtos na categoria 'Alimentos' e 'Vestimenta':
SELECT s.SocialName, p.category
FROM supplier s
INNER JOIN productSupplie ps ON s.idSupplier = ps.idPsSupplier
INNER JOIN product p ON ps.idPsProduct = p.idProduct
WHERE p.category IN ('Alimentos', 'Vestimenta');
