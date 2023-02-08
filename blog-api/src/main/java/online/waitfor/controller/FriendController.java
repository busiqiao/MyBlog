package online.waitfor.controller;

import com.alibaba.fastjson2.JSON;
import online.waitfor.enums.VisitBehavior;
import online.waitfor.model.vo.Friend;
import online.waitfor.model.vo.FriendInfo;
import online.waitfor.model.vo.Result;
import online.waitfor.service.FriendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import online.waitfor.annotation.VisitLogger;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class FriendController {
	@Autowired
    FriendService friendService;

	/**
	 * 获取友链页面
	 *
	 * @return
	 */
	@VisitLogger(VisitBehavior.FRIEND)
	@GetMapping("/friends")
	public Result friends() {
		List<Friend> friendList = friendService.getFriendVOList();
		FriendInfo friendInfo = friendService.getFriendInfo(true, true);
		Map<String, Object> map = new HashMap<>(4);
		map.put("friendList", friendList);
		map.put("friendInfo", friendInfo);
		return Result.ok("获取成功", map);
	}

	/**
	 * 按昵称增加友链浏览次数
	 *
	 * @param nickname 友链昵称
	 * @return
	 */
	@VisitLogger(VisitBehavior.CLICK_FRIEND)
	@PostMapping("/friend")
	public Result addViews(@RequestParam String nickname) {
//		String json = JSON.toJSONString(nickname);
//		System.out.println(json);
		friendService.updateViewsByNickname(nickname);
		return Result.ok("请求成功");
	}
}
