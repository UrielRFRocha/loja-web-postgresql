
package br.edu.ifto.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.edu.ifto.web.dao.ProdutoDAO;

@WebServlet("/produtos")
public class ProdutoServlet extends HttpServlet {

    private final ProdutoDAO repository =
            new ProdutoDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("produtos", repository.listarTodos());

        HttpSession session = request.getSession(false);
        int quantidade = 0;

        if (session != null) {
            java.util.Map<?, ?> carrinho =
                    (java.util.Map<?, ?>) session.getAttribute("carrinho");

            if (carrinho != null) {
                for (Object item : carrinho.values()) {
                    quantidade += ((br.edu.ifto.web.model.ItemCarrinho) item)
                            .getQuantidade();
                }
            }
        }

        request.setAttribute("quantidadeTotal", quantidade);

        request.getRequestDispatcher("/WEB-INF/views/produtos.jsp")
                .forward(request, response);
    }
}
