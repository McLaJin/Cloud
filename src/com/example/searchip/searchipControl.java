package com.example.searchip;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class BeerSelectionControl
 */
//@WebServlet("/BeerSelectionControl")
 public class searchipControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public searchipControl() {
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
		
		/* version 1.0
		// step #1. get input parameters
		request.setCharacterEncoding("UTF-8");
		
		String color = request.getParameter("color");
		
		// step #2. data processing
		
		// step #3. output processing results
		PrintWriter out = response.getWriter();
		
		out.println("User selected color :" + color);
		*/
		
		
		
		// step #1. get input parameters
		request.setCharacterEncoding("UTF-8");
		
		String ip = request.getParameter("ip");
		
		// step #2. data processing
		
		
		// step #3. output processing results
		request.setAttribute("ip", ip); //¹¹ÇÏ´Â°ÅÁö?
		
		RequestDispatcher view = request.getRequestDispatcher("index2.jsp");
		view.forward(request, response);
		
		
	}

}