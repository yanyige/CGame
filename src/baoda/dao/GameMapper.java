package baoda.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import baoda.domain.Game;
import baoda.domain.Question;

public interface GameMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Game record);

    int insertSelective(Game record);

    Game selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Game record);

    int updateByPrimaryKey(Game record);
    
    void updateDb(@Param("list")List<Question> ql);
}