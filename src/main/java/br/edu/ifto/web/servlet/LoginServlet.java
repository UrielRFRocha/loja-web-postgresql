package br.edu.ifto.web.servlet;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import br.edu.ifto.web.dao.UsuarioDAO;
import br.edu.ifto.web.model.Usuario;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UsuarioDAO repository = new UsuarioDAO();
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        Usuario usuario = repository.autenticar(req.getParameter("email"), req.getParameter("senha"));
        if (usuario == null) {
            req.setAttribute("erro", "E-mail ou senha inválidos.");
            req.setAttribute("emailInformado", req.getParameter("email"));
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            return;
        }
        HttpSession antiga = req.getSession(false);
        if (antiga != null) antiga.invalidate();
        HttpSession sessao = req.getSession(true);
        sessao.setAttribute("usuarioLogado", usuario);
        resp.sendRedirect(req.getContextPath() + "/");
    }
}
