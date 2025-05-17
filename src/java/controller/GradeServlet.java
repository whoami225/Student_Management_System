package controller;

import dao.GradeDAO;
import model.Grade;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.List;

public class GradeServlet extends HttpServlet {
    private GradeDAO gradeDAO;

    public void init() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Ensure JDBC driver is loaded
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/yourdb", "user", "pass"
            );
            gradeDAO = new GradeDAO(conn);
        } catch (Exception e) {
            throw new RuntimeException("Database connection initialization failed", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            int studentId = Integer.parseInt(request.getParameter("studentId"));
            int subjectId = Integer.parseInt(request.getParameter("subjectId"));
            double marks = Double.parseDouble(request.getParameter("marks"));
            String grade = request.getParameter("grade");

            Grade g = new Grade();
            g.setStudentId(studentId);
            g.setSubjectId(subjectId);
            g.setMarks(marks);
            g.setGrade(grade);

            gradeDAO.addGrade(g);
            response.sendRedirect("GradeServlet"); // Refresh list
        } catch (Exception e) {
            throw new ServletException("Error processing grade submission", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String student = request.getParameter("studentId");
        String subject = request.getParameter("subjectId");

        List<Grade> grades;

        try {
            if (student != null && !student.trim().isEmpty()) {
                grades = gradeDAO.getGradesByStudentId(Integer.parseInt(student));
            } else if (subject != null && !subject.trim().isEmpty()) {
                grades = gradeDAO.getGradesBySubjectId(Integer.parseInt(subject));
            } else {
                grades = gradeDAO.getAllGrades(); // Show all if no filter
            }

            request.setAttribute("grades", grades);
            RequestDispatcher dispatcher = request.getRequestDispatcher("grade_list.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error retrieving grade list", e);
        }
    }
}
