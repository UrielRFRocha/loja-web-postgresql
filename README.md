# Loja Web — Atividade prática com banco de dados

Projeto da disciplina de Programação para Web I, desenvolvido a partir da Loja Web disponibilizada pelo professor.

## Objetivo

Implementar uma pequena loja Web utilizando Java EE 8, Servlets, HttpSession, JSP, EL/JSTL, JDBC e PostgreSQL, com endpoints orientados a recursos.

## Implementação

O projeto mantém a estrutura e o estilo visual da Loja Web original.

Os usuários e produtos são armazenados no PostgreSQL e consultados por meio das classes `UsuarioDAO` e `ProdutoDAO`.

A aplicação utiliza Docker Compose para iniciar o Tomcat e o PostgreSQL. O arquivo `database/init.sql` prepara as tabelas e os registros iniciais em um banco novo.

O carrinho de compras continua armazenado na HttpSession.

## Endpoints

- GET `/produtos`
- GET `/carrinho`
- POST `/carrinho/itens`
- DELETE `/carrinho/itens?id={id}`
- DELETE `/carrinho`
- GET `/login`
- POST `/login`
- POST `/logout`

## Restrições

- O carrinho é mantido em `HttpSession`.
- O atributo da sessão se chama `carrinho`.
- As páginas JSP utilizam EL/JSTL, sem Scriptlets.
- Não são utilizadas variáveis `static` para armazenar carrinhos.
- Identificadores específicos são enviados por query string quando aplicável.

## Banco de dados

- PostgreSQL 16
- JDBC para conexão e consultas
- Tabela `usuarios` para autenticação
- Tabela `produtos` para listagem e busca de produtos
- Arquivo `database/init.sql` para inicialização do banco

## Execução

Na pasta principal do projeto, execute:

```bash
mvn clean package
docker compose up --build -d
```

Acesse:

http://localhost:8082/loja-web-sessao/

Para encerrar:

```bash
docker compose down
```

As instruções completas e os usuários de teste estão disponíveis no arquivo `README-EXECUTAR.txt`.