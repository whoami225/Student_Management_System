package com.schoolmanagement.servlet;

import com.schoolmanagement.dao.StudentDAO;
import com.schoolmanagement.model.Student;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/students")
public class StudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDAO studentDAO;
    
    @Override
    public void init() throws ServletException {
        Connection connection = (Connection) getServletContext().getAttribute("DBConnection");
        studentDAO = new StudentDAO(connection);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "add":
                    addStudent(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "update":
                    updateStudent(request, response);
                    break;
                case "delete":
                    deleteStudent(request, response);
                    break;
                case "profile":
                    showProfile(request, response);
                    break;
                case "list":
                default:
                    listStudents(request, response);
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void listStudents(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("students", students);
        RequestDispatcher dispatcher = request.getRequestDispatcher("student_list.jsp");
        dispatcher.forward(request, response);
    }
    
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("student_form.jsp");
        dispatcher.forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Student existingStudent = studentDAO.getStudentById(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("student_form.jsp");
        request.setAttribute("student", existingStudent);
        dispatcher.forward(request, response);
    }
    
    private void showProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        Student student = studentDAO.getStudentById(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("student_profile.jsp");
        request.setAttribute("student", student);
        dispatcher.forward(request, response);
    }
    
    private void addStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, ParseException {
        int userId = Integer.parseInt(request.getParameter("user_id"));
        Date admissionDate = Date.valueOf(request.getParameter("admission_date"));
        int batchId = Integer.parseInt(request.getParameter("batch_id"));
        String guardianName = request.getParameter("guardian_name");
        String address = request.getParameter("address");
        
        Student newStudent = new Student();
        newStudent.setUserId(userId);
        newStudent.setAdmissionDate(admissionDate);
        newStudent.setBatchId(batchId);
        newStudent.setGuardianName(guardianName);
        newStudent.setAddress(address);
        
        studentDAO.addStudent(newStudent);
        response.sendRedirect("students?action=list");
    }
    
    private void updateStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, ParseException {
        int id = Integer.parseInt(request.getParameter("id"));
        int userId = Integer.parseInt(request.getParameter("user_id"));
        Date admissionDate = Date.valueOf(request.getParameter("admission_date"));
        int batchId = Integer.parseInt(request.getParameter("batch_id"));
        String guardianName = request.getParameter("guardian_name");
        String address = request.getParameter("address");
        
        Student student = new Student();
        student.setStudentId(id);
        student.setUserId(userId);
        student.setAdmissionDate(admissionDate);
        student.setBatchId(batchId);
        student.setGuardianName(guardianName);
        student.setAddress(address);
        
        studentDAO.updateStudent(student);
        response.sendRedirect("students?action=list");
    }
    
    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
        studentDAO.deleteStudent(id);
        response.sendRedirect("students?action=list");
    }
}