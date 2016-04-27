/**
 * 
 */
package baoda.domain;

import java.util.List;

/**
 *<p>FinishGame</p>
 *
 *<p>Description:</p>
 *
 * @author py
 *
 * @date 2016年4月6日
 */
public class FinishedGameForAUser extends Game{
	private List<QuestionWithAnswer> qwas;
	private User user;
	private double ponits;
	private String ftime;
	
	public String getFtime() {
		return ftime;
	}
	public void setFtime(String ftime) {
		this.ftime = ftime;
	}
	public List<QuestionWithAnswer> getQwas() {
		return qwas;
	}
	public void setQwas(List<QuestionWithAnswer> qwas) {
		this.qwas = qwas;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	public double getPonits() {
		return ponits;
	}
	public void setPonits(double ponits) {
		this.ponits = ponits;
	}
	public void setPonits(int ponits) {
		this.ponits = ponits;
	}
	
}
