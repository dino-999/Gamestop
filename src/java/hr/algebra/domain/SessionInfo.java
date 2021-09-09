/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algebra.domain;

import hr.algebra.model.User;
import java.time.LocalDateTime;

/**
 *
 * @author Dino
 */
public class SessionInfo {

    private String sessionId;
    private String ipadress;
    private User user;
    private LocalDateTime sessionCreationTime;

    public SessionInfo(String sessionId, String ipadress, LocalDateTime sessionCreationTime, User user) {
        this.sessionId = sessionId;
        this.ipadress = ipadress;
        this.sessionCreationTime = sessionCreationTime;
        this.user = user;
    }

    public SessionInfo(String sessionId, LocalDateTime sessionCreationTime) {
        this.sessionId = sessionId;

        this.sessionCreationTime = sessionCreationTime;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getIpadress() {
        return ipadress;
    }

    public void setIpadress(String ipadress) {
        this.ipadress = ipadress;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public LocalDateTime getSessionCreationTime() {
        return sessionCreationTime;
    }

    public void setSessionCreationTime(LocalDateTime sessionCreationTime) {
        this.sessionCreationTime = sessionCreationTime;
    }
}
