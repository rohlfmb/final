package bookdeals;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author rohlf
 */
@WebServlet(urlPatterns = {"/search"})
public class search extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.ClassNotFoundException
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        
        String input = request.getParameter("search");
        String type = request.getParameter("type");
        type = type.replace("'", "''");
        
        // SQL Stuff...
        Connection conn = null;
        ResultSet rs = null;
        ArrayList<Book> books = new ArrayList();
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            
            conn = DriverManager.getConnection("jdbc:mysql://grove.cs.jmu.edu/team21_db", "team21", "f0xtrot9");

            String sql = "SELECT title, author, genre, year, description, isbn FROM Books WHERE " + type + " LIKE ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, "%" + input + "%");
            
            rs = ps.executeQuery();
            
            while(rs.next()) {
                Book book = new Book();
                
                book.title = rs.getString("title");
                book.author = rs.getString("author");
                book.genre = rs.getString("genre");
                book.year = rs.getInt("year");
                book.description = rs.getString("description");
                book.isbn = rs.getString("isbn");
                
                books.add(book);
            }
            
            for(int ii = 0; ii < books.size(); ii++) {
                System.out.println(books.get(ii).getTitle());
                System.out.println(books.get(ii).getAuthor());
                System.out.println(books.get(ii).getGenre());
                System.out.println(books.get(ii).getYear());
                System.out.println(books.get(ii).getDescription());
                System.out.println(books.get(ii).getIsbn());
            }
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("./jsp/Results.jsp");
            request.setAttribute("search", input);
            request.setAttribute("rs", rs);
            request.setAttribute("type", type);
            request.setAttribute("books", books);
            dispatcher.forward(request, response);
        }
        catch (ClassNotFoundException | SQLException e) {
            System.out.println("Cause is " + e.toString());
        }
        finally {
            rs.close();
            conn.close();
        }
        
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(search.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(search.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(search.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(search.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}