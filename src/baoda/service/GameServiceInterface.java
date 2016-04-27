/**
 * 
 */
package baoda.service;

import java.util.List;
import java.util.Map;

import baoda.domain.FinishedGameForAUser;
import baoda.domain.NewGame;
import baoda.domain.User;

/**
 *<p>GameServiceInterface</p>
 *
 *<p>Description:</p>
 *
 * @author py
 *
 * @date 2016年4月5日
 */
public interface GameServiceInterface {
	public NewGame getNewGame(List<User> u);
	public NewGame getUnfinishGame(User u);
	public boolean finishGame(NewGame ng);
	public boolean finishGameForAUser(User user,int gid, Map<Integer,String> qa);
	public FinishedGameForAUser getNormalGameResult(User user,int gid);
	public List<FinishedGameForAUser> getNormalGameResultList(User user);
}
