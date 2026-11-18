
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="pt_BR" />

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Produtos - Loja Web</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<header class="topo">
    <div class="container topo-conteudo">
        <div>
            <h1>Loja Web</h1>
        </div>

        <nav class="menu">
            <a href="${pageContext.request.contextPath}/">Início</a>

            <a class="ativo"
               href="${pageContext.request.contextPath}/produtos">
                Produtos
            </a>

            <a href="${pageContext.request.contextPath}/carrinho">
                Carrinho
                <span class="contador">${quantidadeTotal}</span>
            </a>
        </nav>

        <!-- Usuário autenticado ou botão Entrar -->
        <div class="usuario-logado">
            <c:choose>
                <c:when test="${not empty sessionScope.usuarioLogado}">
                    <span>
                        Olá,
                        <c:out value="${sessionScope.usuarioLogado.nome}" />!
                    </span>

                    <form action="${pageContext.request.contextPath}/logout"
                          method="post">
                        <button type="submit" class="btn btn-contorno">
                            Sair
                        </button>
                    </form>
                </c:when>

                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login"
                       class="btn btn-contorno">
                        Entrar
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<main class="container secao">

    <div class="titulo-pagina">
        <div>
            <h2>Produtos</h2>
            <p>Escolha seus produtos e adicione ao carrinho.</p>
        </div>
    </div>

    <div class="grade-produtos">

        <c:forEach var="produto" items="${produtos}">

            <article class="produto-card">

                <div class="produto-icone">🛍️</div>

                <h3>
                    <c:out value="${produto.nome}" />
                </h3>

                <p class="produto-descricao">
                    <c:out value="${produto.descricao}" />
                </p>

                <strong class="preco">
                    <fmt:formatNumber
                        value="${produto.preco}"
                        type="currency"
                        currencySymbol="R$" />
                </strong>

                <form action="${pageContext.request.contextPath}/carrinho/itens"
                      method="post">

                    <input type="hidden"
                           name="id"
                           value="${produto.id}">

                    <button class="btn btn-primario btn-bloco"
                            type="submit">
                        Adicionar ao carrinho
                    </button>

                </form>

            </article>

        </c:forEach>

    </div>

</main>

<footer>
    <div class="container">
        Programação para Web I
    </div>
</footer>

</body>
</html>
