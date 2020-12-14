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
import models.Company;
import models.User;
import services.AccountService;

/**
 *
 * @author kornk
 */
public class SignupServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        session.invalidate();

        AccountService as = new AccountService();
        String uuid = request.getParameter("uuid");

        try {
            List<Company> companies = as.getAllCompanies();
            request.setAttribute("companies", companies);
        } catch (Exception ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        if (uuid != null) { // check if it is verification email
            String path = getServletContext().getRealPath("/WEB-INF");
            boolean validUuid = as.registerUser(uuid, path);
            if (validUuid) { // valid verification uuid
                request.setAttribute("userVerifiedMsg", true);
                getServletContext().getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
            } else { // invalid verification uuid
                request.setAttribute("expiredLink", true);
                getServletContext().getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
            }
        } else {    // forward to signup form
            getServletContext().getRequestDispatcher("/WEB-INF/signup.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountService as = new AccountService();

        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String password = request.getParameter("password");
        int company = Integer.parseInt(request.getParameter("companyName"));

        //check if user name and password are not empty
        if (email == null || email.equals("") || firstName == null || firstName.equals("") || lastName == null || lastName.equals("") || password == null || password.equals("")) {
            request.setAttribute("email", email);
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("password", password);
            request.setAttribute("emptiedField", true);

            //getServletContext().getRequestDispatcher("/WEB-INF/signup.jsp").forward(request, response);
            response.sendRedirect("signup");
            return;
        }

        //check if user name is already exist
        try {
            User exsitingUser = as.getUser(email);

            if (exsitingUser != null) {
                //request.setAttribute("exsitingUser", true);                
                //getServletContext().getRequestDispatcher("/WEB-INF/signup.jsp").forward(request, response);
                response.sendRedirect("signup");
            }
        } catch (Exception ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        //add a new user as inactive and send user a email to verify
        try {
            String path = getServletContext().getRealPath("/WEB-INF");
            String url = request.getRequestURL().toString(); // to get the current URL
            as.insertUser(email, false, firstName, lastName, password, company, 2, true, path, url);
        } catch (Exception ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("verifyEmailSent", true);
        getServletContext().getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
    }
}
