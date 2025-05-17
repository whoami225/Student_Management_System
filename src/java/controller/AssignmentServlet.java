package controller;

import dao.AssignmentDAO;
import model.Assignment;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.sql.Connection;
import java.util.Date;
import java.util.List;

@WebServlet("/assignment")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AssignmentServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads";
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("upload".equals(action)) {
            // Get form data
            int subjectId = Integer.parseInt(request.getParameter("subject_id"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            Date dueDate = new Date(request.getParameter("due_date"));
            
            // Handle file upload
            Part filePart = request.getPart("file");
            String fileName = getFileName(filePart);
            
            // Create upload directory if it doesn't exist
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIR;
            
            File uploadDir = new File(uploadFilePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // Save file
            String filePath = uploadFilePath + File.separator + fileName;
            filePart.write(filePath);
            
            // Save assignment to database
            Assignment assignment = new Assignment();
            assignment.setSubjectId(subjectId);
            assignment.setTitle(title);
            assignment.setDescription(description);
            assignment.setUploadDate(new Date());
            assignment.setDueDate(dueDate);
            assignment.setFilePath(UPLOAD_DIR + "/" + fileName);
            
            Connection connection = (Connection) getServletContext().getAttribute("DBConnection");
            AssignmentDAO assignmentDAO = new AssignmentDAO(connection);
            assignmentDAO.addAssignment(assignment);
            
            response.sendRedirect("assignment_list.jsp");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Connection connection = (Connection) getServletContext().getAttribute("DBConnection");
        AssignmentDAO assignmentDAO = new AssignmentDAO(connection);
        
        String subjectIdParam = request.getParameter("subject_id");
        List<Assignment> assignments;
        
        if (subjectIdParam != null && !subjectIdParam.isEmpty()) {
            int subjectId = Integer.parseInt(subjectIdParam);
            assignments = assignmentDAO.getAssignmentsBySubject(subjectId);
        } else {
            assignments = assignmentDAO.getAllAssignments();
        }
        
        request.setAttribute("assignments", assignments);
        RequestDispatcher dispatcher = request.getRequestDispatcher("assignment_list.jsp");
        dispatcher.forward(request, response);
    }
    
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}