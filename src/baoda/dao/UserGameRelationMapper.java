package baoda.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import baoda.domain.UserGameRelation;
import baoda.domain.UserGameRelationKey;

public interface UserGameRelationMapper {
    int deleteByPrimaryKey(UserGameRelationKey key);

    int insert(UserGameRelation record);

    int insertSelective(UserGameRelation record);

    UserGameRelation selectByPrimaryKey(UserGameRelationKey key);

    int updateByPrimaryKeySelective(UserGameRelation record);

    int updateByPrimaryKey(UserGameRelation record);
    
    List<UserGameRelation> selectByGidAndFinishTimeIsNull(@Param("g_id")int gid);

    UserGameRelation selectByUidAndFinishTimeIsNULL(@Param("u_id")int u_id);
    
    List<UserGameRelation> selectByUid(@Param("u_id") int u_id);
    
}