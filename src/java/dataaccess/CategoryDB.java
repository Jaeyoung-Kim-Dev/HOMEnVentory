/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataaccess;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import models.Category;
import models.Item;
import models.Role;
import models.User;

/**
 *
 * @author kornk
 */
public class CategoryDB {

    /**
     * Method that returns all rows in the User table
     *
     * @return a List of Categories
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
    
    public void insert(Category category) throws Exception {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {                        
            trans.begin();
            em.persist(category);
            trans.commit();
        } catch (Exception ex) {
            trans.rollback();
        } finally {
            em.close();
        }
    }

    public void update(Category category) throws Exception {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {
            trans.begin();
            em.merge(category);
            trans.commit();
        } catch (Exception ex) {
            trans.rollback();
        } finally {
            em.close();
        }
    }
}
