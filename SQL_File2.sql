-- Criacao Banco de Dados
DROP database ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

-- Criar tabela clientes
	CREATE TABLE clients(
    idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
    constraint unique_cpf_client unique (CPF)
);

alter table clients auto_increment = 1;

-- Criar tabela produto
CREATE TABLE product(
	idProduct int auto_increment primary key,
    Pname varchar(10),
	classification_kids bool,
    category enum('Eletronico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
    avaliacao float default 0,
    size varchar (10)
);

-- para ser continuado o desafio termine de implementar a tabela e crie a conexão com as tabelas necessárias
CREATE TABLE payments(
	idclient int,
    idpayment int,
    typePayment enum('Boleto', 'Cartao', 'Dois cartoes'),
    limitAvaliable float,
    primary key (idclient, idpayment)
);

-- Criar tabela pedido
CREATE TABLE orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') not null,
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_order_client foreign key (idOrderClient) references clients(idClient)
		on update cascade
);

-- Criar tabela estoque
CREATE TABLE productStorage(
		idProdStorage int auto_increment primary key,
        storageLocation varchar(255),
        quantity int default 0
);

-- Criar tabela fornecedor
CREATE TABLE supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)	
);

-- Criar tabela vendedor
CREATE TABLE seller(
	idSeller int auto_increment primary key,
	SocialName varchar(255) not null,
    AbsName varchar(255),
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

CREATE TABLE productSeller(
	idPseller int,
    idProduct int,
    prodQuantity int default 1,
    primary key (idPseller, idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idProduct) references product(idProduct)
);

CREATE TABLE productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
    primary key (idPOproduct, idPOorder),
    constraint fk_product_seller_2 foreign key (idPOproduct) references product(idProduct),
    constraint fk_product_product_2 foreign key (idPOorder) references orders(idOrder)
);

CREATE TABLE storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_product_seller3 foreign key (idLproduct) references product(idProduct),
    constraint fk_product_product3 foreign key (idLstorage) references orders(idOrder)
);

CREATE TABLE productSupplie(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

CREATE TABLE clientsInfo (
    idInfo int auto_increment primary key,
    idClient int,
    type enum('PF', 'PJ') not null,
    name varchar(255) not null,
    CNPJ char(14) null,
    CPF char(11) null,
    constraint fk_info_client foreign key (idClient) references clients(idClient)
);

CREATE TABLE clientPayments (
    idClient int,
    idPayment int auto_increment primary key,
    typePayment enum('Boleto', 'Cartao', 'Dois cartoes'),
    limitAvailable float,
    constraint fk_payment_client foreign key (idClient) references clients(idClient)
);

CREATE TABLE deliveries (
    idDelivery int auto_increment primary key,
    idOrder int,
    status enum('Em trânsito', 'Entregue', 'Pendente') not null,
    trackingCode varchar(20) not null,
    constraint fk_delivery_order foreign key (idOrder) references orders(idOrder)
);

-- show databases;


-- Inserção de dados de exemplo para tabela 'clients'
INSERT INTO clients (Fname, Minit, Lname, CPF, Address)
VALUES
    ('John', 'Doe', 'Smith', '12345678901', '123 Main St'),
    ('Jane', 'E', 'Doe', '98765432101', '456 Elm St');

-- Inserção de dados de exemplo para tabela 'product'
INSERT INTO product (Pname, classification_kids, category, avaliacao, size)
VALUES
    ('Smartphone', 0, 'Eletronico', 4.5, '6 inches'),
    ('Camiseta', 1, 'Vestimenta', 3.8, 'M');

-- Inserção de dados de exemplo para tabela 'payments'
INSERT INTO payments (idclient, idpayment, typePayment, limitAvaliable)
VALUES
    (1, 101, 'Cartao', 500.00),
    (1, 102, 'Boleto', 0.00);

-- Inserção de dados de exemplo para tabela 'orders'
INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
VALUES
    (1, 'Confirmado', 'Pedido de smartphones', 15.00, false),
    (2, 'Em processamento', 'Pedido de camisetas', 10.00, true);

-- Inserção de dados de exemplo para tabela 'productStorage'
INSERT INTO productStorage (storageLocation, quantity)
VALUES
    ('Prateleira 1', 50),
    ('Estoque Central', 100);

-- Inserção de dados de exemplo para tabela 'supplier'
INSERT INTO supplier (SocialName, CNPJ, contact)
VALUES
    ('Tech Suppliers Inc.', '12345678901234', '98765432101'),
    ('Fashion Distributors Ltd.', '98765432109876', '12345678901');

-- Inserção de dados de exemplo para tabela 'seller'
INSERT INTO seller (SocialName, AbsName, CNPJ, CPF, location, contact)
VALUES
    ('Electronics World', 'E. World', '98765432101234', '123456789', 'Tech Street', '98765432101'),
    ('Fashion Trendz', 'F. Trendz', '87654321098765', '987654321', 'Fashion Avenue', '12345678901');

-- Inserção de dados de exemplo para tabela 'productSeller'
INSERT INTO productSeller (idPseller, idProduct, prodQuantity)
VALUES
    (1, 1, 20),
    (2, 2, 30);

-- Inserção de dados de exemplo para tabela 'productOrder'
INSERT INTO productOrder (idPOproduct, idPOorder, poQuantity, poStatus)
VALUES
    (1, 1, 5, 'Disponivel'),
    (2, 2, 10, default);

-- Inserção de dados de exemplo para tabela 'storageLocation'
INSERT INTO storageLocation (idLproduct, idLstorage, location)
VALUES
    (1, 1, 'Prateleira A'),
    (2, 2, 'Estoque Setor B');

-- Inserção de dados de exemplo para tabela 'productSupplie'
INSERT INTO productSupplie (idPsSupplier, idPsProduct, quantity)
VALUES
    (1, 1, 100),
    (2, 2, 200);
    
-- Cliente Pessoa Física
INSERT INTO clientsInfo (idClient, type, name, CPF)
VALUES (1, 'PF', 'John Doe', '12345678901');

-- Cliente Pessoa Jurídica
INSERT INTO clientsInfo (idClient, type, name, CNPJ)
VALUES (2, 'PJ', 'Tech Company Inc.', '12345678901234');

-- Pagamentos para Cliente PF
INSERT INTO clientPayments (idClient, typePayment, limitAvailable)
VALUES (1, 'Cartao', 500.00),
       (1, 'Boleto', 0.00);

-- Pagamentos para Cliente PJ
INSERT INTO clientPayments (idClient, typePayment, limitAvailable)
VALUES (2, 'Cartao', 1000.00),
       (2, 'Dois cartoes', 2000.00);

-- Informações de Entrega para Pedidos
INSERT INTO deliveries (idOrder, status, trackingCode)
VALUES (1, 'Em trânsito', 'ABC123'),
       (2, 'Pendente', 'XYZ789');

show tables;

select * from seller