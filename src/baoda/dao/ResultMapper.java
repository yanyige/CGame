package baoda.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import baoda.domain.Question;
import baoda.domain.Result;
import baoda.domain.ResultKey;

public interface ResultMapper {
	int deleteByPrimaryKey(ResultKey key);

	int insert(Result record);

	int insertSelective(Result record);

	Result selectByPrimaryKey(ResultKey key);

	int updateByPrimaryKeySelective(Result record);

	int updateByPrimaryKey(Result record);

	int batchUpdateAnswer2NULLbyUGQL(@Param("u_id")int uid,
																			@Param("g_id") int gid, 
																			@Param("list")List<Question> questions);
	int batchUpdateAnswerbyUGQAM(@Param("u_id")int uid,
			@Param("g_id") int gid, 
			@Param("map")Map<Integer,String> questions);
	List<Result> selectByUidAndGid(@Param("u_id")int uid,@Param("g_id") int gid);
}