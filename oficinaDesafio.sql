-- Criação do banco de dados "Oficina" (caso ainda não exista)
CREATE DATABASE IF NOT EXISTS Oficina;
USE Oficina;

-- Criação da tabela Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nomeCompleto VARCHAR(100) NOT NULL,
    CPF CHAR(11) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(200)
);

-- Criação da tabela Veículos
CREATE TABLE IF NOT EXISTS Veiculos (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    ano INT,
    placa VARCHAR(10) NOT NULL,
    quilometragem INT,
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Criação da tabela Serviços
CREATE TABLE IF NOT EXISTS Servicos (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    idVeiculo INT NOT NULL,
    descricao VARCHAR(200),
    dataServico DATE,
    custo DECIMAL(10, 2),
    FOREIGN KEY (idVeiculo) REFERENCES Veiculos(idVeiculo) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Preenchendo a tabela Clientes
INSERT INTO Clientes (nomeCompleto, CPF, telefone, email, endereco) VALUES
    ('João da Silva', '11122233344', '111234-5678', 'joao.silva@example.com', 'Rua das Flores, 123 - Bairro A'),
    ('Maria Oliveira', '44455566677', '229876-5432', 'maria.oliveira@example.com', 'Avenida das Árvores, 456 - Bairro B'),
    ('Pedro Santos', '77788899900', '335555-4444', 'pedro.santos@example.com', 'Travessa das Pedras, 789 - Bairro C'),
    ('Ana Costa', '11144477700', '443333-2222', 'ana.costa@example.com', 'Praça Central, 987 - Bairro D'),
    ('Luiz Pereira', '22255588811', '556666-1111', 'luiz.pereira@example.com', 'Alameda dos Lagos, 654 - Bairro E');
    SELECT * FROM Clientes;

-- Preenchendo a tabela Veículos
INSERT INTO Veiculos (idCliente, marca, modelo, ano, placa, quilometragem) VALUES
    (1, 'Toyota', 'Corolla', 2020, 'ABC-1234', 25000),
    (1, 'Honda', 'Civic', 2018, 'DEF-5678', 35000),
    (2, 'Volkswagen', 'Gol', 2019, 'GHI-9012', 18000),
    (3, 'Ford', 'Ka', 2021, 'JKL-3456', 10000),
    (4, 'Chevrolet', 'Onix', 2017, 'MNO-7890', 50000);
        SELECT * FROM Veiculos;


-- Preenchendo a tabela Serviços
INSERT INTO Servicos (idVeiculo, descricao, dataServico, custo) VALUES
    (1, 'Troca de óleo e filtros', '2023-07-10', 150.00),
    (2, 'Alinhamento e balanceamento', '2023-07-15', 200.00),
    (3, 'Revisão completa', '2023-07-05', 350.00),
    (4, 'Troca de pneus', '2023-07-08', 600.00),
    (5, 'Manutenção elétrica', '2023-07-12', 180.00);
    SELECT* FROM Servicos;

-- Descobrir quantos carros mandados para a oficina são de modelos antes de 2020, ordenados de forma decrescente quanto a quilometragem rodada.
SELECT * FROM Veiculos WHERE ano < 2020
ORDER BY quilometragem DESC;

-- Consulta utilizando JOIN e HAVING para filtrar veículos e clientes, verificando clientes com veiculos com mais de 20.000km rodados que fizeram algum serviço na oficina.
SELECT c.idCliente, c.nomeCompleto, c.CPF, c.telefone, v.marca, v.modelo, v.ano, v.placa, v.quilometragem
FROM Clientes c
JOIN Veiculos v ON c.idCliente = v.idCliente
JOIN Servicos s ON v.idVeiculo = s.idVeiculo
HAVING v.quilometragem > 20000;

-- Consulta para calcular a quilometragem média dos veículos
SELECT AVG(quilometragem) AS quilometragem_media FROM Veiculos;

-- Consulta para calcular o preço médio dos serviços
SELECT AVG(custo) AS preco_medio FROM Servicos;

-- Consulta para calcular o faturamento diário serviços
SELECT SUM(custo) AS faturamento_diario FROM Servicos;