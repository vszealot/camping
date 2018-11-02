package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ControllerMaster {
	
	//회원 목록
	@RequestMapping("/userInfo.do")
	public String userInfo(Model model) {
		return "master/userInfo";
	}
}
