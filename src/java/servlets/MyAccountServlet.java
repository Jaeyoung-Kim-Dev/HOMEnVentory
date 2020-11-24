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
public class MyAccountServlet extends HttpServlet {

    /**
     * Gets the "action" and displays the admin.jsp based on status Populates
     * List for users
     *
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        
        String action = request.getParameter("action");

        if ("cancel".equals(action)) {
            response.sendRedirect("inventory");
            return;
        }

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        
        try {
            AccountService accountService = new AccountService();
            User user = accountService.getUser(email);            
            request.setAttribute("userToEdit", user);
        } catch (Exception ex) {
            Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
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
        String email = request.getParameter("email");

        switch (action) {
            // when the press the "Delete" button of the user in the table
            // it passes the email address for SQL query
            case "deleteUser":
                try {
                    accountService.deleteUser(email);
                    request.setAttribute("deleteMsg", true);
                    request.setAttribute("emailDeleted", email);

                } catch (Exception ex) {
                    Logger.getLogger(AdminServlet.class
                            .getName()).log(Level.SEVERE, null, ex);
                }
                break;
            // when the press the "Save" button of the user form
            case "saveUser":
                boolean isActive = ("active".equals(request.getParameter("isActive")));
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String password = request.getParameter("password");
                int role = Integer.parseInt(request.getParameter("roleName"));

                if (email == null || email.equals("")) { // email is mandatory to add a new user
                    request.setAttribute("invalidUser", true);
                    break;
                }

                String saveMode = request.getParameter("saveMode");
                try {
                    if ("addUser".equals(saveMode)) { // adding a new user
                        accountService.insertUser(email, isActive, firstName, lastName, password, role);
                        request.setAttribute("addMsg", true);
                        request.setAttribute("emailAdded", email);
                    } else if ("editUser".equals(saveMode)) { // editing the existing user
                        accountService.updateUser(email, isActive, firstName, lastName, password, role);
                        request.setAttribute("editMsg", true);
                        request.setAttribute("emailedited", email);

                    }
                } catch (Exception ex) {
                    Logger.getLogger(AdminServlet.class
                            .getName()).log(Level.SEVERE, null, ex);
                }
                break;
        }
        getServletContext().getRequestDispatcher("/WEB-INF/admin.jsp").forward(request, response);
    }

}
