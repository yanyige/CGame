/**
 * 
 */
package baoda.service;

import java.util.List;

import baoda.domain.FinishedGameForAUser;
import baoda.domain.User;

/**
 *<p>UesrServiceInterface</p>
 *
 *<p>Description:</p>
 *
 * @author py
 *
 * @date 2016年4月5日
 */
public interface UserServiceInterface {
	public User getUserById(int id);
	
	public User getUserByUnAndPw(String un, String pw);
	
	public User createUesr(User u);
	
	public int updateUserPoint(int id, int up);
	
	public List<User> getUserByGameId(int gid);
	
	public List<User> getUserSortedByPoints();
	
}
