package cs320.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EC/Search")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final String GOOGLE_API_KEY  = "AIzaSyDv_0sVA5OuZzQuulNUuP6gkYKMWt88vwk";
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//
//		Factual factual = new Factual("Mr25g98S8V3gAyA7bGEbW8XjdNEpy9ZRL7MWv3xh", 
//				"PT8e66XRcxilRXiE4USqDPTfZP3kFH331yPN3wQ7");
		request.getRequestDispatcher("/WEB-INF/EC/Search.jsp").forward(request, response);
	}
	
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
    	
    	double latitude = Double.valueOf(request.getParameter("lat"));
    	double longitude = Double.valueOf(request.getParameter("lon"));
    	double radius = Double.valueOf(request.getParameter("radius"));
     	
    doGet(request, response);
   	
    } 
}
