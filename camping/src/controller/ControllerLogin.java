package controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import entity.UserEntity;
import model.UserDao;

@SessionAttributes
@Controller
public class ControllerLogin {
	UserDao userDao;
	@Autowired
	public ControllerLogin(UserDao userDao) {
		super();
		this.userDao = userDao;
	}
	//회원가입-----------------------------------------------------
	@RequestMapping("/join.do")
	public String join(Model model) {
		return "login/join";
	}
	
	@RequestMapping(value="/joinProc.do",method=RequestMethod.POST)
	public String insertProc(@ModelAttribute UserEntity userEntity) {
		
		if(userDao.joinUser(userEntity)) {
//			System.out.println("ok");
			return "../../index";
		}else {
			return "login/join";
		}
	}
	//로그인----------------------------------------------------
	@RequestMapping("/login.do")
	public String login(Model model) {
		return "login/login";
	}
	@RequestMapping(value="/loginProc.do",method=RequestMethod.POST)
	public String logProc(@ModelAttribute UserEntity userEntity, HttpServletRequest request) throws IOException {
		//로그인 세션 관리
		UserEntity entity=userDao.loginUser(userEntity);
		
		if(entity!=null) {
			System.out.println(entity.getNickName());
			HttpSession session= request.getSession();
			session.setAttribute("logOK", entity);
			return "../../index";
		}else {
			return "login/login";
		}
	}
	
	//로그아웃
	@RequestMapping(value="/logout.do", method=RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session= request.getSession();
		
		UserEntity entity= (UserEntity)session.getAttribute("logOK");
		
		if(entity != null) {
			session.removeAttribute("logOK");
			return "../main";
		}
		// ?
		return "../main";
	}
	
}
