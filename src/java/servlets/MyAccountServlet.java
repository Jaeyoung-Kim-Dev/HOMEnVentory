/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
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
public class MyAccountServlet extends HttpServlet {

    /**
     * Gets the "action" and displays the admin.jsp based on status Populates
     * List for users
     *
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        AccountService accountService = new AccountService();

        String action = request.getParameter("action");

        if ("cancel".equals(action)) {
            response.sendRedirect("inventory");
            return;
        }

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        try {            
            User user = accountService.getUser(email);
            request.setAttribute("userToEdit", user);
        } catch (Exception ex) {
            Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        setLists(request, accountService, email);
        getServletContext().getRequestDispatcher("/WEB-INF/myaccount.jsp").forward(request, response);
    }

    /**
     * Responsible for all actions performed on Users Based off of action
     * parameter it can: add a user, edit a user, delete a user or save new user
     * info
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountService accountService = new AccountService();
        String action = request.getParameter("action");

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String password = request.getParameter("password");
        boolean isActive = ("active".equals(request.getParameter("isActive")));
        int role = Integer.parseInt(request.getParameter("roleName"));

        if ("saveUser".equals(action)) {
            //validates that user name and password are not empty
            if (firstName == null || firstName.equals("") || lastName == null || lastName.equals("") || password == null || password.equals("")) {
                request.setAttribute("firstName", firstName);
                request.setAttribute("lastName", lastName);
                request.setAttribute("password", password);
                request.setAttribute("isActive", isActive);
                request.setAttribute("emptiedField", true);

                getServletContext().getRequestDispatcher("/WEB-INF/signup.jsp").forward(request, response);
                return;
            }

            try {
                accountService.updateUser(email, isActive, firstName, lastName, password, role);
            } catch (Exception ex) {
                Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        setLists(request, accountService, email);
        response.sendRedirect("inventory");
    }

    /**
     * Pass user, items and categories to inventory.jsp
     */
    private HttpServletRequest setLists(HttpServletRequest request, AccountService accountService, String email) {
        try {
            User user = accountService.getUser(email);
            request.setAttribute("user", user);
        } catch (Exception ex) {
            Logger.getLogger(AdminServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return request;
    }

}
