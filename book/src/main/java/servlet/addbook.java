package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.book;
import service.services;

/**
 * Servlet implementation class addbook
 */
@WebServlet("/addbook")
public class addbook extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addbook() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		book app1=new book();
		app1.setBookid(Integer.parseInt(request.getParameter("bookid")));
		app1.setTitle(request.getParameter("title"));
		app1.setAuthor(request.getParameter("author"));
		app1.setPublisher(request.getParameter("publisher"));
		app1.setIsbn(request.getParameter("isbn"));
		app1.setCategory(request.getParameter("category"));
		app1.setEdition(request.getParameter("edition"));
		app1.setLanguage(request.getParameter("language"));
		app1.setDescription(request.getParameter("description"));
		app1.setImage(request.getParameter("cover"));
		
		services book1=new services();
		book1.addbook(app1);
		
		RequestDispatcher app2=request.getRequestDispatcher("home.jsp");
		app2.forward(request, response);
		
		doGet(request, response);
	}

}
