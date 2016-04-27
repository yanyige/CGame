package baoda.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import baoda.domain.Question;

public interface QuestionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Question record);

    int insertSelective(Question record);

    Question selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Question record);

    int updateByPrimaryKey(Question record);
    
    List<Question> selectRandomNByLevel(int n, int level);
    
    List<Question> selectByUidAndGid(@Param("u_id") int u_id, @Param("g_id") int g_id);
}