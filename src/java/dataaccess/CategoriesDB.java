/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataaccess;

import java.util.List;
import javax.persistence.EntityManager;
import models.Category;

/**
 *
 * @author kornk
 */
public class CategoriesDB {

    /**
     * Method that returns all rows in the User table
     *
     * @return a List of Users
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public List<Category> getAll() {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();

        try {
            List<Category> Categories = em.createNamedQuery("Category.findAll", Category.class).getResultList();
            return Categories;
        } finally {
            em.close();
        }
    }

    /**
     * Method for getting a row from the Category database based off their ID
     *
     * @param categoryId the ID to of the Category to return
     * @return the Category that matches the Category ID
     */
    public Category get(int categoryId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();

        try {
            Category category = em.find(Category.class, categoryId);
            return category;
        } finally {
            em.close();
        }
    }
}
