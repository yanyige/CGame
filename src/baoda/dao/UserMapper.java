package baoda.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import baoda.domain.User;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);
    
    User selectByUserNameAndPassWord(String userName,String passWord);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    int countByUserName(String userName);
    
    List<User> selectByGid(@Param("g_id")int g_id);
    
    List<User> selectAllOrderByPoints();
}