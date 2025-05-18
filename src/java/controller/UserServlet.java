package controller;

import dao.RoleDAO;
import dao.UserDAO;
import model.Role;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

    private UserDAO userDAO;
    private RoleDAO roleDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
        roleDAO = new RoleDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) action = "list";

        switch (action) {
            case "new" -> {
                try {
                    showNewForm(request, response);
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            case "edit" -> {
                try {
                    showEditForm(request, response);
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            case "delete" -> {
                try {
                    deleteUser(request, response);
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            default -> {
                try {
                    listUsers(request, response);
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = request.getParameter("user_id") != null ? Integer.parseInt(request.getParameter("user_id")) : 0;
        int roleId = Integer.parseInt(request.getParameter("role_id"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("full_name");
        String status = request.getParameter("status");

        User user = new User(userId, roleId, username, email, password, fullName, status);

        if (userId == 0) {
            try {
                userDAO.createUser(user);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            try {
                userDAO.updateUser(user);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        response.sendRedirect("user");
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("userList", users);
        request.getRequestDispatcher("user_list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        List<Role> roles = roleDAO.getAllRoles();
        request.setAttribute("roles", roles);
        request.getRequestDispatcher("user_form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        int userId = Integer.parseInt(request.getParameter("id"));
        User existingUser = userDAO.getUserByEmail(userDAO.getAllUsers().stream()
                .filter(u -> u.getUserId() == userId)
                .findFirst().get().getEmail());
        List<Role> roles = roleDAO.getAllRoles();
        request.setAttribute("user", existingUser);
        request.setAttribute("roles", roles);
        request.getRequestDispatcher("user_form.jsp").forward(request, response);
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ClassNotFoundException {
        int userId = Integer.parseInt(request.getParameter("id"));
        userDAO.deleteUser(userId);
        response.sendRedirect("user");
    }
}
