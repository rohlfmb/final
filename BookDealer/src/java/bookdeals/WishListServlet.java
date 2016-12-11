/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bookdeals;

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
import javax.servlet.http.HttpSession;

/**
 *
 * @author Brendon Guss
 */
@WebServlet(name = "WishListServlet", urlPatterns = {"/wishlist"})
public class WishListServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {

        response.setContentType("text/html;charset=UTF-8");

        Connection conn = null;
        ArrayList<Book> wishList = new ArrayList();

        HttpSession session = request.getSession(true);

        try {
            Class.forName("com.mysql.jdbc.Driver");

            conn = DriverManager.getConnection("jdbc:mysql://grove.cs.jmu.edu/team21_db", "team21", "f0xtrot9");

            String username = session.getAttribute("userName").toString();
            int wishListID;

            String sql = "SELECT isbn FROM Wishlist WHERE wish_list_id = ?";
            String sql2 = "SELECT wish_list_id FROM Users WHERE username = ?";

            ArrayList<String> wishListISBNS = new ArrayList<>();

            PreparedStatement ps = conn.prepareStatement(sql);
            PreparedStatement ps2 = conn.prepareStatement(sql2);

            ps2.setString(1, username);

            ResultSet rs2 = ps2.executeQuery();

            rs2.next();
            wishListID = rs2.getInt("wish_list_id");
            rs2.close();

            ps.setInt(1, wishListID);

            ResultSet rs3 = ps.executeQuery();

            while (rs3.next()) {
                wishListISBNS.add(rs3.getString("isbn"));
            }

            rs3.close();

            for (String ISBN : wishListISBNS) {
                String sql3 = "SELECT title, author, genre, year, description FROM Books WHERE isbn = ?";
                PreparedStatement ps3 = conn.prepareStatement(sql3);
                ps3.setString(1, ISBN);
                ResultSet rs4 = ps3.executeQuery();

                Book book = new Book();

                if (rs4.next()) {
                    book.title = rs4.getString("title");
                    book.author = rs4.getString("author");
                    book.genre = rs4.getString("genre");
                    book.year = rs4.getInt("year");
                    book.description = rs4.getString("description");
                    book.isbn = ISBN;
                }

                rs4.close();
                wishList.add(book);
            }

            session.setAttribute("wishList", wishList);

            if ((Boolean) request.getAttribute("loginrequest") == null || (Boolean) request.getAttribute("loginrequest") == false) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("./jsp/Wishlist.jsp");
                dispatcher.forward(request, response);
            } else {
                RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
            }

        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Cause is " + e.toString());
        } finally {
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
