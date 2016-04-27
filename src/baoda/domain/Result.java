package baoda.domain;

public class Result extends ResultKey {
    private String answer;
    
    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer == null ? null : answer.trim();
    }
}