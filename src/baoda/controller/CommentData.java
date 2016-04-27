package baoda.controller;

import java.util.Comparator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentSkipListMap;

/**   
* @Title: CommentData.java 
* @Package baoda.controller 
* @Description: TODO
* @author py pengyang813@foxmail.com
* @date 2016年4月27日 上午9:54:13 
* @version V1.0   
*/
public class CommentData {
	public static final Map<Long, String> comments = new ConcurrentSkipListMap<>(new Comparator<Long>() {

		@Override
		public int compare(Long o1, Long o2) {
			if (o1 == o2)
				return 0;
			else if(o1 > o2)
				return -1;
			else
				return 1;
		}
	});
}
