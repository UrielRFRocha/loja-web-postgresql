
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loja Web - Início</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">
</head>

<body>

    <header class="topo">
        <div class="container topo-conteudo">

            <div>
                <h1>Loja Web</h1>
                <span>Equipamentos de informática</span>
            </div>

            <nav class="menu">
                <a class="ativo"
                   href="${pageContext.request.contextPath}/">
                    Início
                </a>

                <a href="${pageContext.request.contextPath}/produtos">
                    Produtos
                </a>

                <a href="${pageContext.request.contextPath}/carrinho">
                    Carrinho
                </a>
            </nav>

            <div class="usuario-area">

                <c:choose>

                    <c:when test="${not empty sessionScope.usuarioLogado}">

                        <span style="color:#333;">
                            Olá,
                            <c:out value="${sessionScope.usuarioLogado.nome}" />!
                        </span>

                        <form action="${pageContext.request.contextPath}/logout"
                              method="post">

                            <button type="submit"
                                    class="btn btn-secundario">
                                Sair
                            </button>

                        </form>

                    </c:when>

                    <c:otherwise>

                        <a href="${pageContext.request.contextPath}/login"
                           class="btn btn-primario">
                            Entrar
                        </a>

                    </c:otherwise>

                </c:choose>

            </div>

        </div>
    </header>

    <main>

        <section class="hero">
            <div class="container">

                <span class="badge">
                    Tecnologia para você
                </span>

                <h2>
                    Loja de equipamentos de informática
                </h2>

                <p>
                    Encontre os melhores equipamentos e acessórios
                    para seu dia a dia.
                </p>

                <div class="hero-acoes">

                    <a href="${pageContext.request.contextPath}/produtos"
                       class="btn btn-primario">
                        Ver produtos
                    </a>

                    <a href="${pageContext.request.contextPath}/carrinho"
                       class="btn btn-secundario">
                        Meu carrinho
                    </a>

                </div>

            </div>
        </section>

    </main>

    <footer>
        Programação para Web I
    </footer>

</body>
</html>
