
package br.edu.ifto.web.servlet;

import java.io.IOException;
import java.util.Collections;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.edu.ifto.web.model.ItemCarrinho;

@WebServlet("/carrinho")
public class CarrinhoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        Map<Integer, ItemCarrinho> carrinho = Collections.emptyMap();

        if (session != null) {
            synchronized (session) {
                @SuppressWarnings("unchecked")
                Map<Integer, ItemCarrinho> salvo =
                        (Map<Integer, ItemCarrinho>) session.getAttribute("carrinho");

                if (salvo != null) {
                    carrinho = new java.util.LinkedHashMap<>(salvo);
                }
            }
        }

        int quantidadeTotal = 0;
        double valorTotal = 0;

        for (ItemCarrinho item : carrinho.values()) {
            quantidadeTotal += item.getQuantidade();
            valorTotal += item.getSubtotal();
        }

        request.setAttribute("itens", carrinho.values());
        request.setAttribute("quantidadeTotal", quantidadeTotal);
        request.setAttribute("valorTotal", valorTotal);

        request.getRequestDispatcher("/WEB-INF/views/carrinho.jsp")
                .forward(request, response);
    }

    @Override
    protected void doDelete(HttpServletRequest request,
                            HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if (session != null) {
            synchronized (session) {
                session.removeAttribute("carrinho");
            }
        }

        response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    }
}
