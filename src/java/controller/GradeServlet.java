/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.List;
public class GradeServlet extends HttpServlet {
    private GradeDAO gradeDAO;

    public void init() {
        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdb", "user", "pass");
            gradeDAO = new GradeDAO(conn);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        double marks = Double.parseDouble(request.getParameter("marks"));
        String grade = request.getParameter("grade");

        Grade g = new Grade();
        g.setStudentId(studentId);
        g.setSubjectId(subjectId);
        g.setMarks(marks);
        g.setGrade(grade);

        try {
            gradeDAO.addGrade(g);
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        response.sendRedirect("grade_list.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String student = request.getParameter("studentId");
        String subject = request.getParameter("subjectId");
        List<Grade> grades = null;

        try {
            if (student != null) {
                grades = gradeDAO.getGradesByStudentId(Integer.parseInt(student));
            } else if (subject != null) {
                grades = gradeDAO.getGradesBySubjectId(Integer.parseInt(subject));
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        request.setAttribute("grades", grades);
        RequestDispatcher dispatcher = request.getRequestDispatcher("grade_list.jsp");
        dispatcher.forward(request, response);
    }
}