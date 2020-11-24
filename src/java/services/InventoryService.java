package services;

import dataaccess.*;
import java.util.List;
import models.*;

public class InventoryService {

    /**
     * Method that calls getAllItems() in ItemsDB
     *
     * @return the List of items
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public List<Item> getAllItems() throws Exception {
        ItemsDB itemsDB = new ItemsDB();
        List<Item> items = itemsDB.getAll();
        return items;
    }

    /**
     * Method that calls getItem() in ItemsDB and forwards the item id to search
     * for
     *
     * @param itemId the id of the item to search for
     * @return the Item found
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public Item getItem(int itemId) throws Exception {
        ItemsDB itemsDB = new ItemsDB();
        Item item = itemsDB.get(itemId);
        return item;
    }

    /**
     * Method that calls insertItem() in ItemsDB
     *
     * @param itemName item name
     * @param price item price
     * @param owner item owner
     * @param categoryId item category id
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public void insertItem(String itemName, double price, String owner, int categoryId) throws Exception {
        Item item = new Item(0, itemName, price);

        UserDB userDB = new UserDB();
        User user = userDB.get(owner);
        item.setOwner(user);

        CategoryDB categoriesDB = new CategoryDB();
        Category category = categoriesDB.get(categoryId);
        item.setCategory(category);

        ItemsDB itemsDB = new ItemsDB();
        itemsDB.insert(item);
    }

    /**
     * Method that calls updateItem() in ItemsDB
     *
     * @param itemName item name
     * @param price item price
     * @param owner item owner
     * @param categoryId item category id
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public void updateItem(int itemId, String itemName, double price, String owner, int categoryId) throws Exception {
        ItemsDB itemsDB = new ItemsDB();
        Item item = itemsDB.get(itemId);
        item.setItemName(itemName);
        item.setPrice(price);

        CategoryDB categoriesDB = new CategoryDB();
        Category category = categoriesDB.get(categoryId);
        item.setCategory(category);

        itemsDB.update(item);
    }

    /**
     * Method that calls deleteItem() in ItemsDB
     *
     * @param itemId the id of the item to search for
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public void deleteItem(int itemId) throws Exception {
        ItemsDB itemsDB = new ItemsDB();
        Item item = itemsDB.get(itemId);
        itemsDB.delete(item);
    }

    /**
     * Method that calls getAllCategories() in CategoryDB
     *
     * @return the List of Categories
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public List<Category> getAllCategories() throws Exception {
        CategoryDB categoriesDB = new CategoryDB();
        List<Category> categories = categoriesDB.getAll();
        return categories;
    }
    
    /**
     * Method that calls getItem() in ItemsDB and forwards the item id to search
     * for
     *
     * @param itemId the id of the item to search for
     * @return the Item found
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public Category getCategory(int categoryId) throws Exception {
        CategoryDB categoryDB = new CategoryDB();
        Category category = categoryDB.get(categoryId);
        return category;
    }

    /**
     * Method that calls insertCategory() in CategoryDB
     *
     * @param categoryName category name
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public void insertCategory(String categoryName) throws Exception {
        Category category = new Category(0, categoryName);
        CategoryDB categoryDB = new CategoryDB();
        categoryDB.insert(category);
    }

    /**
     * Method that calls updateCategory() in CategoryDB
     *     
     * @param categoryId item category id
     * @param categoryName category name
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public void updateCategory(int categoryId, String categoryName) throws Exception {
        CategoryDB categoryDB = new CategoryDB();
        Category category = categoryDB.get(categoryId);
        category.setCategoryName(categoryName);
        categoryDB.update(category);
    }
}
