/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bookdeals;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.concurrent.ThreadLocalRandom;
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
 * @author ducky
 */
@WebServlet(name = "WishListUpdate", urlPatterns = {"/wishlistupdate"})
public class WishListUpdate extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

        Connection conn = null;

        HttpSession session = request.getSession(true);

        try {
            Class.forName("com.mysql.jdbc.Driver");

            conn = DriverManager.getConnection("jdbc:mysql://grove.cs.jmu.edu/team21_db", "team21", "f0xtrot9");

            String username = session.getAttribute("userName").toString();

            int rowID;
            ResultSet rs = null;

            do {
                rowID = 0 + (int) (Math.random() * 2147483647);
                String sql = "SELECT row_id FROM Wishlist WHERE row_id = ?";

                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, rowID);

                rs = ps.executeQuery();

            } while (rs.next());
            
            rs.close();
            
            String sql2 = "SELECT wish_list_id FROM Users WHERE username = ?";

            PreparedStatement ps2 = conn.prepareStatement(sql2);
            ps2.setString(1, username);

            ResultSet rs2 = ps2.executeQuery();

            rs2.next();
            
            int wishListID = rs2.getInt("wish_list_id");
            
            rs2.close();
            
            String sql3 = "INSERT INTO Wishlist VALUES (?, ?, ?)";
            
            PreparedStatement ps3 = conn.prepareStatement(sql3);
            ps3.setInt(1, rowID);
            ps3.setInt(2, wishListID);
            ps3.setString(3, request.getParameter("wishlistupdate"));
            
            ps3.execute();
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("wishlist");
            dispatcher.forward(request, response);
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
