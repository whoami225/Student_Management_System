/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// src/main/java/com/example/servlet/MessageServlet.java
package com.example.servlet;

import com.example.dao.MessageDAO;
import com.example.model.Message;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/messages")
public class MessageServlet extends HttpServlet {
    private MessageDAO messageDAO;

    public void init() {
        messageDAO = new MessageDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int senderId = Integer.parseInt(request.getParameter("sender_id"));
        int receiverId = Integer.parseInt(request.getParameter("receiver_id"));
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");
        
        Message newMessage = new Message();
        newMessage.setSenderId(senderId);
        newMessage.setReceiverId(receiverId);
        newMessage.setSubject(subject);
        newMessage.setContent(content);
        
        if (messageDAO.sendMessage(newMessage)) {
            response.sendRedirect("messages_receive.jsp");
        } else {
            request.setAttribute("error", "Failed to send message");
            request.getRequestDispatcher("messages.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int userId = Integer.parseInt(request.getParameter("user_id"));
        List<Message> messages = messageDAO.getMessagesByReceiver(userId);
        request.setAttribute("messages", messages);
        request.getRequestDispatcher("messages_receive.jsp").forward(request, response);
    }
}
