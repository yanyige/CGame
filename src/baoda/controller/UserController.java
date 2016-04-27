/**
 * 
 */
package baoda.controller;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Scanner;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import baoda.dao.GameMapper;
import baoda.dao.UserMapper;
import baoda.domain.FinishedGameForAUser;
import baoda.domain.NewGame;
import baoda.domain.Question;
import baoda.domain.User;
import baoda.service.GameServiceInterface;
import baoda.service.UserServiceInterface;

/**
 *<p>UserController</p>
 *
 *<p>Description:</p>
 *
 * @author py
 *
 * @date 2016年4月5日
 */
@Controller
@RequestMapping("/")
public class UserController {
	@Resource
	private UserServiceInterface userService;
	@Resource
	private GameServiceInterface gameService;
	@Resource
	private GameMapper udo;
	@RequestMapping("/signin")  
	public String signin(String un,String pw, HttpSession httpSession){  
		User user = this.userService.getUserByUnAndPw(un, pw);
		if(user == null) return "redirect:index";  
		httpSession.setAttribute("user", user);
		return "redirect:index";  
	}
	@ResponseBody  
	@RequestMapping("/signup")
	public boolean signup(String un,  String pw1,  String pw2, String nickName){
		if(un == null || pw1 == null || pw2 == null || nickName == null)
				return false;
		if(!pw1.equals(pw2)){
			return false;
		}else{
			User u = new User();
			u.setLevel(0);
			u.setNickName(nickName);
			u.setPassword(pw1);
			u.setPoints(0);
			u.setUserName(un);
			u = userService.createUesr(u);
			return u != null;
		}
	}
	@RequestMapping("/logout")
	public String  logout(HttpSession httpSession){
		System.out.println(httpSession.getAttribute("user")+"--->");
		httpSession.removeAttribute("user");

		System.out.println(httpSession.getAttribute("user")+"<---");
		return "redirect:index";
	}
	@RequestMapping("/index")
	public String toIndex(HttpSession httpSession, Model model){
		
		NewGame ng = null;
		User user = (User) httpSession.getAttribute("user");
		System.out.println(user+"###");
		if(user != null){
			ng = gameService.getUnfinishGame(user);
		}
		List<User> sortedUsers = userService.getUserSortedByPoints();
		model.addAttribute("su", sortedUsers );
		if(ng == null)
			return "index";
		else return "forward:game/normal";
	}
	@RequestMapping("/userinfo")
	public String toInfo(HttpSession httpSession, Model model){
		User user = (User) httpSession.getAttribute("user");
		List<FinishedGameForAUser> fgl = gameService.getNormalGameResultList(user);
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		for (FinishedGameForAUser fg : fgl){
			fg.setFtime(df.format(new Date(Long.parseLong(fg.getFtime()))));
			fg.setTime(df.format(new Date(Long.parseLong(fg.getTime()))));
		}
		model.addAttribute("fgl", fgl);
		 return "info";
	}
	
	
	@RequestMapping("/testDb")
	public String db() throws IOException{
		List<Question> ql = new ArrayList<>();
		Scanner sc = new Scanner(
				Files.newInputStream(
						Paths.get("C:/Users/yyg/Documents/Tencent Files/516032337/FileRecv/program_answer.txt"))	
				);
		while(sc.hasNextLine()){
			String str = sc.nextLine();
			String [] ws = str.split(" ");
			Question q = new Question();
			System.out.println(ws[0]+"  "+ws[1]);
			q.setAnswer(ws[1]);
			q.setContent(ws[0]);
			q.setLevel(0);
			ql.add(q);
		}
		udo.updateDb(ql);
		 return "info";
	}
	
	
	@ResponseBody
	@RequestMapping("/submitComment")  
	public boolean submitComment(String cm){
		long time = new Date().getTime();
		CommentData.comments.put(time, cm);
		return true;
	}
	@ResponseBody
	@RequestMapping("/getComment")  
	public List<Entry<Long,String>>  getComment(HttpSession session){
		long ltime = -1;
		if( session.getAttribute("cltime") != null)
			ltime = (long) session.getAttribute("cltime");
		else 
			ltime = new Date().getTime() - 2000;
		long ntime = new Date().getTime();
		List<Entry<Long,String>> rcs = new ArrayList<>();
		for(Entry<Long,String> e : CommentData.comments.entrySet()){
			if(e.getKey() <= ntime){
				if(e.getKey() > ltime)
					rcs.add(e);
			}	
			if(e.getKey()<= ltime) break;
		}
		session.setAttribute("cltime", ntime);
		Collections.reverse(rcs);
		return rcs;
	}
}
