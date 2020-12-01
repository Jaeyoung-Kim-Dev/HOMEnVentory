package servlets;

import java.io.*;
import java.util.StringTokenizer;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.User;
import services.AccountService;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String logout = request.getParameter("logout");

        // if logout parameter passes invalidate session and forward to login
        if (logout != null) {
            session.invalidate();
            request.setAttribute("logout", true);
            getServletContext().getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
        }

        String email = (String) session.getAttribute("email");

        AccountService as = new AccountService();
        User user = null;
        try {
            user = as.getUser(email);
        } catch (Exception ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        // forward to the login page, but redirect to inventory or admin page if a user signed in.
        if (email == null) {
            getServletContext().getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
        } else if (user.getRole().getRoleId() == 1 || user.getRole().getRoleId() == 3) {
            response.sendRedirect("admin");
        } else {
            response.sendRedirect("inventory");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        //validates that user name and password are not empty
        if (email == null || email.equals("") || password == null || password.equals("")) {
            request.setAttribute("email", email);
            request.setAttribute("password", password);
            request.setAttribute("emptiedField", true);

            getServletContext().getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
            return;
        }

        AccountService as = new AccountService();
        String path = getServletContext().getRealPath("/WEB-INF");
        User user = as.login(email, password, path);
        if (user == null) {
            request.setAttribute("invalid", true);
            getServletContext().getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("email", email);

        if (user.getRole().getRoleId() == 1) {
            response.sendRedirect("admin");
        } else {
            response.sendRedirect("inventory");
        }
    }
}
