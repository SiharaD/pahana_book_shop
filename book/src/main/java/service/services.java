package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import controler.database;
import model.book;
import model.customer;

public class services {

	public void adduser(customer cus) {
		try {
			String query = "INSERT INTO users (userid, name, address, tell, pass) VALUES ('" + cus.getUserid() + "','" + cus.getName() + "','" + cus.getAddress() + "','" + cus.getTell() + "','" + cus.getPass() + "');";
			Statement statement=database.getconnection().createStatement();
			statement.executeUpdate(query);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//*************************************************************************************************************
	public void addbook(book bk) {
		try {
			String query = "INSERT INTO books(bookid,title,author,publisher,isbn,category,edition,language,description,image) VALUES ('" + bk.getBookid() + "','" + bk.getTitle() + "','" + bk.getAuthor() + "','" + bk.getPublisher() + "','" + bk.getIsbn() + "','" + bk.getCategory() + "','" + bk.getEdition() + "','" + bk.getLanguage() + "','" + bk.getDescription() + "','" + bk.getImage() + "');";
			Statement statement=database.getconnection().createStatement();
			statement.executeUpdate(query);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//****************************************************************************************************************
	
	public boolean login(customer cus) {
		try {
			String query = "SELECT * FROM users WHERE name='" + cus.getName() + "' AND pass='" + cus.getPass() + "'";
			Statement st=database.getconnection().createStatement();
			ResultSet rs=st.executeQuery(query);
			if(rs.next()) {
				return true;
			}

			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	//********************************************************************************************************************
	
	public List<book> getAllBooks() {
	    List<book> bookList = new ArrayList<>();
	    try {
	        String query = "SELECT * FROM books";
	        Statement stmt = database.getconnection().createStatement();
	        ResultSet rs = stmt.executeQuery(query);

	        while (rs.next()) {
	            book bk = new book();
	            bk.setBookid(rs.getInt("bookid"));
	            bk.setTitle(rs.getString("title"));
	            bk.setAuthor(rs.getString("author"));
	            bk.setPublisher(rs.getString("publisher"));
	            bk.setIsbn(rs.getString("isbn"));
	            bk.setCategory(rs.getString("category"));
	            bk.setEdition(rs.getString("edition"));
	            bk.setLanguage(rs.getString("language"));
	            bk.setDescription(rs.getString("description"));
	            bk.setImage(rs.getString("image")); // assuming base64 string or image path

	            bookList.add(bk);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return bookList;
	}

	//*******************************************************************************************************
	public customer getone(customer cus) {
		try {
			String query = "SELECT * FROM users WHERE name='" + cus.getName() + "' AND pass='" + cus.getPass() + "'";
			Statement st=database.getconnection().createStatement();
			ResultSet rs=st.executeQuery(query);
			if(rs.next()) {
				cus.setUserid(rs.getString("userid"));
				cus.setName(rs.getString("name"));
				cus.setAddress(rs.getString("address"));
				cus.setTell(rs.getInt("tell"));
				cus.setPass(rs.getString("pass"));
				return cus;
			}

			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
//***********************************************************************************************************
	 public boolean updateProfile(customer cus) {
	        try {
	            String query = "UPDATE users SET name=?, address=?, tell=?, pass=? WHERE userid=?";
	            Connection con = database.getconnection();
	            PreparedStatement ps = con.prepareStatement(query);
	            ps.setString(1, cus.getName());
	            ps.setString(2, cus.getAddress());
	            ps.setInt(3, cus.getTell());
	            ps.setString(4, cus.getPass());
	            ps.setString(5, cus.getUserid());

	            int rows = ps.executeUpdate();
	            return rows > 0; // true if updated
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false;
	    }
//*******************************************************************************************************************
	 public List<customer> getAllUsers() {
	        List<customer> list = new ArrayList<>();
	        try {
	            String query = "SELECT * FROM users";
	            Statement st = database.getconnection().createStatement();
	            ResultSet rs = st.executeQuery(query);
	            while (rs.next()) {
	                customer cus = new customer();
	                cus.setUserid(rs.getString("userid"));
	                cus.setName(rs.getString("name"));
	                cus.setAddress(rs.getString("address"));
	                cus.setTell(rs.getInt("tell"));
	                cus.setPass(rs.getString("pass"));
	                list.add(cus);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return list;
	    }

	    public void deleteUser(String userid) {
	        try {
	            String query = "DELETE FROM users WHERE userid='" + userid + "'";
	            Statement st = database.getconnection().createStatement();
	            st.executeUpdate(query);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	 //*************************************************************************************************************
	    public List<book> bkall() {
	        List<book> bookList = new ArrayList<>();
	        try {
	            String query = "SELECT * FROM books";
	            Statement stmt = database.getconnection().createStatement();
	            ResultSet rs = stmt.executeQuery(query);
	            while (rs.next()) {
	                book bk = new book();
	                bk.setBookid(rs.getInt("bookid"));
	                bk.setTitle(rs.getString("title"));
	                bk.setAuthor(rs.getString("author"));
	                bk.setPublisher(rs.getString("publisher"));
	                bk.setIsbn(rs.getString("isbn"));
	                bk.setCategory(rs.getString("category"));
	                bk.setEdition(rs.getString("edition"));
	                bk.setLanguage(rs.getString("language"));
	                bk.setDescription(rs.getString("description"));
	                bk.setImage(rs.getString("image"));
	                bookList.add(bk);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return bookList;
	    }

	    // Delete book by id
	    public void deleteBook(int bookid) {
	        try {
	            String query = "DELETE FROM books WHERE bookid=" + bookid;
	            Statement stmt = database.getconnection().createStatement();
	            stmt.executeUpdate(query);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    //******************************************************************************************************
	  

	        public boolean validateUser(String username, String password) {
	            // Simple hardcoded check
	            return "admin".equals(username) && "admin".equals(password);
	        }
	    }
	

