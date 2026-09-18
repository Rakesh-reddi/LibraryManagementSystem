package com.lms.daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lms.dao.UserDao;
import com.lms.pojo.Book;
import com.lms.pojo.User;
import com.lms.util.DbUtil;


public class UserDaoImpl implements UserDao 
{

	@Override
	public User checkLogin(String username, String password) {
		
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		
		
		try {
			String sql = "Select * from users where email = ? AND password = ?";
			
			conn = (Connection) DbUtil.getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, password);
			

			
			rs = ps.executeQuery();
			if(rs.next()) {
				
				User user = new User();
				user.setFirstName(rs.getString("first_name"));
				user.setLastName(rs.getString("last_name"));
				user.setEmail(rs.getString("email"));
				user.setAddress(rs.getString("address"));
				user.setPhoneNo(rs.getString("phone_no"));
				
				
				return user;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
				
			}
			
		}
		return null;
	}

	@Override
	public boolean addUser(User user) {
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String sql = "Insert into users(first_name, last_name, email, password, role, phone_no, address, created_at)"
                       + " values(?,?,?,?,?,?,?,?)";

            conn = DbUtil.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole());
            ps.setString(6, user.getPhoneNo());
            ps.setString(7, user.getAddress());
            ps.setDate(8, user.getCreatedAt());

            int i = ps.executeUpdate();
            if (i > 0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
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
        return false;
	}

	@Override
	public List<User> getAllUserList() {
		
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        ArrayList<User> userList = new ArrayList<>();

        try {
            String sql = "Select * from users where role = 'USER' order by user_id desc";

            conn = DbUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User();

                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setUserId(rs.getLong("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPhoneNo(rs.getString("phone_no"));
                
                userList.add(user);
                
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

		return userList;
	}

	@Override
	public User getUserById(long userId) {
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;


        try {
            String sql = "Select * from users where role = 'USER' and user_id = ?";

            conn = DbUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setLong(1,userId);
            
            rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User();

                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setUserId(rs.getLong("user_id"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setPhoneNo(rs.getString("phone_no"));
                
                return user;
                
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

		return null;
	}

	@Override
	public boolean updateUser(User user) {
		
		Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String sql = "update users set first_name=?,last_name=?, phone_no=?, address=? "
            		+ "where user_id=?";

            conn = DbUtil.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getPhoneNo());
            ps.setString(4, user.getAddress());
            
            ps.setLong(5, user.getUserId());

            int i = ps.executeUpdate();
            if (i > 0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
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
		
		return false;
	}
	

}
