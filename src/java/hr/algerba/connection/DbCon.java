/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hr.algerba.connection;

import com.microsoft.sqlserver.jdbc.SQLServerDataSource;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.sql.DataSource;

/**
 *
 * @author Dino
 */
public class DbCon {
 private static final String SERVER_NAME = "localhost";
    private static final String DATABASE_NAME = "Gamestop";
    private static final String USERNAME = "sas";
    private static final String PASS = "SQL";
    
    private static DataSource instance;
    
    public static DataSource getInstance() {
        if (instance == null) 
        {
            synchronized (DataSource.class) 
            {
                if (instance == null) {
                    instance = createInstance();
                }
            }
        }      
        return instance;
        
        
    }

    private static DataSource createInstance() {
        SQLServerDataSource dataSource = new SQLServerDataSource();
        dataSource.setServerName(SERVER_NAME);
        dataSource.setDatabaseName(DATABASE_NAME);
        dataSource.setUser(USERNAME);
        dataSource.setPassword(PASS);
        return dataSource; //To change body of generated methods, choose Tools | Templates.
    }
}
