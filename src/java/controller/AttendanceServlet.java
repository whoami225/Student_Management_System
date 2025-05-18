package controller;

import dao.AttendanceDAO;
import dao.StudentDAO;
import model.Attendance;
import model.Student;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {

    private AttendanceDAO attendanceDAO;
    private StudentDAO studentDAO;

    @Override
    public void init() {
        attendanceDAO = new AttendanceDAO();
        studentDAO = new StudentDAO();
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            if (action == null) action = "view";

            HttpSession session = request.getSession(false);
            if (session == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            User user = (User) session.getAttribute("user");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            
            switch (action) {
                case "mark":  // Teacher marking attendance
                if (user.getRoleId() != 2) { // Only allow teachers here (assuming roleId=2 for teachers)
                    response.sendRedirect("unauthorized.jsp");
                    return;
                }
                // Fetch all students, not by subject!
                List<Student> studentList = studentDAO.getAllStudents();
                request.setAttribute("studentList", studentList);

                request.getRequestDispatcher("attendance_mark.jsp").forward(request, response);
                break;


                case "view":  // Student viewing attendance
                default:
                    if (user.getRoleId() != 3) { // Only students allowed here (assuming roleId=3 for students)
                        response.sendRedirect("unauthorized.jsp");
                        return;
                    }
                    // Get student ID from your StudentDAO by userId (since session stores user, not studentId)
                    int studentId = studentDAO.getStudentIdByUserId(user.getUserId());
                    if (studentId == 0) {
                        response.sendRedirect("error.jsp"); // Or custom error
                        return;
                    }

                    List<Attendance> attendanceList = attendanceDAO.getAttendanceByStudent(studentId);
                    request.setAttribute("attendanceList", attendanceList);
                    request.getRequestDispatcher("attendance_view.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRoleId() != 2) {
            response.sendRedirect("unauthorized.jsp");
            return;
        }

       String dateStr = request.getParameter("attendance_date");
String[] studentIds = request.getParameterValues("student_id");

if (dateStr == null || studentIds == null) {
    response.sendRedirect("attendance?action=mark");
    return;
}

java.sql.Date attendanceDate = java.sql.Date.valueOf(dateStr);

for (String studentIdStr : studentIds) {
    int studentId = Integer.parseInt(studentIdStr);
    String status = request.getParameter("attendance_status_" + studentId);

    if (status == null) continue;

    Attendance attendance = new Attendance();
    attendance.setStudentId(studentId);
    // No subject_id
    attendance.setDate(attendanceDate);
    attendance.setStatus(status);

    attendanceDAO.markAttendance(attendance);
}


        response.sendRedirect("attendance?action=mark&success=1");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
    }
}

}
