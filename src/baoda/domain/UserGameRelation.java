package baoda.domain;

public class UserGameRelation extends UserGameRelationKey {
    private String finishTime;

    private Double point;

    public String getFinishTime() {
        return finishTime;
    }

    public void setFinishTime(String finishTime) {
        this.finishTime = finishTime == null ? null : finishTime.trim();
    }

    public Double getPoint() {
        return point;
    }

    public void setPoint(Double point) {
        this.point = point;
    }
}