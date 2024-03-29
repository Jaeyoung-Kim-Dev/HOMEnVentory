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
import models.Item;
import models.User;
import services.AccountService;
import services.InventoryService;

public class AdminInventoryServlet extends HttpServlet {

    /**
     * Gets the "action" and displays the inventory.jsp based on status
     * Populates List for items
     *
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        InventoryService inventoryService = new InventoryService();

        // change item form in 'inventory.jsp' as per the the diplay mode such as default, add or edit item
        String action = request.getParameter("action");
        String searchKeyword = request.getParameter("searchKeyword");

        if (null == action || "searchItem".equals(action) || "cancelSearch".equals(action) || "cancelSave".equals(action)) { // default display or when the press the "Cancel" button of the item form
            defaultDisplay(request);
        } else {
            request.setAttribute("enableForm", true);
            request.setAttribute("cancelForm", true);
            switch (action) {
                case "addItem": // when the press the "Add Item" button of the item form                
                    request.setAttribute("addItem", true);
                    break;
                case "editItem": // when the press the "Edit" button of the item in the table                
                    try {
                        int itemId = Integer.parseInt(request.getParameter("itemId"));
                        Item item = inventoryService.getItem(itemId);
                        request.setAttribute("itemOwner", item.getOwner().getEmail());
                        request.setAttribute("itemToEdit", item);
                        request.setAttribute("editItem", true);
                    } catch (Exception ex) {
                        Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    break;
            }
        }
        setLists(request, inventoryService, email, action, searchKeyword);
        getServletContext().getRequestDispatcher("/WEB-INF/adminInventory.jsp").forward(request, response);
    }

    /**
     * Responsible for all actions performed on Items Based off of action
     * parameter it can: add an item, edit an item, delete a item or save new
     * item info
     *
     * @throws javax.servlet.ServletException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        InventoryService inventoryService = new InventoryService();
        String action = request.getParameter("action");

        switch (action) {
            // when the press the "Delete" button of the item in the table
            // it passes the item ID for SQL query
            case "deleteItem":
                try {
                    Item item = inventoryService.getItem(Integer.parseInt(request.getParameter("itemId")));
                    String itemName = item.getItemName();
                    int itemId = Integer.parseInt(request.getParameter("itemId"));

                    inventoryService.deleteItem(itemId);
                    request.setAttribute("deleteMsg", true);
                    request.setAttribute("itemDeleted", itemName);
                } catch (Exception ex) {
                    Logger.getLogger(AdminServlet.class
                            .getName()).log(Level.SEVERE, null, ex);
                }
                break;
            // when the press the "Save" button of the item form
            case "saveItem":
                int category = Integer.parseInt(request.getParameter("categoryName"));
                String itemName = request.getParameter("itemName");
                String priceString = request.getParameter("price");
                String itemOwner = request.getParameter("itemOwner");

                if (itemName == null || itemName.equals("") || priceString == null || priceString.equals("")) { // item name and price are mandatory to add a new item
                    request.setAttribute("invalidMsg", true);
                    break;
                }

                String saveMode = request.getParameter("saveMode");
                try {
                    double price = Double.parseDouble(priceString);
                    if ("addItem".equals(saveMode)) { // adding a new item
                        inventoryService.insertItem(itemName, price, itemOwner, category);
                        request.setAttribute("addMsg", true);
                        request.setAttribute("itemAdded", itemName);
                    } else if ("editItem".equals(saveMode)) { // editing the existing item
                        int itemId = Integer.parseInt(request.getParameter("itemId"));
                        inventoryService.updateItem(itemId, itemName, price, itemOwner, category);
                        request.setAttribute("editMsg", true);
                        request.setAttribute("itemEdited", itemName);
                    }
                } catch (NumberFormatException ex) {    // if price is String value.
                    request.setAttribute("invalidPriceMsg", true);
                    Logger.getLogger(AdminServlet.class
                            .getName()).log(Level.SEVERE, null, ex);
                } catch (Exception ex) {
                    Logger.getLogger(AdminServlet.class
                            .getName()).log(Level.SEVERE, null, ex);
                }
                break;
        }
        defaultDisplay(request);
        setLists(request, inventoryService, email, null, null);
        getServletContext().getRequestDispatcher("/WEB-INF/adminInventory.jsp").forward(request, response);
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
     * Pass user, items and categories to inventory.jsp
     */
    private HttpServletRequest setLists(HttpServletRequest request, InventoryService inventoryService, String email, String action, String searchKeyword) {
        try {
            List<Category> categories = inventoryService.getAllCategories();
            AccountService accountService = new AccountService();
            User user = accountService.getUser(email);
            request.setAttribute("user", user);
            request.setAttribute("users", accountService.getAllUser());

            if ("searchItem".equals(action)) {
                request.setAttribute("items", inventoryService.searchItem(searchKeyword));
                request.setAttribute("searchKeyword", searchKeyword);
            } else {
                request.setAttribute("items", inventoryService.getAllItems());                
            }

            request.setAttribute("categories", categories);
        } catch (Exception ex) {
            Logger.getLogger(AdminServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return request;
    }
}
