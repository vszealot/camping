package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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
	
/*	//		ķ������Ʈ	==========================================================================
	@RequestMapping(value = "/campList.do")
	public ModelAndView campList() {
		return new ModelAndView("camp/campList", "campList", campDao.campList());
	}*/
	
	//		ķ������Ʈ + ����¡	==========================================================================
	@RequestMapping(value = "/campList.do", method = RequestMethod.GET)
	public String campList(Page page,Model model) {
		//		ķ������Ʈ �� ���� ���ϴ� �ڵ�		===============
		page.setTotalCount(campDao.campListCount());
		model.addAttribute("page",page);
		model.addAttribute("campList",campDao.campListPage(page));
		model.addAttribute("campListMap",campDao.campList());
		//		ķ������Ʈ �� ���� ���ϴ� �ڵ�		===============
		
		return "camp/campList";
	}
	//    �˻� ó��---------------------------------------------------------------------------------
	@RequestMapping(value="/searchProc.do", method=RequestMethod.POST)
	public ModelAndView campSearch(@ModelAttribute Page page, Model model) {
		
		//		ķ������Ʈ �� ���� ���ϴ� �ڵ�		===============
		page.setTotalCount(campDao.searchListCount(page));
		System.out.println(page.getRowEnd() +" " + page.getSearchWord() + "  " + page.getRowStart() + page.getStartPage());
		model.addAttribute("page",page);
		model.addAttribute("campListMap",campDao.searchListMap(page));
		//		ķ������Ʈ �� ���� ���ϴ� �ڵ�		===============
		
		return new ModelAndView("camp/campList", "campList", campDao.searchListPage(page));
	}
	//		�Խ��� ������ �̵�(����)	===================================================================
	@RequestMapping(value = "/{pageName}.do")
	public String getSinglePage(@PathVariable("pageName")String pageName) {
		return "camp/" + pageName;
	}
}
