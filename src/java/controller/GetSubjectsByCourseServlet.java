package controller;

import dao.SubjectDAO;
import model.Subject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/getSubjectsByCourse")
public class GetSubjectsByCourseServlet extends HttpServlet {
    private SubjectDAO subjectDAO;

    @Override
    public void init() {
        subjectDAO = new SubjectDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            List<Subject> subjectList = subjectDAO.getSubjectsByCourse(courseId);

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("[");
            for (int i = 0; i < subjectList.size(); i++) {
                Subject s = subjectList.get(i);
                out.print("{\"subjectId\":" + s.getSubjectId() + ",\"subjectName\":\"" + s.getSubjectName() + "\"}");
                if (i < subjectList.size() - 1) out.print(",");
            }
            out.print("]");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
