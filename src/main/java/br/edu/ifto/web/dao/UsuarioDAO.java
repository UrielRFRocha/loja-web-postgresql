
package br.edu.ifto.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import br.edu.ifto.web.model.Usuario;

public class UsuarioDAO {

    private final ConnectionFactory connectionFactory =
            new ConnectionFactory();

    public Usuario autenticar(String email, String senha) {

        if (email == null || senha == null) {
            return null;
        }

        String sql = """
            SELECT nome, email
            FROM usuarios
            WHERE LOWER(email) = LOWER(?)
              AND senha = crypt(?, senha)
            """;

        try (Connection conn = connectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email.trim());
            stmt.setString(2, senha);

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {
                    return new Usuario(
                        rs.getString("nome"),
                        rs.getString("email")
                    );
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                "Erro ao autenticar usuário no banco de dados", e
            );
        }

        return null;
    }
}
