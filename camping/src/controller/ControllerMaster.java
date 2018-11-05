package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import entity.UserEntity;
import model.UserInfoDao;

@Controller
public class ControllerMaster {
	@Autowired
	UserInfoDao userInfoDao;
	
	//-----------------------------------------------------------------------------------
	//회원 목록 페이지
	@RequestMapping("/userInfo.do")
	public String userInfo(Model model) {
		return "master/userInfo";
	}
	
	// 회원 목록 조회 
	@RequestMapping(value = "/userInfoView.do")
	public ModelAndView userInfoView(@ModelAttribute UserEntity userEntity){
		List<UserEntity> list= userInfoDao.userInfoView();
		if(!list.isEmpty()) {
//			System.out.println("ok");
			return new ModelAndView("master/userInfo", "listUser", list);
		}else {
			return new ModelAndView("master/userInfo", "listUser", list);
		}
	}
	
	// 회원 등급 조정
	@RequestMapping(value = "/userGradeUpdate.do")
	public ModelAndView userGradeUpdate(@ModelAttribute UserEntity userEntity){
		if(userInfoDao.userGradeUpdate(userEntity)) {
			System.out.println("회원 등급 변경 성공");
		}
		return new ModelAndView("master/userInfo");
	}
	
	
	//------------------------------------------------------------------------------------	
	//캠핑장 대기 목록 페이지
	@RequestMapping("/campEnrollWait.do")
	public String campEnrollWait(Model model) {
		return "master/campEnrollWait";
	}

	
	//------------------------------------------------------------------------------------
	//공지사항 등록 페이지
	@RequestMapping("/notice.do")
	public String notice(Model model) {
		return "master/notice";
	}
}
