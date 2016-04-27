/**
 * 
 */
package baoda.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import baoda.dao.UserMapper;
import baoda.domain.FinishedGameForAUser;
import baoda.domain.NewGame;
import baoda.domain.User;
import baoda.service.UserServiceInterface;

/**
 *<p>UserServiceImpl</p>
 *
 *<p>Description:</p>
 *
 * @author py
 *
 * @date 2016年4月5日
 */
@Service("userService") 
public class UserServiceImpl implements UserServiceInterface{
	@Resource
	private UserMapper uDao;
	/* (non-Javadoc)
	 * @see service.UserServiceInterface#getUserById(int)
	 */
	@Override
	public User getUserById(int id) {
		return uDao.selectByPrimaryKey(id);
	}
	/* (non-Javadoc)
	 * @see baoda.service.UserServiceInterface#getUserByUnAndPw(java.lang.String, java.lang.String)
	 */
	@Override
	public User getUserByUnAndPw(String un, String pw) {
		return uDao.selectByUserNameAndPassWord(un, pw);
	}
	/* (non-Javadoc)
	 * @see baoda.service.UserServiceInterface#createUesr(baoda.domain.User)
	 */
	@Override
	public User createUesr(User u) {
		int ucn = uDao.countByUserName(u.getUserName());
		if(ucn > 0) return null;
		int id = uDao.insert(u);
//		u.setId(id);
		return u;
	}
	/* (non-Javadoc)
	 * @see baoda.service.UserServiceInterface#updateUserPoint(int, int)
	 */
	@Override
	public int updateUserPoint(int id, int up) {
		System.out.println(id+"  "+up+"##");
		User u = uDao.selectByPrimaryKey(id);
		int np = u.getPoints() + up;
		if(np < 0) np = 0;
		u.setPoints(np);
		System.out.println(u.getId()+"  "+u.getNickName()+"  "+u.getPoints());
		uDao.updateByPrimaryKeySelective(u);
		return np;
	}
	/* (non-Javadoc)
	 * @see baoda.service.UserServiceInterface#getUserByGameId(int)
	 */
	@Override
	public List<User> getUserByGameId(int gid) {
		return uDao.selectByGid(gid);
		
	}
	/* (non-Javadoc)
	 * @see baoda.service.UserServiceInterface#getUserSortedByPoints()
	 */
	@Override
	public List<User> getUserSortedByPoints() {
		return uDao.selectAllOrderByPoints();
	}
	/* (non-Javadoc)
	 * @see baoda.service.UserServiceInterface#getFinishedGameForAuserSortedByTime()
	 */

}

