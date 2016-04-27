/**
 * 
 */
package baoda.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import baoda.domain.FinishedGameForAUser;
import baoda.domain.NewGame;
import baoda.domain.Question;
import baoda.domain.User;
import baoda.service.GameServiceInterface;
import baoda.util.SystemCfg;

/**
 *<p>GameController</p>
 *
 *<p>Description:</p>
 *
 * @author py
 *
 * @date 2016年4月5日
 */
@Controller
@RequestMapping("/game")
@SessionAttributes("user")
public class GameController {
	@Resource
	private GameServiceInterface gameService;
	/**
	 * 
	* <p>Title:请求一次单人普通匹配游戏<／p>
	* <p>Description: <／p>
	*@param 
	*@return String
	 */
	@RequestMapping("/normal")  
	public String toNormal(Model model, @ModelAttribute("user") User user){
		//得到用户未完成的游戏
		NewGame ng = gameService.getUnfinishGame(user);
		if(ng == null){//如果当前用户没有未完成的游戏，新建一个游戏
			List<User> u = new ArrayList<>();
			u.add(user);
			ng = gameService.getNewGame(u);
			//启动延时任务，在游戏时间结束之后1s统计未提交答案的用户的成绩
			ScheduledExecutorService service = Executors
					.newSingleThreadScheduledExecutor();
			GameOverTask task = new GameOverTask(ng, gameService, service);
			service.schedule(task, SystemCfg._TIME_LIMIT_ + 1, TimeUnit.SECONDS);
		}
		//计算用户的游戏时间
		long nt = new Date().getTime();
		long ut = nt - Long.parseLong(ng.getTime());
		model.addAttribute("game",ng);
		model.addAttribute("lt", SystemCfg._TIME_LIMIT_);
		model.addAttribute("st", ut);
		return "game";
	}
	@RequestMapping("/submit")  
	public String submit(SubmitForm form, 
			Model model,@ModelAttribute("user") User user) throws InterruptedException{

		boolean can= gameService.finishGameForAUser(user, form.getGid(), form.getQa());
//		if(!can) Thread.sleep(1000);

		return "redirect:result?gid="+form.getGid();
	}

	@RequestMapping("/result")  
	public String result(int gid, 
			Model model,@ModelAttribute("user") User user){

		FinishedGameForAUser result = gameService.getNormalGameResult(user, gid);
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		result.setFtime(df.format(new Date(Long.parseLong(result.getFtime()))));
		result.setTime(df.format(new Date(Long.parseLong(result.getTime()))));

		model.addAttribute("result", result);
		return "result";
	}

}

class GameOverTask implements Runnable{//超过游戏时间限制，自动统计未提交用户的得分
	private NewGame ngame;
	private GameServiceInterface gs;
	private ScheduledExecutorService service;

	@Override
	public void run() {
		System.out.println("do it!");
		gs.finishGame(ngame);
		service.shutdown();
	}

	public GameOverTask(NewGame ngame, GameServiceInterface gs, ScheduledExecutorService service) {
		super();
		this.ngame = ngame;
		this.gs = gs;
		this.service = service;
	}
}
class SubmitForm{
	private int gid;
	private Map<Integer,String> qa;

	public int getGid() {
		return gid;
	}
	public void setGid(int gid) {
		this.gid = gid;
	}
	public Map<Integer, String> getQa() {
		return qa;
	}
	public void setQa(Map<Integer, String> qa) {
		this.qa = qa;
	}

}