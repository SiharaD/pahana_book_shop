package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.customer;
import service.services;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Show all users
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        services serve = new services();
        List<customer> users = serve.getAllUsers(); // fetch all users from DB

        request.setAttribute("userList", users); // set attribute for JSP
        RequestDispatcher rd = request.getRequestDispatcher("user_list.jsp");
        rd.forward(request, response);
    }

    // Handle delete action
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            String userid = request.getParameter("userid");
            services serve = new services();
            serve.deleteUser(userid);
        }

        // Reload the list after delete
        response.sendRedirect("UserServlet");
    }
}
