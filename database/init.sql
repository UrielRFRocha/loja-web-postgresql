-- Banco de dados da Loja Web
-- Programação para Web I

-- Habilitar criptografia de senhas
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Tabela de usuários
CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL
);

-- Tabela de produtos
CREATE TABLE IF NOT EXISTS produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    preco NUMERIC(10,2) NOT NULL CHECK (preco >= 0)
);

-- Cadastrar usuários iniciais
INSERT INTO usuarios (nome, email, senha)
VALUES
('Uriel Ribeiro', 'uriel@ifto.com', crypt('ifto', gen_salt('bf'))),
('Aline Matos', 'aline@fasec.com', crypt('fasec', gen_salt('bf')))
ON CONFLICT (email) DO NOTHING;

-- Cadastrar produtos iniciais
INSERT INTO produtos (id, nome, descricao, preco)
VALUES
(1, 'Notebook', 'Notebook para trabalho e estudos.', 3500.00),
(2, 'Mouse', 'Mouse optico USB.', 80.00),
(3, 'Teclado Mecânico', 'Teclado mecanico para produtividade.', 250.00),
(4, 'Monitor', 'Monitor para estacao de trabalho.', 1200.00),
(5, 'Headset', 'Headset para aulas e reunioes.', 180.00)
ON CONFLICT (id) DO NOTHING;

-- Ajustar a sequência dos IDs
SELECT setval(
    pg_get_serial_sequence('produtos', 'id'),
    (SELECT MAX(id) FROM produtos)
);
