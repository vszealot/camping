package controller;

import java.io.IOException;
import java.util.UUID;

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
	@RequestMapping("/loginNew.do")
	public String loginNew(Model model) {
		return "login/loginNew";
	}
	@RequestMapping(value="/loginProc.do",method=RequestMethod.POST)
	public String logProc(@ModelAttribute UserEntity userEntity, HttpServletRequest request) throws IOException {

		UserEntity entity=userDao.loginUser(userEntity);
		
		//로그인 세션 관리
		if(entity!=null) {
//			System.out.println(entity.getNickName());
			HttpSession session= request.getSession();
			session.setAttribute("logOK", entity);
			return "../../index";
		}else {
			
			return "login/loginNew";
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
	
	//ID중복 확인을 위한 sql문
    @RequestMapping(value="/checkId.do", method= RequestMethod.GET)
    @ResponseBody 
    public int idCheck(@RequestParam("userId") String userId, Model model) {
//    	System.out.println("유저아디" + userId);
//    	UserEntity entity=userDao.checkId(userId);
    	int count = 0;
//        Map<String, Integer> map = new HashMap<>();
        count = userDao.checkId(userId);
        //데이터 넘어옴
        
    	return count;
    }
    
    //닉네임 중복확인
    @RequestMapping(value="/checkNickname.do", method= RequestMethod.GET)
    @ResponseBody 
    public int NicknameCheck(@RequestParam("nickName") String nickName, Model model) {
    	int count = 0;
        count = userDao.checkNickname(nickName);
    	return count;
    }
    //아이디 비밀번호 찾기--------------------------------------------
    // 아이디 찾기
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
    //이메일로 비밀번호 찾기
    @RequestMapping(value="/findPassword.do", method=RequestMethod.POST)
    public ModelAndView findingPassword(@ModelAttribute UserEntity entity, HttpServletResponse response) throws Exception {
    	ModelAndView mav;
//    	System.out.println(entity.getUserEmail());
//    	System.out.println(entity.getUserId());
    	
    	String password = userDao.findingPassword(entity);
    	
    	if(password!=null) {
//    		System.out.println("성공");
    		email.setContent("비밀번호는 "+password+" 입니다.");
    		email.setReceiver(entity.getUserEmail());
    		email.setSubject(entity.getUserId()+"님 비밀번호 찾기 메일입니다.");
    		emailSender.SendEmail(email);
    		mav=new ModelAndView("login/login");
    		return mav;
    	}
    	mav=new ModelAndView("login/login");
		return mav;
    }
    
    //회원정보 수정/탈퇴 ----------------------------------------------------------------
    @RequestMapping("/update.do")
	public String update(Model model) {
		return "login/update";
	}
    
    @RequestMapping("/updateProc.do")
    public String updateProc(@ModelAttribute UserEntity entity, Model model, HttpServletRequest request) {
//    	System.out.println(request.getParameter("userEmail"));
//    	System.out.println(request.getParameter("nickName"));
    	
    	String password=request.getParameter("password");
    	String newPassword=request.getParameter("newPassword");
    	
    	// 새 비밀번호로 수정
    	if(newPassword!=null && password!=null) {
    		if(password!=newPassword) {
    			entity.setPassword(newPassword);
    		}
    	}
    	
    	if(userDao.updateUser(entity)) {
			return "login/login";
		}else {
			return "login/update";
		}
    }
    
    //비밀번호 동일한지 유효성 체크
    @RequestMapping(value="/checkPassword.do", method= RequestMethod.GET)
    @ResponseBody 
    public int checkPassword(@RequestParam("password") String password, Model model) {
    	int count = 0;
        count = userDao.checkPassword(password);
    	return count;
    }
    
    //회원 탈퇴
    @RequestMapping("/deleteProc.do")
    public String deleteProc(@ModelAttribute UserEntity entity, Model model, HttpServletRequest request) {
    	
    	if(userDao.deleteUser(entity)) {
			return "login/login";
		}else {
			return "login/update";
		}
    }
    
    // 로그인 API--------------------------------------------------------------------
    @RequestMapping("/callback.do")
	public String callback(Model model) {
		return "login/callback";
	}
    
    @RequestMapping(value="/facebook.do", method= RequestMethod.POST)
    public ModelAndView facebook(@ModelAttribute UserEntity entity, Model model, HttpServletRequest request) throws Exception {
    	// id,email,nickname,password => DB에 저장
    	// if 이미 저장되어있으면 그냥 로그인 (select id로 다녀옴 )
    	// else 최초 로그인 -> DB저장 && 비밀번호 임의 8자리 생성 후 메일 전송
    	ModelAndView mav;
    	
    	int cnt=userDao.findFacebook(entity);
    	System.out.println(cnt);
    	if(cnt>0) {
    		//이미 회원가입되어있는 경우
    		HttpSession session= request.getSession();
    		session.setAttribute("logOK", entity);
    	}else {
    		//비밀번호 생성(10자리)
//    		System.out.println("ok");
    		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
    		uuid = uuid.substring(0, 10);
    		entity.setPassword(uuid);
//    		System.out.println(entity.getPassword());
    		
    		//DB에 회원 정보 추가
    		userDao.joinUser(entity);
    		
    		//회원에게 비밀번호 이메일 발송 
    		email.setContent("비밀번호는 "+entity.getPassword()+" 입니다.");
    		email.setReceiver(entity.getUserEmail());
    		email.setSubject(entity.getUserId()+"님의 새로운 계정입니다.");
    		emailSender.SendEmail(email);
    		
    		//DB에 insert되고 로그인 세션처리
    		HttpSession session= request.getSession();
    		session.setAttribute("logOK", entity);
    	}
    	
    	mav=new ModelAndView("../main");
		return mav;
    }
   
    
    
    
}
