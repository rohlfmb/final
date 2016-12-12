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
@WebServlet(name = "AddBookServlet", urlPatterns = {"/addbook"})
public class AddBookServlet extends HttpServlet {

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

            String sql1 = "INSERT INTO Books VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps1 = conn.prepareStatement(sql1);
            ps1.setString(1, request.getParameter("isbn"));
            ps1.setString(2, request.getParameter("title"));
            ps1.setString(3, request.getParameter("author"));
            ps1.setString(4, request.getParameter("publisher"));
            ps1.setInt(5, Integer.parseInt(request.getParameter("year")));
            ps1.setString(6, request.getParameter("genre"));
            ps1.setString(7, request.getParameter("description"));
            ps1.setString(8, request.getParameter("type"));

            ps1.execute();

            String sql2 = "INSERT INTO Prices VALUES (?, ?, ?)";
            PreparedStatement ps2 = conn.prepareStatement(sql2);

            ps2.setString(1, request.getParameter("isbn"));
            ps2.setInt(2, 1);
            ps2.setDouble(3, Double.parseDouble(request.getParameter("amPrice")));

            ps2.execute();

            String sql3 = "INSERT INTO Prices VALUES (?, ?, ?)";
            PreparedStatement ps3 = conn.prepareStatement(sql3);

            ps3.setString(1, request.getParameter("isbn"));
            ps3.setInt(2, 2);
            ps3.setDouble(3, Double.parseDouble(request.getParameter("bnPrice")));

            ps3.execute();

            String sql4 = "INSERT INTO Prices VALUES (?, ?, ?)";
            PreparedStatement ps4 = conn.prepareStatement(sql4);

            ps4.setString(1, request.getParameter("isbn"));
            ps4.setInt(2, 3);
            ps4.setDouble(3, Double.parseDouble(request.getParameter("bmPrice")));

            ps4.execute();

            String sql5 = "INSERT INTO Prices VALUES (?, ?, ?)";
            PreparedStatement ps5 = conn.prepareStatement(sql5);

            ps5.setString(1, request.getParameter("isbn"));
            ps5.setInt(2, 4);
            ps5.setDouble(3, Double.parseDouble(request.getParameter("wmPrice")));

            ps5.execute();

            response.sendRedirect("./jsp/Product.jsp?isbn=" + request.getParameter("isbn"));
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
