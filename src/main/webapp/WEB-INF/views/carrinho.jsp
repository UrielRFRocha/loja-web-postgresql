
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="pt_BR" />

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrinho - Loja Web</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<header class="topo">
    <div class="container topo-conteudo">
        <h1>Loja Web</h1>
        <nav class="menu">
            <a href="${pageContext.request.contextPath}/index.jsp">Início</a>
            <a href="${pageContext.request.contextPath}/produtos">Produtos</a>
            <a class="ativo" href="${pageContext.request.contextPath}/carrinho">
                Carrinho <span class="contador">${quantidadeTotal}</span>
            </a>
        </nav>
    </div>
</header>

<main class="container secao">
    <div class="titulo-pagina">
        <div>
            <h2>Meu carrinho</h2>
            <p>Confira os produtos adicionados à sua compra.</p>
        </div>
    </div>

    <div class="carrinho-layout">
        <section class="carrinho-produtos">

            <c:choose>
                <c:when test="${empty itens}">
                    <div class="aviso">
                        Seu carrinho está vazio.
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="item" items="${itens}">
                        <article class="item-carrinho">
                            <div class="item-icone">🛒</div>

                            <div class="item-info">
                                <h3><c:out value="${item.produto.nome}" /></h3>
                                <span>
                                    <fmt:formatNumber
                                        value="${item.produto.preco}"
                                        type="currency"
                                        currencySymbol="R$" />
                                </span>
                            </div>

                            <div class="quantidade">
                                <span>Quantidade</span>
                                <strong>${item.quantidade}</strong>
                            </div>

                            <div class="subtotal">
                                <span>Subtotal</span>
                                <strong>
                                    <fmt:formatNumber
                                        value="${item.subtotal}"
                                        type="currency"
                                        currencySymbol="R$" />
                                </strong>
                            </div>

                            <button class="btn-remover"
                                    type="button"
                                    data-id="${item.produto.id}">
                                Remover
                            </button>
                        </article>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </section>

        <aside class="resumo">
            <h3>Resumo do pedido</h3>

            <div class="resumo-linha">
                <span>Itens</span>
                <strong>${quantidadeTotal}</strong>
            </div>

            <div class="resumo-linha total">
                <span>Total</span>
                <strong>
                    <fmt:formatNumber value="${valorTotal}"
                                      type="currency"
                                      currencySymbol="R$" />
                </strong>
            </div>

            <a class="btn btn-secundario btn-bloco"
               href="${pageContext.request.contextPath}/produtos">
                Continuar comprando
            </a>

            <button id="limparCarrinho"
                    class="btn btn-perigo btn-bloco"
                    type="button">
                Limpar carrinho
            </button>
        </aside>
    </div>
</main>

<footer>
    <div class="container">Programação para Web I</div>
</footer>

<script>
    const contexto = '${pageContext.request.contextPath}';

    document.querySelectorAll('.btn-remover').forEach(botao => {
        botao.addEventListener('click', async () => {
            const id = botao.dataset.id;

            try {
                const resposta = await fetch(
                    contexto + '/carrinho/itens?id=' + encodeURIComponent(id),
                    { method: 'DELETE' }
                );

                if (!resposta.ok) {
                    throw new Error('Falha ao remover produto');
                }

                window.location.reload();
            } catch (erro) {
                alert('Não foi possível remover o produto.');
            }
        });
    });

    document.getElementById('limparCarrinho').addEventListener('click', async () => {
        try {
            const resposta = await fetch(contexto + '/carrinho', {
                method: 'DELETE'
            });

            if (!resposta.ok) {
                throw new Error('Falha ao limpar carrinho');
            }

            window.location.reload();
        } catch (erro) {
            alert('Não foi possível limpar o carrinho.');
        }
    });
</script>
</body>
</html>
