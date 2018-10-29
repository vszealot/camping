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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import email.Email;
import email.EmailSender;
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
	//ȸ������-----------------------------------------------------
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
	//�α���----------------------------------------------------
	@RequestMapping("/login.do")
	public String login(Model model) {
		return "login/login";
	}
	@RequestMapping("/loginNew.do")
	public String loginNew(Model model) {
		return "login/loginNew";
	}
	@RequestMapping(value="/loginProc.do",method=RequestMethod.POST)
	public String logProc(@ModelAttribute UserEntity userEntity, HttpServletRequest request) throws IOException {

		UserEntity entity=userDao.loginUser(userEntity);
		
		//�α��� ���� ����
		if(entity!=null) {
//			System.out.println(entity.getNickName());
			HttpSession session= request.getSession();
			session.setAttribute("logOK", entity);
			return "../../index";
		}else {
			
			return "login/loginNew";
		}
	}
	
	//�α׾ƿ�
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
	
	//ID�ߺ� Ȯ���� ���� sql��
    @RequestMapping(value="/checkId.do", method= RequestMethod.GET)
    @ResponseBody 
    public int idCheck(@RequestParam("userId") String userId, Model model) {
//    	System.out.println("�����Ƶ�" + userId);
//    	UserEntity entity=userDao.checkId(userId);
    	int count = 0;
//        Map<String, Integer> map = new HashMap<>();
        count = userDao.checkId(userId);
        //������ �Ѿ��
        
    	return count;
    }
    
    //�г��� �ߺ�Ȯ��
    @RequestMapping(value="/checkNickname.do", method= RequestMethod.GET)
    @ResponseBody 
    public int NicknameCheck(@RequestParam("nickName") String nickName, Model model) {
    	int count = 0;
        count = userDao.checkNickname(nickName);
    	return count;
    }
    //���̵� ��й�ȣ ã��--------------------------------------------
    
    @RequestMapping("/searchIdPassword.do")
	public String searchIdPassword(Model model) {
		return "login/searchIdPassword";
	}
    
    @RequestMapping(value="/findingId.do", method=RequestMethod.POST)
    @ResponseBody
    public String findingId(@ModelAttribute UserEntity entity, Model model) {
    	String userId = userDao.findId(entity);
//    	System.out.println(userId);
    	String findId = "{\"userId\":\""+userId+"\"}";
    	return findId;
    }
    
    @Autowired
    private EmailSender emailSender;
    @Autowired
    private Email email;
    //�̸��Ϸ� ��й�ȣ ã��
    @RequestMapping(value="/findPassword.do", method=RequestMethod.POST)
    public ModelAndView findingPassword(@ModelAttribute UserEntity entity, HttpServletResponse response) throws Exception {
    	ModelAndView mav;
//    	System.out.println(entity.getUserEmail());
//    	System.out.println(entity.getUserId());
    	
    	String password = userDao.findingPassword(entity);
    	
    	if(password!=null) {
//    		System.out.println("����");
    		email.setContent("��й�ȣ�� "+password+" �Դϴ�.");
    		email.setReceiver(entity.getUserEmail());
    		email.setSubject(entity.getUserId()+"�� ��й�ȣ ã�� �����Դϴ�.");
    		emailSender.SendEmail(email);
    		mav=new ModelAndView("login/login");
    		return mav;
    	}
    	mav=new ModelAndView("login/login");
		return mav;
    }
    
    
    
}
