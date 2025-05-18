package dao;

import model.Batch;
import controller.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BatchDAO {

    public boolean createBatch(Batch batch) throws ClassNotFoundException {
        String sql = "INSERT INTO batches (batch_name, academic_year) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, batch.getBatchName());
            ps.setString(2, batch.getAcademicYear());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Batch> getAllBatches() throws ClassNotFoundException {
        List<Batch> batches = new ArrayList<>();
        String sql = "SELECT * FROM batches";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                batches.add(new Batch(
                    rs.getInt("batch_id"),
                    rs.getString("batch_name"),
                    rs.getString("academic_year")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return batches;
    }
}
