package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import entity.Page;
import model.CampDao;

@Controller
public class ControllerCamp {
	@Autowired
	CampDao campDao;
	
/*	//		캠프리스트	==========================================================================
	@RequestMapping(value = "/campList.do")
	public ModelAndView campList() {
		return new ModelAndView("camp/campList", "campList", campDao.campList());
	}*/
	
	//		캠프리스트 + 페이징	==========================================================================
	@RequestMapping(value = "/campList.do", method = RequestMethod.GET)
	public ModelAndView campList(Page page,Model model) {
		//		캠프리스트 총 갯수 구하는 코드		===============
		page.setTotalCount(campDao.campListCount());
		model.addAttribute("page",page);
		//		캠프리스트 총 갯수 구하는 코드		===============
		
		return new ModelAndView("camp/campList", "campList", campDao.campListPage(page));
	}
	
	
	
	//		게시판 페이지 이동(공통)	===================================================================
	@RequestMapping(value = "/{pageName}.do")
	public String getSinglePage(@PathVariable("pageName")String pageName) {
		return "camp/" + pageName;
	}
}
