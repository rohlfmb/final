/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bookdeals;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ducky
 */
public class Username {

    public static Boolean validateUser(String username) {
        try {
            Connection conn = null;
            ResultSet rs = null;

            Class.forName("com.mysql.jdbc.Driver");

            conn = DriverManager.getConnection("jdbc:mysql://grove.cs.jmu.edu/team21_db", "team21", "f0xtrot9");

            String sql = "SELECT * FROM Users WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            
            rs = ps.executeQuery();

            if (rs.next())
            {
                return false;
            }
            else
            {
                return true;
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getLocalizedMessage());
        }
        return false;
    }
}
