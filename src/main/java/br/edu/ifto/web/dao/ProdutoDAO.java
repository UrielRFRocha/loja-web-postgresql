
package br.edu.ifto.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.edu.ifto.web.model.Produto;

public class ProdutoDAO {

    private final ConnectionFactory connectionFactory =
            new ConnectionFactory();

    public List<Produto> listarTodos() {

        List<Produto> produtos = new ArrayList<>();

        String sql = "SELECT id, nome, descricao, preco FROM produtos ORDER BY id";

        try (Connection conn = connectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Produto produto = new Produto(
                    rs.getInt("id"),
                    rs.getString("nome"),
                    rs.getString("descricao"),
                    rs.getDouble("preco")
                );

                produtos.add(produto);
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                "Erro ao listar produtos do banco de dados", e
            );
        }

        return produtos;
    }

    public Produto buscarPorId(int id) {

        String sql = "SELECT id, nome, descricao, preco FROM produtos WHERE id = ?";

        try (Connection conn = connectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {

                if (rs.next()) {
                    return new Produto(
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("descricao"),
                        rs.getDouble("preco")
                    );
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                "Erro ao buscar produto no banco de dados", e
            );
        }

        return null;
    }
}
