/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Category;
import models.Role;
import models.User;
import services.AccountService;
import services.InventoryService;

/**
 *
 * @author kornk
 */
public class CategoryServlet extends HttpServlet {

    /**
     * Gets the "action" and displays the admin.jsp based on status Populates
     * List for users
     *
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        InventoryService inventoryService = new InventoryService();

        String action = request.getParameter("action");

        if (null == action || "cancel".equals(action)) {
            defaultDisplay(request);
        } else {
            request.setAttribute("enableForm", true);
            request.setAttribute("cancelForm", true);
            switch (action) {
                case "addCategory": // when the press the "Add User" button of the user form                
                    request.setAttribute("addCategory", true);
                    break;
                case "editCategory": // when the press the "Edit" button of the user in the table                
                    try {
                        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                        Category category = inventoryService.getCategory(categoryId);
                        request.setAttribute("categoryToEdit", category);
                        request.setAttribute("editCategory", true);
                    } catch (Exception ex) {
                        Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    break;
            }
        }        
        setLists(request, inventoryService);
        getServletContext().getRequestDispatcher("/WEB-INF/category.jsp").forward(request, response);
    }

    /**
     * Responsible for all actions performed on Users Based off of action
     * parameter it can: add a user, edit a user, delete a user or save new user
     * info
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        InventoryService inventoryService = new InventoryService();
        String action = request.getParameter("action");        
        String categoryName = request.getParameter("categoryName");

        if ("saveCategory".equals(action)) {
            if (categoryName == null || categoryName.equals("")) { // email is mandatory to add a new user
                request.setAttribute("invalidMsg", true);
                getServletContext().getRequestDispatcher("/WEB-INF/category.jsp").forward(request, response);
                return;
            } 

            String saveMode = request.getParameter("saveMode");
            try {
                if ("addCategory".equals(saveMode)) { // adding a new user
                    inventoryService.insertCategory(categoryName);
                    request.setAttribute("addMsg", true);
                    request.setAttribute("categoryAdded", categoryName);
                } else if ("editCategory".equals(saveMode)) { // editing the existing user
                    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                    inventoryService.updateCategory(categoryId, categoryName);
                    request.setAttribute("editMsg", true);
                    request.setAttribute("emailedited", categoryName);
                }
            } catch (Exception ex) {
                Logger.getLogger(AdminServlet.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }
        defaultDisplay(request);
        setLists(request, inventoryService);
        getServletContext().getRequestDispatcher("/WEB-INF/category.jsp").forward(request, response);
    }
    
   /**
     * Initial display and when pressed the cancel button.
     */
    private HttpServletRequest defaultDisplay(HttpServletRequest request) {
        request.setAttribute("defaultTitle", true);
        request.setAttribute("enableForm", false);
        request.setAttribute("cancelForm", false);
        return request;
    }

    /**
     * Pass users and roles to admin.jsp
     */
    private HttpServletRequest setLists(HttpServletRequest request, InventoryService inventoryService) {
        try {
            HttpSession session = request.getSession();
            String email = (String) session.getAttribute("email");
            AccountService accountService = new AccountService();
            User user = accountService.getUser(email);
            request.setAttribute("user", user);
            
            List<Category> categories = inventoryService.getAllCategories();            
            request.setAttribute("categories", categories);
        } catch (Exception ex) {
            Logger.getLogger(AdminServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return request;
    }
}
