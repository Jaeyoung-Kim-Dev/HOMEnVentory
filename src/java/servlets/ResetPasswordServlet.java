package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import services.AccountService;

public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uuid = request.getParameter("uuid");

        if (uuid != null) {
            request.setAttribute("uuid", uuid);
            getServletContext().getRequestDispatcher("/WEB-INF/resetNewPassword.jsp").forward(request, response);
        } else {
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
            getServletContext().getRequestDispatcher("/WEB-INF/reset.jsp").forward(request, response);
        } else {
            as.resetPassword(email, path, url);
            request.setAttribute("resetEmailSent", true);
            getServletContext().getRequestDispatcher("/WEB-INF/reset.jsp").forward(request, response);
        }
    }
}
