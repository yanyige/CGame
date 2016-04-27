/**
 * 
 */
package baoda.domain;

import java.util.List;

/**
 *<p>AGmae</p>
 *
 *<p>Description:</p>
 *
 * @author py
 *
 * @date 2016年4月5日
 */
public class NewGame extends Game{
	private List<Question> questions;
	private List<User> user ;
	public List<Question> getQuestions() {
		return questions;
	}
	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}
	public List<User> getUser() {
		return user;
	}
	public void setUser(List<User> user) {
		this.user = user;
	}
	
}
