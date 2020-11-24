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
import models.Item;
import models.Role;
import models.User;
import services.AccountService;
import services.InventoryService;

/**
 *
 * @author Jaeyoung Kim
 */
public class AdminServlet extends HttpServlet {

    /**
     * Gets the "action" and displays the admin.jsp based on status Populates
     * List for users
     *
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountService accountService = new AccountService();

        // change user form in 'admin.jsp' as per the the diplay mode such as default, add or edit user
        String action = request.getParameter("action");

        if (null == action || "cancel".equals(action)) { // default display or when the press the "Cancel" button of the user form
            defaultDisplay(request);
        } else {
            request.setAttribute("enableForm", true);
            request.setAttribute("cancelForm", true);
            switch (action) {
                case "addUser": // when the press the "Add User" button of the user form                
                    request.setAttribute("addUser", true);
                    break;
                case "editUser": // when the press the "Edit" button of the user in the table                
                    try {
                        String email = request.getParameter("email");
                        User user = accountService.getUser(email);
                        request.setAttribute("userToEdit", user);
                        request.setAttribute("editUser", true);
                    } catch (Exception ex) {
                        Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    break;
            }
        }
        setLists(request, accountService);
        getServletContext().getRequestDispatcher("/WEB-INF/admin.jsp").forward(request, response);
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

                    User user = accountService.getUser(email);
                    List<Item> itemList = user.getItemList();

                    InventoryService InventoryService = new InventoryService();
                    for (Item item : itemList) {
                        InventoryService.deleteItem(item.getItemId());
                    }

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
                    request.setAttribute("invalidMsg", true);
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
        defaultDisplay(request);
        setLists(request, accountService);
        getServletContext().getRequestDispatcher("/WEB-INF/admin.jsp").forward(request, response);
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
    private HttpServletRequest setLists(HttpServletRequest request, AccountService accountService) {
        try {
            HttpSession session = request.getSession();
            String email = (String) session.getAttribute("email");

            List<User> users = accountService.getAllUser();
            List<Role> roles = accountService.getAllRoles();
            User user = accountService.getUser(email);
            
            request.setAttribute("users", users);
            request.setAttribute("roles", roles);
            request.setAttribute("user", user);
        } catch (Exception ex) {
            Logger.getLogger(AdminServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return request;
    }
}
