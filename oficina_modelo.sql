-- Criação do banco de dados Oficina
CREATE DATABASE Oficina;
USE Oficina;

-- Tabela Cliente
CREATE TABLE Cliente (
    id INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(150),
    Telefone VARCHAR(20),
    Email VARCHAR(100),
    CPF_CNPJ VARCHAR(20) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela Veículo
CREATE TABLE Veiculo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    Placa VARCHAR(10) UNIQUE NOT NULL,
    Modelo VARCHAR(50),
    Ano INT, -- O campo "Ano" não tem mais o CHECK com CURDATE(), a validação deve ser feita no sistema ou com TRIGGERS
    Tipo VARCHAR(20),
    Cor VARCHAR(20),
    Cliente_id INT NOT NULL,
    FOREIGN KEY (Cliente_id) REFERENCES Cliente(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela Mecânico
CREATE TABLE Mecanico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(150),
    Telefone VARCHAR(20),
    Especializacao VARCHAR(100),
    CPF VARCHAR(14) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Telefone VARCHAR(20),
    Email VARCHAR(100),
    Endereco VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela Peça
CREATE TABLE Peca (
    id INT PRIMARY KEY AUTO_INCREMENT,
    Descricao VARCHAR(100) NOT NULL,
    Valor FLOAT NOT NULL, -- Removido o CHECK para evitar problemas, a validação pode ser feita no sistema
    Quantidade INT NOT NULL, -- Removido o CHECK para evitar problemas, a validação pode ser feita no sistema
    Fornecedor_id INT,
    FOREIGN KEY (Fornecedor_id) REFERENCES Fornecedor(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela Ordem de Serviço
CREATE TABLE OrdemDeServico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    Numero VARCHAR(20) UNIQUE NOT NULL,
    DataEmissao DATE NOT NULL,
    DataConclusao DATE,
    ValorTotal FLOAT, -- Removido o CHECK para evitar problemas, a validação pode ser feita no sistema
    Status ENUM('Pendente', 'Em Andamento', 'Concluído', 'Cancelado') NOT NULL,
    Observacoes TEXT,
    Cliente_id INT NOT NULL,
    Veiculo_id INT NOT NULL,
    Mecanico_id INT NOT NULL,
    FOREIGN KEY (Cliente_id) REFERENCES Cliente(id),
    FOREIGN KEY (Veiculo_id) REFERENCES Veiculo(id),
    FOREIGN KEY (Mecanico_id) REFERENCES Mecanico(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    OrdemDeServico_id INT NOT NULL,
    MetodoPagamento ENUM('Dinheiro', 'Cartão de Crédito', 'Cartão de Débito', 'Pix', 'Transferência') NOT NULL,
    ValorPago FLOAT, -- Removido o CHECK para evitar problemas, a validação pode ser feita no sistema
    DataPagamento DATE NOT NULL,
    FOREIGN KEY (OrdemDeServico_id) REFERENCES OrdemDeServico(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela de Relação entre Ordem de Serviço e Peça
CREATE TABLE OrdemDeServico_Peca (
    id INT PRIMARY KEY AUTO_INCREMENT,
    OrdemDeServico_id INT NOT NULL,
    Peca_id INT NOT NULL,
    Quantidade INT NOT NULL, -- Removido o CHECK para evitar problemas, a validação pode ser feita no sistema
    FOREIGN KEY (OrdemDeServico_id) REFERENCES OrdemDeServico(id),
    FOREIGN KEY (Peca_id) REFERENCES Peca(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);



-- Inserindo dados na tabela Cliente
INSERT INTO Cliente (Nome, Endereco, Telefone, Email, CPF_CNPJ) VALUES
('João Silva', 'Rua A, 123', '123456789', 'joao@gmail.com', '12345678901'),
('Maria Oliveira', 'Rua B, 456', '987654321', 'maria@gmail.com', '98765432109');

-- Inserindo dados na tabela Veículo
INSERT INTO Veiculo (Placa, Modelo, Ano, Tipo, Cor, Cliente_id) VALUES
('ABC1234', 'Gol', 2020, 'Carro', 'Vermelho', 1),
('XYZ5678', 'Civic', 2019, 'Carro', 'Preto', 2);

-- Inserindo dados na tabela Mecânico
INSERT INTO Mecanico (Nome, Endereco, Telefone, Especializacao, CPF) VALUES
('Carlos Souza', 'Rua C, 789', '987654321', 'Motores', '12398765432'),
('Ana Paula', 'Rua D, 321', '123456789', 'Elétrica', '45678912345');

-- Inserindo dados na tabela Fornecedor
INSERT INTO Fornecedor (Nome, Telefone, Email, Endereco) VALUES
('Auto Peças Brasil', '333333333', 'contato@autopecas.com', 'Rua Peças, 100'),
('Peças Premium', '444444444', 'vendas@pecaspremium.com', 'Avenida Principal, 200');

-- Inserindo dados na tabela Peça
INSERT INTO Peca (Descricao, Valor, Quantidade, Fornecedor_id) VALUES
('Filtro de óleo', 50.00, 20, 1),
('Correia dentada', 150.00, 15, 2);

-- Inserindo dados na tabela Ordem de Serviço
INSERT INTO OrdemDeServico (Numero, DataEmissao, DataConclusao, ValorTotal, Status, Observacoes, Cliente_id, Veiculo_id, Mecanico_id) VALUES
('OS001', '2023-12-01', '2023-12-02', 300.00, 'Concluído', 'Troca de óleo e correia', 1, 1, 1),
('OS002', '2023-12-03', NULL, 200.00, 'Pendente', 'Revisão elétrica', 2, 2, 2);

-- Inserindo dados na tabela Pagamento
INSERT INTO Pagamento (OrdemDeServico_id, MetodoPagamento, ValorPago, DataPagamento) VALUES
(1, 'Pix', 300.00, '2023-12-02');

-- Inserindo dados na tabela OrdemDeServico_Peca
INSERT INTO OrdemDeServico_Peca (OrdemDeServico_id, Peca_id, Quantidade) VALUES
(1, 1, 2), -- Usou 2 filtros de óleo na OS001
(1, 2, 1); -- Usou 1 correia dentada na OS001



#Recuperações Simples com SELECT Statement
#Exibir todos os clientes cadastrados:





-- Recuperações Simples com SELECT Statement
-- 1. Exibir todos os clientes cadastrados
SELECT * 
FROM Cliente;

-- 2. Exibir os veículos com os respectivos clientes
SELECT Veiculo.Placa, Veiculo.Modelo, Cliente.Nome AS Cliente
FROM Veiculo
JOIN Cliente ON Veiculo.Cliente_id = Cliente.id;

-- Filtros com WHERE Statement
-- 3. Listar as ordens de serviço que estão pendentes
SELECT * 
FROM OrdemDeServico
WHERE Status = 'Pendente';

-- 4. Listar peças cujo valor seja maior que 100
SELECT * 
FROM Peca
WHERE Valor > 100;

-- Atributos Derivados
-- 5. Calcular o valor total com impostos (10%) para todas as ordens de serviço
SELECT id, Numero, ValorTotal, ValorTotal * 1.1 AS ValorComImposto 
FROM OrdemDeServico;

-- 6. Exibir o custo total de peças utilizadas em uma ordem de serviço
SELECT os.Numero AS OrdemDeServico, 
       SUM(p.Valor * osp.Quantidade) AS CustoTotalPecas
FROM OrdemDeServico_Peca osp
JOIN OrdemDeServico os ON osp.OrdemDeServico_id = os.id
JOIN Peca p ON osp.Peca_id = p.id
WHERE os.id = 1
GROUP BY os.Numero;

-- Ordenações com ORDER BY Statement
-- 7. Listar mecânicos ordenados pelo nome
SELECT * 
FROM Mecanico
ORDER BY Nome;

-- 8. Listar peças em ordem decrescente de valor
SELECT * 
FROM Peca
ORDER BY Valor DESC;

-- Condições de Filtros aos Grupos – HAVING Statement
-- 9. Exibir clientes que possuem mais de um veículo
SELECT Cliente_id, COUNT(*) AS TotalVeiculos
FROM Veiculo
GROUP BY Cliente_id
HAVING COUNT(*) > 1;

-- 10. Exibir fornecedores com mais de 10 itens em estoque
SELECT Fornecedor_id, SUM(Quantidade) AS TotalItens
FROM Peca
GROUP BY Fornecedor_id
HAVING SUM(Quantidade) > 10;

-- Junções entre Tabelas
-- 11. Exibir as ordens de serviço com detalhes do cliente, veículo e mecânico
SELECT os.Numero AS OrdemDeServico, 
       c.Nome AS Cliente, 
       v.Modelo AS Veiculo, 
       m.Nome AS Mecanico, 
       os.Status, 
       os.ValorTotal
FROM OrdemDeServico os
JOIN Cliente c ON os.Cliente_id = c.id
JOIN Veiculo v ON os.Veiculo_id = v.id
JOIN Mecanico m ON os.Mecanico_id = m.id;

-- 12. Exibir todas as peças usadas em uma ordem de serviço, com descrição e custo
SELECT os.Numero AS OrdemDeServico, 
       p.Descricao AS Peca, 
       osp.Quantidade, 
       p.Valor AS CustoUnitario, 
       (p.Valor * osp.Quantidade) AS CustoTotal
FROM OrdemDeServico_Peca osp
JOIN OrdemDeServico os ON osp.OrdemDeServico_id = os.id
JOIN Peca p ON osp.Peca_id = p.id;
