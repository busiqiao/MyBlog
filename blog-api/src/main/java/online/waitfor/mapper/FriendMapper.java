package online.waitfor.mapper;

import online.waitfor.model.dto.Friend;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Description: 友链持久层接口
 * @Author: Naccl
 * @Date: 2020-09-08
 */
@Mapper
@Repository
public interface FriendMapper {
	List<online.waitfor.entity.Friend> getFriendList();

	List<online.waitfor.model.vo.Friend> getFriendVOList();

	int updateFriendPublishedById(Long id, Boolean published);

	int saveFriend(online.waitfor.entity.Friend friend);

	int updateFriend(Friend friend);

	int deleteFriend(Long id);

	int updateViewsByNickname(String nickname);
}
