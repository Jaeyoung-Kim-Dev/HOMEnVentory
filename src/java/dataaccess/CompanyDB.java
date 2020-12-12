package dataaccess;

import java.util.List;
import javax.persistence.EntityManager;
import models.Company;
import models.Role;

/**
 * Class responsible for performing SQL commands on the database in relation to
 * Roles
 */
public class CompanyDB {

    /**
     * Method that returns all the rows in the Role table
     *
     * @return a List of Roles
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public List<Company> getAll() throws Exception {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();

        try {
            List<Company> Companies = em.createNamedQuery("Company.findAll", Company.class).getResultList();
            return Companies;
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
    public Company get(int companyId) throws Exception {
        // Return the Role with the id passed in
        EntityManager em = DBUtil.getEmFactory().createEntityManager();

        try {
            Company company = em.find(Company.class, companyId);
            return company;
        } finally {
            em.close();
        }
    }
}
