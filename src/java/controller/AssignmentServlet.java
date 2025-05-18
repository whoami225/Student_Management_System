package controller;

import dao.AssignmentDAO;
import model.Assignment;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/assignment")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 10)
public class AssignmentServlet extends HttpServlet {

    private AssignmentDAO assignmentDAO;

    @Override
    public void init() throws ServletException {
        assignmentDAO = new AssignmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Assignment> assignments = assignmentDAO.getAllAssignments();
            request.setAttribute("assignmentList", assignments);
            request.getRequestDispatcher("assignment_list.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Failed to load assignments: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int subjectId = Integer.parseInt(request.getParameter("subject_id"));
            Date uploadDate = new Date();
            Date dueDate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("due_date"));

            Part filePart = request.getPart("file");
            String fileName = new File(filePart.getSubmittedFileName()).getName();

            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            Assignment assignment = new Assignment(0, subjectId, title, description, uploadDate, dueDate, "uploads/" + fileName);
            assignmentDAO.addAssignment(assignment);

            response.sendRedirect(request.getContextPath() + "/assignment");

        } catch (Exception e) {
            request.setAttribute("error", "Failed to upload assignment: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
