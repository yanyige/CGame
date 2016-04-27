/**
 * 
 */
package baoda.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import baoda.dao.GameMapper;
import baoda.dao.QuestionMapper;
import baoda.dao.ResultMapper;
import baoda.dao.UserGameRelationMapper;
import baoda.dao.UserMapper;
import baoda.domain.FinishedGameForAUser;
import baoda.domain.Game;
import baoda.domain.NewGame;
import baoda.domain.Question;
import baoda.domain.QuestionWithAnswer;
import baoda.domain.Result;
import baoda.domain.User;
import baoda.domain.UserGameRelation;
import baoda.domain.UserGameRelationKey;
import baoda.service.GameServiceInterface;
import baoda.service.UserServiceInterface;
import baoda.util.SystemCfg;

/**
 *<p>GameServiceImpl</p>
 *
 *<p>Description:</p>
 *
 * @author py
 *
 * @date 2016年4月5日
 */
@Service("gameService")
public class GameServiceImpl  implements GameServiceInterface{
	@Resource
	private QuestionMapper qDao ;
	@Resource
	private ResultMapper rDao;
	@Resource
	private GameMapper gDao;
	@Resource
	private UserGameRelationMapper ugrDao;
	@Resource
	private UserMapper uDao;
	@Resource
	private UserServiceInterface us;
	/* (non-Javadoc)
	 * @see baoda.service.GameServiceInterface#getNewGame()
	 */
	@Override
	public NewGame getNewGame(List<User> users) {
		NewGame ng = new NewGame();
		ng.setTime(Long.toString(new Date().getTime()));
		gDao.insert(ng);
		Map<Integer,Integer> lcn = new HashMap<>();
		//确定题目的级别(出现最频繁的user level)
		for(User u : users){
			int level = u.getLevel();
			if(lcn.containsKey(level)){
				lcn.put(level, lcn.get(level) + 1);
			}else 
				lcn.put(level, 1);
		}
		int max = -1;
		int maxLevel = -1;
		for (Entry<Integer,Integer> e : lcn.entrySet()){
			if(max < e.getValue()){
				max = e.getValue();
				maxLevel = e.getKey();
			}
		}
		// 随机挑选题目
		List<Question> questions = qDao.selectRandomNByLevel(3, maxLevel);
		for (User u : users){
			// 为user和game之间建立关系
			UserGameRelation ugr = new UserGameRelation();
			ugr.setFinishTime("NULL");
			ugr.setPoint(0.0);
			ugr.setgId(ng.getId());
			ugr.setuId(u.getId());
			ugrDao.insert(ugr);

			for(Question q : questions){
				// 生成每个user回答每个question的结果
				Result r = new Result();
				r.setqId(q.getId());
				r.setgId(ng.getId());
				r.setuId(u.getId());
				rDao.insert(r);
			}
		}

		ng.setQuestions(questions);
		ng.setUser(users);

		return ng;
	}

	@Override
	public boolean finishGame(NewGame ng) {
		long useTime = SystemCfg._TIME_LIMIT_ * 1000 ;
		//得到所有未完成本场游戏的所有用户（FinishTime为"null"）
		List<UserGameRelation>ugrl = ugrDao.selectByGidAndFinishTimeIsNull(ng.getId());
		for (UserGameRelation ugr : ugrl){
			//得到本场游戏的题目
			List<Question> questions = ng.getQuestions();
			//将未提交用户的题目答案更新为“null”
			rDao.batchUpdateAnswer2NULLbyUGQL(ugr.getuId(), ugr.getgId(), questions);
			List<Result> rl = rDao.selectByUidAndGid(ugr.getuId(), ugr.getgId());
			//我这愚蠢的设计！！
			//将未提交用户完成游戏的时间设置为游戏限制时间
			ugr.setFinishTime(Long.toString(Long.valueOf(ng.getTime()) + useTime));
			//计算分数
			double point = cPoints(ng.getQuestions(), rl, useTime / 1000);
			ugr.setPoint(point);
			ugrDao.updateByPrimaryKey(ugr);
			us.updateUserPoint(ugr.getuId(), (int)(point + 0.5));
			}
		return true;
	}
	private double cPoints(List<Question> questions, List<Result> rl, long useTime){
		Map<Integer, String > ans = new HashMap<>();
		for(Question q : questions){
			ans.put(q.getId(), q.getAnswer());
		}
		int rcn = 0;
		int wcn = 0;
		for (Result r : rl){
			if(r.getAnswer().equals(ans.get(r.getqId())))
				rcn ++;
			else 
				wcn ++;
		}

		double point = rcn * SystemCfg._TIME_LIMIT_ / useTime  - 0.5 * wcn; 
		return point;
	}

	@Override
	public NewGame getUnfinishGame(User u) {//从数据库中得到当前用户还未完成的游戏
		UserGameRelation ugr = ugrDao.selectByUidAndFinishTimeIsNULL(u.getId());
		if(ugr == null) return null;
		List<User> user =us.getUserByGameId(ugr.getgId());
		NewGame ng = new NewGame();
		ng.setId(ugr.getgId());
		ng.setUser(user);
		Game g = gDao.selectByPrimaryKey(ugr.getgId());
		ng.setTime(g.getTime());
		List<Question> ql = qDao.selectByUidAndGid(ugr.getuId(), ugr.getgId());
		ng.setQuestions(ql);
		return ng;
	}


	@Override
	public boolean finishGameForAUser(User user, int gid, Map<Integer, String> qa) {
		long nt = new Date().getTime();
		Game game = gDao.selectByPrimaryKey(gid);
		long ut = nt - Long.parseLong(game.getTime()) ;
		ut /= 1000;
		//根据用户id和游戏id得到题目列表
		List<Question> ql = qDao.selectByUidAndGid(user.getId(), gid);
		//得到用户游戏关系
		UserGameRelationKey key = new UserGameRelationKey();
		key.setgId(gid);
		key.setuId(user.getId());
		UserGameRelation ugr = ugrDao.selectByPrimaryKey(key);
		if(ugr.getFinishTime().equals("NULL") && ut <= SystemCfg._TIME_LIMIT_){
			//更新本次游戏用户答题结果集
			rDao.batchUpdateAnswerbyUGQAM(user.getId(), gid,qa);
			//得到更新后的结果集
			List<Result> rl = rDao.selectByUidAndGid( user.getId(),gid);

			//根据正确答案计算答题分数
			double point = cPoints(ql, rl, ut);
			//更新用户游戏关系的得分,完成时间
			ugr = new UserGameRelation();
			//更新用户得分
			int npoint = us.updateUserPoint(user.getId(), (int)(point + 0.5));
			user.setPoints(npoint);
			ugr.setgId(gid);
			ugr.setuId(user.getId());
			ugr.setPoint(point);
			ugr.setFinishTime(Long.toString(nt));
			ugrDao.updateByPrimaryKeySelective(ugr);
			return true;
		}
		return false;
		
	}
	private FinishedGameForAUser buildFinishedGameForAUser(int gid, User user, UserGameRelation ugr){
		Game game = gDao.selectByPrimaryKey(gid);
		FinishedGameForAUser fg = new FinishedGameForAUser();
		fg.setId(gid);
		fg.setTime(game.getTime());
		//根据用户id和游戏id得到题目列表
		List<Question> ql = qDao.selectByUidAndGid(user.getId(), gid);
		//得到结果集
		List<Result> rl = rDao.selectByUidAndGid(user.getId(),gid );
		Map<Integer,String> rmap = new HashMap<>();
		for (Result rs : rl){
			rmap.put(rs.getqId(), rs.getAnswer());
		}
		//构造包含正确答案和用户答案的题目列表
		List<QuestionWithAnswer> qwal = new ArrayList<>();
		for(Question q : ql){
			QuestionWithAnswer qwa = new QuestionWithAnswer();
			qwa.setId(q.getId());
			qwa.setAnswer(q.getAnswer());
			qwa.setContent(q.getContent());
			qwa.setLevel(q.getLevel());
			qwa.setNanswer(rmap.get(q.getId()));
			qwal.add(qwa);

		}
		fg.setQwas(qwal);
	
		fg.setFtime(ugr.getFinishTime());
		fg.setUser(user);
		fg.setPonits(ugr.getPoint());
		return fg;
	}
	/* (non-Javadoc)
	 * @see baoda.service.GameServiceInterface#getNormalGameResult(baoda.domain.User, int)
	 */
	@Override
	public FinishedGameForAUser getNormalGameResult(User user, int gid) {
		//得到用户游戏关系
		UserGameRelationKey key = new UserGameRelationKey();
		key.setgId(gid);
		key.setuId(user.getId());
		UserGameRelation ugr = ugrDao.selectByPrimaryKey(key);
		
		return buildFinishedGameForAUser(gid, user, ugr);
	}

	/* (non-Javadoc)
	 * @see baoda.service.GameServiceInterface#getNormalGameResultList(baoda.domain.User)
	 */
	@Override
	public List<FinishedGameForAUser> getNormalGameResultList(User user) {
		List<FinishedGameForAUser> fgl = new ArrayList<>();
		List<UserGameRelation> ugrl = ugrDao.selectByUid(user.getId());
		for (UserGameRelation ugr : ugrl){
			int gid = ugr.getgId();
			fgl.add(buildFinishedGameForAUser(gid, user, ugr));
		}
		return fgl;
	}


}

