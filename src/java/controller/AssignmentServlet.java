package controller;

import java.io.*;
import java.nio.file.*;
import java.sql.*;
import java.time.LocalDate;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;

@MultipartConfig
public class AssignmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int subjectId = Integer.parseInt(request.getParameter("subject_id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String dueDate = request.getParameter("due_date");

        Part filePart = request.getPart("file");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("/") + "uploads";

        Files.createDirectories(Paths.get(uploadPath));
        String fullPath = uploadPath + File.separator + fileName;

        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, Paths.get(fullPath), StandardCopyOption.REPLACE_EXISTING);
        }

        Assignment assignment = new Assignment();
        assignment.setSubjectId(subjectId);
        assignment.setTitle(title);
        assignment.setDescription(description);
        assignment.setUploadDate(LocalDate.now().toString());
        assignment.setDueDate(dueDate);
        assignment.setFilePath("uploads/" + fileName);

        try (Connection conn = DBConnection.getConnection()) {
            AssignmentDAO dao = new AssignmentDAO(conn);
            dao.addAssignment(assignment);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("assignment_list.jsp");
    }
}
