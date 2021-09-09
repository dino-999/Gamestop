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
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Dino
 */
public class EditGameServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditGameServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditGameServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            Repository repo = RepoFactory.getRepository();
            List<Game> games = (List<Game>) request.getSession().getAttribute("games");
            String id= request.getParameter("id");
             HttpSession session = request.getSession();
            
            Game game= null;
            try {
                game = repo.selectGame(Integer.parseInt(id));
            } catch (Exception ex) {
                Logger.getLogger(EditGameServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            if (game != null) {

                String name = request.getParameter("name");
                Double price = Double.parseDouble(request.getParameter("price"));
                String cat = request.getParameter("category");
                List<Category> cats = (List<Category>) request.getSession().getAttribute("cat");
                game.setName(name);
                game.setPrice(price);
                for (Category c : cats) {
                    if (c.getName().equals(cat)) {
                        game.setCategory(c);
                    }
                }

                try {
                    games.add(game);
                    session.setAttribute("games", games);
                    
                    repo.updateGame(Integer.parseInt(id), game);
                    response.sendRedirect("edit.jsp");

                } catch (Exception e) {
                    e.printStackTrace();
                }
                
                
                
            } else {

                response.sendRedirect("edit.jsp");

            }

        }
    }

}
