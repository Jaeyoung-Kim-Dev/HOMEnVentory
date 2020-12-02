package services;

import dataaccess.RoleDB;
import dataaccess.UserDB;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Role;
import models.User;

public class AccountService {

    /**
     *
     * @param email
     * @param password
     * @param path
     * @return
     */
    public User login(String email, String password, String path) {
        UserDB userDB = new UserDB();
        User user = userDB.get(email);

        try {
            if (password.equals(user.getPassword()) && user.getActive()) {
                Logger.getLogger(AccountService.class.getName()).log(Level.INFO, "Successful login by {0}", email);

                String to = user.getEmail();
                String subject = "HOME nVentory Login";
                String template = path + "/emailtemplates/login.html";

                HashMap<String, String> tags = new HashMap<>();
                tags.put("firstname", user.getFirstName());
                tags.put("lastname", user.getLastName());
                tags.put("date", (new java.util.Date()).toString());

                GmailService.sendMail(to, subject, template, tags);

                // if user didn't change password with email link and login, make the link invalid
                user.setResetPasswordUuid(null);
                userDB.update(user);

                return user;
            }
        } catch (Exception e) {
        }
        return null;
    }

    /**
     * Method that calls getAllUser() in UserDB
     *
     * @return the List of Users
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public List<User> getAllUser() throws Exception {
        UserDB userDB = new UserDB();
        List<User> users = userDB.getAll();
        return users;
    }

    /**
     * Method that calls getUser() in UserDB and forwards the email to search
     * for
     *
     * @param email the email of the user to search for
     * @return the User found
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public User getUser(String email) throws Exception {
        UserDB userDB = new UserDB();
        User user = userDB.get(email);
        return user;
    }

    /**
     * Method that calls insertUser() in UserDB
     *
     * @param email user email address
     * @param active user active or inactive
     * @param firstName user first name
     * @param lastName user last name
     * @param password user password
     * @param roleId user role id
     * @param newUser check if new user to send to welcome email
     * @param path path of the email form
     * @param url
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public void insertUser(String email, boolean active, String firstName, String lastName, String password, int roleId, boolean newUser, String path, String url) throws Exception {
        User user = new User(email, active, firstName, lastName, password);

        RoleDB roleDB = new RoleDB();
        Role role = roleDB.get(roleId);
        user.setRole(role);

        UserDB userDB = new UserDB();
        userDB.insert(user);

        if (newUser) {
            Logger.getLogger(AccountService.class.getName()).log(Level.INFO, "New registered user {0}", email);

            String to = user.getEmail();
            String subject = "Register for HOME nVentory";
            String template = path + "/emailtemplates/register.html";
            String uuid = UUID.randomUUID().toString();
            String link = url + "?uuid=" + uuid;

            user.setEmailVerifyUuid(uuid);
            userDB.update(user);

            HashMap<String, String> tags = new HashMap<>();
            tags.put("firstname", user.getFirstName());
            tags.put("lastname", user.getLastName());
            tags.put("link", link);
            tags.put("date", (new java.util.Date()).toString());

            GmailService.sendMail(to, subject, template, tags);
        }
    }

    public boolean registerUser(String uuid, String path) {
        UserDB userDB = new UserDB();
        try {
            User user = userDB.getByEmailVerifyUUID(uuid);
            user.setActive(true);
            user.setEmailVerifyUuid(null);
            userDB.update(user);

            String to = user.getEmail();
            String subject = "Welcome to HOME nVentory";
            String template = path + "/emailtemplates/welcome.html";

            HashMap<String, String> tags = new HashMap<>();
            tags.put("firstname", user.getFirstName());
            tags.put("lastname", user.getLastName());

            GmailService.sendMail(to, subject, template, tags);

            Logger.getLogger(AccountService.class.getName()).log(Level.INFO, "Successful welcome email sent to {0}", to);
            return true;
        } catch (Exception ex) {
            return false;
        }
    }

    /**
     * Method that calls updateUser() in UserDB
     *
     * @param email user email address
     * @param active user active or inactive
     * @param firstName user first name
     * @param lastName user last name
     * @param password user password
     * @param roleId user role id
     *
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public void updateUser(String email, boolean active, String firstName, String lastName, String password, int roleId) throws Exception {
        UserDB userDB = new UserDB();
        User user = userDB.get(email);
        user.setActive(active);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setPassword(password);

        RoleDB roleDB = new RoleDB();
        Role role = roleDB.get(roleId);
        user.setRole(role);

        userDB.update(user);
    }

    /**
     * Method that calls deleteUser() in UserDB
     *
     * @param email the email of the user to be deleted
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public void deleteUser(String email) throws Exception {
        UserDB userDB = new UserDB();
        User user = userDB.get(email);
        userDB.delete(user);
    }

    /**
     * Method that calls getAllRoles() in RoleDB
     *
     * @return the List of Users
     * @throws Exception if there is a Exception with PreparedStatements and
     * ResultSets
     */
    public List<Role> getAllRoles() throws Exception {
        RoleDB roleDB = new RoleDB();
        List<Role> roles = roleDB.getAll();
        return roles;
    }

    public boolean resetPassword(String email, String path, String url) {
        UserDB userDB = new UserDB();

        try {
            User user = userDB.get(email);
            String to = user.getEmail();
            String subject = "HOME nVentory Reset Password";
            String template = path + "/emailtemplates/resetpassword.html";
            String uuid = UUID.randomUUID().toString();
            String link = url + "?uuid=" + uuid;

            user.setResetPasswordUuid(uuid);
            userDB.update(user);

            HashMap<String, String> tags = new HashMap<>();
            tags.put("firstname", user.getFirstName());
            tags.put("lastname", user.getLastName());
            tags.put("link", link);

            GmailService.sendMail(to, subject, template, tags);
            return true;
        } catch (Exception ex) {
            return false;
        }
    }

    public boolean changePassword(String uuid, String password) {
        UserDB userDB = new UserDB();
        try {
            User user = userDB.getByResetPasswordUUID(uuid);
            user.setPassword(password);
            user.setResetPasswordUuid(null);
            userDB.update(user);
            return true;
        } catch (Exception ex) {
            return false;
        }
    }
}
