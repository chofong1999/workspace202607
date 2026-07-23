

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class HelloServlet
 */
@WebServlet("/hello")
public class HelloServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, 
                        HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        String name = request.getParameter("name");
        
        if (name == null || name.trim().isEmpty()) {
            name = "訪客";
        }
        
        response.getWriter().println(
            "<h1>Hello, " + name + "!</h1>" +
            "<p>歡迎使用 Jakarta EE 10 + Tomcat 10.1</p>"
        );
    }
}
