/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algebra.listeners;

import hr.algebra.domain.SessionInfo;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Web application lifecycle listener.
 *
 * @author Dino
 */
public class SessionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        System.out.println("Session created!");
        ServletContext context
                = se.getSession().getServletContext();

        String sessionId = se.getSession().getId();
        LocalDateTime sessionCreationTime = LocalDateTime.now();
        String ipadress = se.getSession().getServletContext().getServerInfo();
        
       
        
            SessionInfo sessionInfo  = new SessionInfo(sessionId, sessionCreationTime);
        

        if (context.getAttribute("sessionList") == null) {
            List<SessionInfo> sessionList = new ArrayList<>();
            sessionList.add(sessionInfo);
            context.setAttribute("sessionList", sessionList);
        } else {
            ((List<SessionInfo>) context.getAttribute("sessionList"))
                    .add(sessionInfo);
        }
    }


    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
