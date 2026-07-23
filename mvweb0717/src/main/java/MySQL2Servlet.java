

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Employee;
import model.EmployeeDAO;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class MySQL2Servlet
 */
@WebServlet("/mysql2")
public class MySQL2Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MySQL2Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		EmployeeDAO dao=new EmployeeDAO();
		String city=request.getParameter("city");
		if(city==null || city=="")
			city="Boston";
		int data=dao.execGetEmpCountInOffice(city);
		request.setAttribute("num", data);
		request.setAttribute("city", city);
		request.getRequestDispatcher("empcount.jsp").forward(request, response);
		//response.getWriter().append("Employees in "+city+ " has "+data+" people");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
