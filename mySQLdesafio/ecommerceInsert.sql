use ecommerce;
show tables;

INSERT INTO Clients(Fname,Minit,Lname,CPF,Adress,Birth_date)
  values('Maria','M','Silva',123456789,'Rua Silva de Prata 29,Carangola - Cidade das Flores','1999-10-15'),
		('Matheus','O','Pimentel',987654321,'Rua Alameda 289, Centro - Cidade das Flores','1996-10-14'),
        ('Ricardo','F','Silva',456789123,'Avenida Alameda Vinha 1009, Centro - Cidade das Flores','1982-03-27'),
        ('Julia','S','França',789123456,'Rua Laranjeiras 861, Centro - Cidade das Flores','2000-04-09'),
        ('Roberta','G','Assis',345678912,'Avenida Koller 19, Centro - Cidade das Flores','1989-06-23'),
        ('Isabela','M','Cruz',234567891,'Rua Alameda das Flores 28, Centro - Cidade das Flores','2001-07-02');
SELECT * FROM Clients;

INSERT INTO product(Pname,category,productDescription,productValue,avaliation,size)
	values('Notebook','Eletrônico','Computador portatil',3500.00,4.8,null),
		('Headphone','Eletrônico','Aparelho para ouvir som',500.00,4.3,null),
        ('Cadeira','Mobilia','Macia e confortável',1250.00,3.8,null),
        ('Tenis','Vestimenta','Tenis casual Balenciaga',2000.00,5,null),
        ('Iphone 15','Eletrônico','Telefone celular de ultima geração',9500.00,4.9,null),
        ('Nike Tech','Vestimenta','Conjunto nike esportivo',3500.00,4.6,null);
SELECT * FROM product;

-- delete from orders where idOrderClient in (1,2,3,4,5,6);
INSERT INTO orders(idOrderClient,orderStatus,orderDescription,shipment,paymentCash) values
			(1,default,'compra via aplicativo',null,1),
            (2,'Entregue',null,50,0),
            (3,default,'compra via aplicativo',13,0),
            (4,'Entregue',null,17,1),
            (5,default,'compra via website',12.5,1),
            (6,'Entregue',null,8.80,0);
            SELECT * FROM orders;

INSERT INTO productOrder(idPOproduct,idPOorder,poQuantity,poStatus) values
			(8,13,1,'Indisponível'),
            (7,14,1,default),
            (9,14,2,'Disponível'),
            (11,16,1,default),
            (10,17,1,'Indisponível'),
            (12,18,1,default);        
SELECT * FROM productOrder;

INSERT INTO productStorage (location,quantity) values
		('Rio de Janeiro',1500),
        ('Minas Gerais',100),
        ('Santos',150),
        ('Guarulhos',10),
        ('Rio de Janeiro',500),
        ('São Paulo',12500);        
SELECT * FROM productStorage;

INSERT INTO storageLocation(idSLproduct,idSLstorage,location) values
			(8,2,'RJ'),
            (9,1,'MG'),
            (10,4,'SAN'),
            (11,3,'GUA'),
            (12,5,'RJ'),
            (7,6,'SP');
SELECT * FROM storageLocation;

INSERT INTO supplier(socialName,CNPJ,contact) values
		('Cleiton Souza',54321987000176,1234567890),
        ('Neymar Jr.',98765432000121,9876543210),
        ('Julia Roberts',12345678000190,5556667777);
SELECT * FROM supplier;

INSERT INTO productSupply(idPSUproduct,idPSUsupplier,quantity,psuStatus) values
			(1,8,100,'Indisponível'),
            (2,9,50,'Disponível'),
            (1,10,300,'Indisponível'),
            (3,11,200,default);
SELECT * FROM productSupply;

INSERT INTO seller (socialName, fantasyName, CNPJ, CPF, contact, location) VALUES
('ABC Retailers', 'ABC Stores', '12345678000190', null, '98765432100', 'Street A, City X'),
('XYZ Electronics', 'XYZ Gadgets', '98765432000121', null, '87654321099', 'Road B, City Y'),
('Best Books', 'Book Haven', '75123456000134', null, '78945612311', 'Avenue C, City Z'),
('Fashion Central',null, '52369741000165', null, '65478932100', 'Lane D, City W'),
('Healthy Living', null, '11222333000144', '987654321', '98765432122', 'Square E, City V'),
('Green Grocers', 'Organic Farms', '45678901000123', null, '12345678900', 'Garden F, City U');
SELECT * FROM seller;

INSERT INTO productSeller(idProductSeller,idProduct,prodQuantity) VALUES
	(1,7,70),
	(2,8,170),
	(3,9,7),
	(3,11,50);    
SELECT * FROM productSeller;

-- simples where statement para filtrar os locais de estoque no Rio de Janeiro.
SELECT * FROM storageLocation where location = 'RJ';

-- Usando having e order by para organizar clientes que nasceram depois de 1995.
SELECT Fname, Minit, Lname, CPF, Adress, Birth_date
FROM Clients
HAVING YEAR(Birth_date) > 1995
ORDER BY Lname, Fname;

-- Recuperando dados onde o vendedor possui nome fantasia e possui mais de 50 produtos.
SELECT s.idSeller, s.socialName, s.fantasyName, s.CNPJ, s.CPF, s.contact, s.location,
       ps.idProductSeller, ps.idProduct, ps.prodQuantity
FROM seller s
INNER JOIN productSeller ps ON s.idSeller = ps.idProductSeller
WHERE s.fantasyName IS NOT NULL AND ps.prodQuantity > 50;