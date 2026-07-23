import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns= {"/hello"})
public class HelloServlet extends HttpServlet {
	private static final Logger logger = Logger.getLogger(HttpServlet.class.getName());
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// TODO Auto-generated method stub
//		super.doGet(req, resp);
		logger.info("收到 GET 請求：" + req.getRequestURI());
		
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String currentTime = now.format(formatter);
        String star="";
        int N=11;
        for(int i=0;i<N;i++)
        {
        	for(int j=0;j<N;j++)
        	{
        		if(i==j||i==(N-1-j))
        			star+="*";
        		else
        			star+=" ";
        	}
        	star+="\n";
        }
		resp.getWriter().append("Hello World!!!\nnow time: "+currentTime+"\n"+star);
		}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		super.doPost(req, resp);
//		resp.getWriter().append("Post Hello World!!!");
		logger.info("收到 POST 請求：" + req.getRequestURI());
		String n=req.getParameter("username");
		System.out.println("input name is "+n);
		resp.getWriter().append("Post User Name is "+n);
        resp.setContentType("text/html;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
	}

}
