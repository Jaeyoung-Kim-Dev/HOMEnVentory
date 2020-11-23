package dataaccess;

import java.util.List;
import javax.persistence.EntityManager;
import models.Role;

/**
 * Class responsible for performing SQL commands on the database in relation to
 * Roles
 */
public class RoleDB {

    /**
     * Method that returns all the rows in the Role table
     *
     * @return a List of Roles
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public List<Role> getAll() throws Exception {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();

        try {
            List<Role> roles = em.createNamedQuery("Role.findAll", Role.class).getResultList();
            return roles;
        } finally {
            em.close();
        }
    }

    /**
     * Method for getting a row from the Role database based off their ID
     *
     * @param roleId the ID to of the Role to return
     * @return the Role that matches the role ID
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public Role get(int roleId) throws Exception {
        // Return the Role with the id passed in
        EntityManager em = DBUtil.getEmFactory().createEntityManager();

        try {
            Role role = em.find(Role.class, roleId);
            return role;
        } finally {
            em.close();
        }
    }
}
