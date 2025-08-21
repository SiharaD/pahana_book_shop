package servlet;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.customer;
import service.services;

@WebServlet("/log")
public class log extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        customer app3 = new customer();
        app3.setName(request.getParameter("username"));
        app3.setPass(request.getParameter("password"));

        services app4 = new services();
        boolean status = app4.login(app3);

        if (status) {
            customer one = app4.getone(app3); // fetch logged-in customer
            request.setAttribute("custom", one); // ✅ pass customer bean to JSP
            RequestDispatcher dis = request.getRequestDispatcher("profile.jsp");
            dis.forward(request, response);
        } else {
            RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
            dis.forward(request, response);
        }
    }
}
