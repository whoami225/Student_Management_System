/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.AttendanceDAO;
import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Attendance;

public class AttendanceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int studentId = Integer.parseInt(request.getParameter("student_id"));
        int subjectId = Integer.parseInt(request.getParameter("subject_id"));
        boolean status = "present".equals(request.getParameter("status"));

        Attendance attendance = new Attendance();
        attendance.setStudentId(studentId);
        attendance.setSubjectId(subjectId);
        attendance.setDate(LocalDate.now().toString());
        attendance.setStatus(status);

        try (Connection conn = DBConnection.getConnection()) {
            AttendanceDAO dao = new AttendanceDAO(conn);
            dao.markAttendance(attendance);
        } catch (Exception e) {
        }

        response.sendRedirect("attendance_mark.jsp");
    }
}

