/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algebra.servlet;

import hr.algebra.model.Category;
import hr.algebra.model.Game;
import hr.algerba.connection.RepoFactory;
import hr.algerba.connection.Repository;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Dino
 */
@MultipartConfig
public class AddGameServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddGameServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddGameServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Repository repo = RepoFactory.getRepository();

        String name = request.getParameter("name");
        Double price = Double.parseDouble(request.getParameter("price"));
        String category = request.getParameter("category");
        if (category == null) {
            category = "PC";
        }

       

        String imageUrl = "assets/game.jpg";
        
        

        

            List<Game> games = (List<Game>) request.getSession().getAttribute("games");
            Category cat = null;
            List<Category> cats = (List<Category>) request.getSession().getAttribute("cat");
            for (Category c : cats) {
                if (c.getName().equals(category)) {
                    cat = c;
                }
            }

            HttpSession session = request.getSession();
            Game game = new Game(name, price, imageUrl, cat);
            try {
                repo.createGame(game);
                games.add(game);
                session.setAttribute("games", games);
                response.sendRedirect("edit.jsp");

            } catch (Exception ex) {
                Logger.getLogger(AddGameServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

        

    }

 

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
