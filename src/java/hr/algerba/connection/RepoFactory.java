/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algerba.connection;

import hr.algebra.dao.RepositorySQL;

/**
 *
 * @author Dino
 */
public class RepoFactory {
     public static Repository getRepository() {
        return new RepositorySQL();
    }    
}
