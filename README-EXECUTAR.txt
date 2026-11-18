LOJA WEB - ATIVIDADE PRATICA COM BANCO DE DADOS

Esta e a evolucao da Loja Web anterior: mantem produtos, carrinho, login com HttpSession e estilo original. Agora utiliza PostgreSQL e JDBC para armazenar e consultar usuarios e produtos.

1. Abra ESTA pasta no VS Code (a pasta que contem pom.xml).
2. Abra o terminal PowerShell nesta pasta.
3. Execute: mvn clean package
4. Execute: docker compose up --build -d
5. Aguarde 10 a 20 segundos. Abra: http://localhost:8082/loja-web-sessao/
6. Login: http://localhost:8082/loja-web-sessao/login
7. Produtos: http://localhost:8082/loja-web-sessao/produtos

Usuarios de teste:
Uriel Ribeiro: uriel@ifto.com / ifto
Aline Matos: aline@fasec.com / fasec

Banco de dados:
PostgreSQL 16, configurado no compose.yaml.
O banco e iniciado automaticamente pelo Docker Compose.
O arquivo database/init.sql cria as tabelas usuarios e produtos e cadastra os dados iniciais na primeira inicializacao de um banco novo.
Nao e necessario instalar ou configurar o PostgreSQL manualmente.

Se a porta 8082 estiver ocupada, execute docker ps e verifique qual container esta utilizando essa porta. Alternativamente, altere 8082:8080 no compose.yaml para outra porta disponivel.

Para atualizar o projeto: mvn clean package e docker compose up --build -d.
Para encerrar: docker compose down.

Fluxo da atividade:
GET /login -> LoginServlet -> forward login.jsp
POST /login -> UsuarioDAO -> consulta PostgreSQL -> credenciais invalidas: erro na JSP; validas: HttpSession usuarioLogado e redirect para /
POST /logout -> invalida HttpSession -> redirect /
GET /produtos -> ProdutoServlet -> ProdutoDAO -> consulta produtos no PostgreSQL -> forward produtos.jsp
POST /carrinho/itens -> CarrinhoItemServlet -> ProdutoDAO -> busca produto no PostgreSQL e adiciona ao carrinho da HttpSession
GET /carrinho -> CarrinhoServlet -> exibe os produtos do carrinho
DELETE /carrinho/itens -> remove o produto do carrinho
index.jsp usa sessionScope.usuarioLogado.nome via EL e JSTL sem scriptlets.

ATENCAO: nao acesse localhost:8080; esta aplicacao utiliza a porta 8082.