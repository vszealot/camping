package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import entity.CampInfo;
import entity.Page;
import entity.tour;
import entity.weather;
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
	
	//		ajax ���� �κ�		=======================================================================
	@RequestMapping(value = "/campListAjax.do", method = RequestMethod.GET)
	@ResponseBody
	public List<CampInfo> campListAjax(Page page,Model model) {
		//		ķ������Ʈ �� ���� ���ϴ� �ڵ�		===============
		page.setTotalCount(campDao.campListCount());
		model.addAttribute("campList",campDao.campListPage(page));	
		model.addAttribute("page",page);
		//		ķ������Ʈ �� ���� ���ϴ� �ڵ�		===============
		
		return campDao.campListPage(page);
	}
	@RequestMapping(value = "/campListAjax2.do", method = RequestMethod.GET)
	@ResponseBody
	public Page campListAjax2(Page page,Model model) {
		//		ķ������Ʈ �� ���� ���ϴ� �ڵ�		===============
		page.setTotalCount(campDao.campListCount());
		model.addAttribute("campList",campDao.campListPage(page));	
		model.addAttribute("page",page);
		//		ķ������Ʈ �� ���� ���ϴ� �ڵ�		===============
		
		return page;
	}
	

	@RequestMapping(value = "/weather.do", method = RequestMethod.GET)
	@ResponseBody
	public weather weatherCheck(weather weather,Model model) {
		//System.out.println(weather.getAddr1());
		api.weather we = new api.weather();
		
		model.addAttribute("campWeather", campDao.campWeather(we.weatherAddr(weather.getAddr1(), weather.getAddr2())));
		return campDao.campWeather(we.weatherAddr(weather.getAddr1(), weather.getAddr2()));
	}
	
	@RequestMapping(value = "/tour.do", method = RequestMethod.GET)
	@ResponseBody
	public tour tourCategory(tour tour,Model model) {
		
		model.addAttribute("campTour", campDao.tourCategory(tour));
		return campDao.tourCategory(tour);
	}
	
}
