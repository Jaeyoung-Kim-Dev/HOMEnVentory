package servlets;

import dataaccess.UserDB;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.User;
import services.AccountService;

public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDB userDB = new UserDB();
        String uuid = request.getParameter("uuid");
        User user = userDB.getByResetPasswordUUID(uuid);

        if (uuid != null && user != null) { // valid reset uuid
            request.setAttribute("uuid", uuid);
            getServletContext().getRequestDispatcher("/WEB-INF/resetNewPassword.jsp").forward(request, response);
        } else if (uuid != null && user == null) { // invalid reset uuid
            request.setAttribute("expiredLink", true);
            getServletContext().getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
        } else {  // send reset email form
            getServletContext().getRequestDispatcher("/WEB-INF/reset.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("newpassword");
        String uuid = request.getParameter("uuid");

        AccountService as = new AccountService();
        String path = getServletContext().getRealPath("/WEB-INF");
        String url = request.getRequestURL().toString(); // to get the current URL

        if (uuid != null) {
            as.changePassword(uuid, password);
            request.setAttribute("passwordChanged", true);
            getServletContext().getRequestDispatcher("/WEB-INF/resetNewPassword.jsp").forward(request, response);
        } else {
            as.resetPassword(email, path, url);
            request.setAttribute("resetEmailSent", true);
            getServletContext().getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
        }
    }
}
