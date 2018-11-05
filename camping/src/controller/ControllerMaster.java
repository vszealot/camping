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
	//ȸ�� ��� ������
	@RequestMapping("/userInfo.do")
	public String userInfo(Model model) {
		return "master/userInfo";
	}
	
	// ȸ�� ��� ��ȸ 
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
	
	// ȸ�� ��� ����
	@RequestMapping(value = "/userGradeUpdate.do")
	public ModelAndView userGradeUpdate(@ModelAttribute UserEntity userEntity){
		if(userInfoDao.userGradeUpdate(userEntity)) {
			System.out.println("ȸ�� ��� ���� ����");
		}
		return new ModelAndView("master/userInfo");
	}
	
	
	//------------------------------------------------------------------------------------	
	//ķ���� ��� ��� ������
	@RequestMapping("/campEnrollWait.do")
	public String campEnrollWait(Model model) {
		return "master/campEnrollWait";
	}

	
	//------------------------------------------------------------------------------------
	//�������� ��� ������
	@RequestMapping("/notice.do")
	public String notice(Model model) {
		return "master/notice";
	}
}
