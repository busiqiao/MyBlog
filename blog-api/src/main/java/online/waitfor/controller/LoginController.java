package online.waitfor.controller;

import com.alibaba.fastjson2.JSON;
import online.waitfor.entity.User;
import online.waitfor.model.dto.LoginInfo;
import online.waitfor.model.vo.Result;
import online.waitfor.service.UserService;
import online.waitfor.util.JwtUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import online.waitfor.constant.JwtConstants;

import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 前台登录
 * @Author: Naccl
 * @Date: 2020-09-02
 */
@RestController
public class LoginController {
	@Autowired
    UserService userService;

	/**
	 * 登录成功后，签发博主身份Token
	 *
	 * @param loginInfo
	 * @return
	 */
	@PostMapping("/login")
	public Result login(@RequestBody LoginInfo loginInfo) {
		User user = userService.findUserByUsernameAndPassword(loginInfo.getUsername(), loginInfo.getPassword());
		String json = JSON.toJSONString(loginInfo);
		System.out.println(json);

		if (!"ROLE_admin".equals(user.getRole())) {
			return Result.create(403, "无权限");
		}		user.setPassword(null);
		String jwt = JwtUtils.generateToken(JwtConstants.ADMIN_PREFIX + user.getUsername());
		Map<String, Object> map = new HashMap<>(4);
		map.put("user", user);
		map.put("token", jwt);
		return Result.ok("登录成功", map);
	}
}
