
package br.edu.ifto.web.servlet;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.edu.ifto.web.dao.ProdutoDAO;
import br.edu.ifto.web.model.ItemCarrinho;
import br.edu.ifto.web.model.Produto;

@WebServlet("/carrinho/itens")
public class CarrinhoItemServlet extends HttpServlet {

    private final ProdutoDAO repository =
            new ProdutoDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        String idTexto = request.getParameter("id");
        int id;

        try {
            id = Integer.parseInt(idTexto);
        } catch (NumberFormatException e) {
            response.sendError(400, "ID do produto invalido.");
            return;
        }

        Produto produto = repository.buscarPorId(id);

        if (produto == null) {
            response.sendError(404, "Produto nao encontrado.");
            return;
        }

        HttpSession session = request.getSession();

        synchronized (session) {
            @SuppressWarnings("unchecked")
            Map<Integer, ItemCarrinho> carrinho =
                    (Map<Integer, ItemCarrinho>) session.getAttribute("carrinho");

            if (carrinho == null) {
                carrinho = new LinkedHashMap<>();
                session.setAttribute("carrinho", carrinho);
            }

            if (carrinho.containsKey(id)) {
                carrinho.get(id).aumentarQuantidade();
            } else {
                carrinho.put(id, new ItemCarrinho(produto, 1));
            }
        }

        response.sendRedirect(request.getContextPath() + "/carrinho");
    }

    @Override
    protected void doDelete(HttpServletRequest request,
                            HttpServletResponse response)
            throws IOException {

        int id;

        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.sendError(400, "ID invalido.");
            return;
        }

        HttpSession session = request.getSession(false);

        if (session != null) {
            synchronized (session) {
                @SuppressWarnings("unchecked")
                Map<Integer, ItemCarrinho> carrinho =
                        (Map<Integer, ItemCarrinho>) session.getAttribute("carrinho");

                if (carrinho != null) {
                    carrinho.remove(id);
                }
            }
        }

        response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    }
}
