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


@WebServlet("/sign_up")
public class sign_up extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public sign_up() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		customer cus1=new customer();
		cus1.setUserid(request.getParameter("userid"));
		cus1.setName(request.getParameter("name"));
		cus1.setAddress(request.getParameter("address"));
		cus1.setTell(Integer.parseInt(request.getParameter("tel")));
		cus1.setPass(request.getParameter("pass"));
		
		services serve=new services();
		serve.adduser(cus1);
		
		RequestDispatcher app1=request.getRequestDispatcher("home.jsp");
		app1.forward(request, response);
		
		
	}

}
