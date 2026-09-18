package com.lms.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.lms.dao.DashboardDao;
import com.lms.pojo.DashboardStats;
import com.lms.util.DbUtil;

public class DashboardDaoImpl implements DashboardDao{
	
	private final String TOTAL_BOOK = "Select COUNT(*) from books";
	private final String TOTAL_USER = "Select COUNT(*) from users where role ='USER'";
	
	private final String BOOK_STATUS = "Select COUNT(*) from book_issued where status = ?";
	
	private int fetchCount(String sql) {
		return fetchCount(sql,null);
	}
	
	private int fetchCount(String sql,String status) {
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        int count = 0;
        
        try {
            conn = DbUtil.getConnection();
            ps = conn.prepareStatement(sql);
            
            if(status != null) {
            	ps.setString(1, status);
            }
            
            rs = ps.executeQuery();

            if (rs.next()) {
            	count = rs.getInt(1);
            }

        } catch (Exception e) {
            throw new RuntimeException("Error fetching books", e);
        }
        finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
		return count;
	}
	
	@Override
	public DashboardStats fetchDashboardStats() {
		int totalBook = fetchCount(TOTAL_BOOK);
		int totalUser = fetchCount(TOTAL_USER);
		int bookAssigned = fetchCount(BOOK_STATUS,"ISSUED");
		int bookReturn= fetchCount(BOOK_STATUS,"RETURN");
		
		
		DashboardStats dashboardStats = new DashboardStats();
		dashboardStats.setTotalBooks(totalBook);
		dashboardStats.setTotalUsers(totalUser);
		dashboardStats.setBoooksAssigned(bookAssigned);
		dashboardStats.setBooksReturned(bookReturn);
		
		return dashboardStats;
        
	}

}
