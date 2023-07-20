-- Criação banco de dados para o cenário de E-commerce

create database ecommerce;
use ecommerce;
-- criar tabela cliente
CREATE TABLE clients(
	idClient INT auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    constraint unique_cpf_client unique(CPF),
    Adress varchar(100),
    Birth_date DATE
);
desc clients;
-- criar tabela produto
-- size = dimensões do produto
CREATE TABLE product(
	idProduct int auto_increment primary key,
    Pname varchar(10) not null,
    category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Mobilia') not null,
	productDescription varchar (40) not null,
    productValue float not null,
    avaliation float default 0,
    size varchar(10)
);
desc product;
-- criar tabela pagamento
CREATE TABLE payments(
	idClient int,
    idPayment int,
    typePay enum('Cartão','Dois Cartões'),
    limitAvailable float,
    cardNumber char(16) not null,
    securityCode char(3) not null,
    primary key(idClient, idPayment)
);
desc payments;
-- criar tabela pedido
CREATE TABLE orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    -- idOrderPayment int,
    orderStatus ENUM("Em andamento", "Em Processamento", "Enviado", "Entregue","Cancelado") default 'Em Processamento',
	orderDescription varchar(200),    
    shipment float default 20,
    paymentCash bool default false,    
    constraint fk_order_client foreign key(idOrderClient) references clients(idClient)
			on update cascade
);
desc orders;
-- criar tabela estoque
CREATE TABLE productStorage(
	idProductStorage int auto_increment primary key,
    location varchar(45),
    quantity int default 0
);
desc productStorage;
-- criar tabela fornecedor
CREATE TABLE supplier(
	idSupplier int auto_increment primary key,
    socialName varchar(45) not null,
	CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
desc supplier;
-- criar tabela vendedor
CREATE TABLE seller(
	idSeller int auto_increment primary key,
    socialName varchar(45) not null,
    fantasyName varchar(45),
    CNPJ char(15),
    CPF char(9),
    contact char(11) not null,
    location varchar(45) not null, 
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);
desc seller;
-- criar tabela produto vendedor
CREATE TABLE productSeller(
	idProductSeller int,
    idProduct int,
    prodQuantity int default 1,
    primary key(idProductSeller,idProduct),
    constraint fk_product_seller foreign key(idProductSeller) references seller(idSeller),
    constraint fk_product_product foreign key(idProduct) references product(idProduct)    
);
desc productSeller;
-- criar tabela produto pedido
CREATE TABLE productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível','Indisponível')default 'Disponível',
    primary key(idPOproduct,idPOorder),
    constraint fk_productOrder_seller foreign key(idPOproduct) references product(idProduct),
    constraint fk_productOrder_product foreign key(idPOorder) references orders(idOrder)
);
 desc productOrder;
-- criar tabela Estoque produto
CREATE TABLE storageLocation(
	idSLproduct int,
    idSLstorage int,
    location varchar(200) not null,
    constraint fk_storageLocation_seller foreign key(idSLproduct) references product(idProduct),
    constraint fk_storageLocation_product foreign key(idSLstorage) references productStorage(idProductStorage)    
);
 desc storageLocation;

-- criar tabela fornecedor produto
CREATE TABLE productSupply(
	idPSUproduct int, 
    idPSUsupplier int,
    quantity int not null,
    psuStatus enum('Disponível','Indisponível')default 'Disponível',
    primary key(idPSUproduct,idPSUsupplier),
	constraint fk_product_supplier_supplier foreign key(idPSUproduct) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key(idPSUsupplier) references product(idProduct)
);
 desc productSupply;