

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class SubmitTestServlet
 */
@WebServlet("/submitTest")
public class SubmitTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubmitTestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String n1=request.getParameter("num1");
		String n2=request.getParameter("num2");
		String sb=request.getParameter("submit");
		switch(sb) {
		case "add":
			int value=Integer.parseInt(n1)+Integer.parseInt(n2);
			response.getWriter().append("add: ").append(""+value);
			break;
		case "multiply":
			int value2=Integer.parseInt(n1)*Integer.parseInt(n2);
			response.getWriter().append("Multiply: ").append(""+value2);
			break;
		default:
			response.getWriter().append("Invalid OP");
			break;
		}
	}

}
