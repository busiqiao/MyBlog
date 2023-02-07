package online.waitfor.service;

import online.waitfor.model.dto.Friend;
import online.waitfor.model.vo.FriendInfo;

import java.util.List;

public interface FriendService {
	List<online.waitfor.entity.Friend> getFriendList();

	List<online.waitfor.model.vo.Friend> getFriendVOList();

	void updateFriendPublishedById(Long friendId, Boolean published);

	void saveFriend(online.waitfor.entity.Friend friend);

	void updateFriend(Friend friend);

	void deleteFriend(Long id);

	void updateViewsByNickname(String nickname);

	FriendInfo getFriendInfo(boolean cache, boolean md);

	void updateFriendInfoContent(String content);

	void updateFriendInfoCommentEnabled(Boolean commentEnabled);
}
