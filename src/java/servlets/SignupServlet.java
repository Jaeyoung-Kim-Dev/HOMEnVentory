/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.User;
import services.AccountService;

/**
 *
 * @author kornk
 */
public class SignupServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        session.invalidate();

//        String email = (String) session.getAttribute("email");
//
//        AccountService as = new AccountService();
//        User user = null;
//        try {
//            user = as.getUser(email);
//        } catch (Exception ex) {
//            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
//        }
        String action = request.getParameter("action");

        if ("cancel".equals(action)) { // default display or when the press the "Cancel" button of the user form
            getServletContext().getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
        }

        getServletContext().getRequestDispatcher("/WEB-INF/signup.jsp").forward(request, response);

        // forward to the login page, but redirect to inventory or admin page if a user signed in.
//        if (email == null) {
//            getServletContext().getRequestDispatcher("/WEB-INF/signup.jsp").forward(request, response);
//        } else if (user.getRole().getRoleId() == 1) {
//            response.sendRedirect("admin");
//        } else {
//            response.sendRedirect("inventory");
//        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountService accountService = new AccountService();

        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String password = request.getParameter("password");

        //validates that user name and password are not empty
        if (email == null || email.equals("") || firstName == null || firstName.equals("")|| lastName == null || lastName.equals("")|| password == null || password.equals("")) {
            request.setAttribute("email", email);
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("password", password);
            request.setAttribute("emptiedField", true);

            getServletContext().getRequestDispatcher("/WEB-INF/signup.jsp").forward(request, response);
            return;
        }

        try {
            User exsitingUser = accountService.getUser(email);
            
            if (exsitingUser != null) {
                request.setAttribute("exsitingUser", true);
                getServletContext().getRequestDispatcher("/WEB-INF/signup.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        try {
            accountService.insertUser(email, true, firstName, lastName, password, 2);
        } catch (Exception ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
        }  
        
        HttpSession session = request.getSession();
        session.setAttribute("email", email);

        response.sendRedirect("inventory");        
    }
}
