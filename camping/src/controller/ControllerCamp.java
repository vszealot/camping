package controller;

import java.sql.SQLException;
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
	@RequestMapping(value="/searchProc.do", method=RequestMethod.GET)
	@ResponseBody
	public List<CampInfo> campSearch(Page page, Model model) {
		//System.out.println(page.getSearchWord());
		//		ķ������Ʈ �� ���� ���ϴ� �ڵ�		===============
		page.setTotalCount(campDao.searchListCount(page));
		model.addAttribute("page",page);
		model.addAttribute("campListMap",campDao.searchListPage(page));
		//		ķ������Ʈ �� ���� ���ϴ� �ڵ�		===============
		
		return campDao.searchListPage(page);
	}
	
	//		ajax ���� �κ�		=======================================================================
	@RequestMapping(value = "/campListAjax.do", method = RequestMethod.GET)
	@ResponseBody
	public List<CampInfo> campListAjax(Page page,Model model) {
		if(page.getSearchWord()==null) {
//			ķ������Ʈ �� ���� ���ϴ� �ڵ�		===============
			page.setTotalCount(campDao.campListCount());
			model.addAttribute("campList",campDao.campListPage(page));	
			model.addAttribute("page",page);
			//		ķ������Ʈ �� ���� ���ϴ� �ڵ�		===============
			
			return campDao.campListPage(page);
		}else {
			page.setTotalCount(campDao.searchListCount(page));
			model.addAttribute("campList",campDao.selectedListPage(page));
			model.addAttribute("page",page);
			return campDao.selectedListPage(page);
		}
		
	}
	@RequestMapping(value = "/campListAjax2.do", method = RequestMethod.GET)
	@ResponseBody
	public Page campListAjax2(Page page,Model model) {
		System.out.println(page.getSearchWord()+"!!!!!!!!!!!!!!!!");
			if(page.getSearchWord()==null) {
				System.out.println("���������");
		//		ķ������Ʈ �� ���� ���ϴ� �ڵ�		===============
				page.setTotalCount(campDao.campListCount());
				model.addAttribute("campList",campDao.campListPage(page));	
				model.addAttribute("page",page);
				//		ķ������Ʈ �� ���� ���ϴ� �ڵ�		===============
				return page;
			}else {
				System.out.println("���������");
				page.setTotalCount(campDao.searchListCount(page));
				model.addAttribute("campList",campDao.selectedListPage(page));
				model.addAttribute("page",page);
				return page;
			}
	}
	

	@RequestMapping(value = "/weather.do", method = RequestMethod.GET)
	@ResponseBody
	public weather weatherCheck(weather weather,Model model) {
		//System.out.println(weather.getAddr1());
		api.weather we = new api.weather();
		
			if(campDao.campWeather(we.weatherAddr(weather.getAddr1(), weather.getAddr2()))==null) {
				System.out.println("ok");
				model.addAttribute("campWeather", campDao.campWeather2(we.weatherAddr(weather.getAddr1(), weather.getAddr2())).get(0));
				return campDao.campWeather2(we.weatherAddr(weather.getAddr1(), weather.getAddr2())).get(0);
			}else {
				System.out.println("fail");
				model.addAttribute("campWeather", campDao.campWeather(we.weatherAddr(weather.getAddr1(), weather.getAddr2())));
				return campDao.campWeather(we.weatherAddr(weather.getAddr1(), weather.getAddr2()));
			}
				
		
		
		
	}
	
	@RequestMapping(value = "/tour.do", method = RequestMethod.GET)
	@ResponseBody
	public tour tourCategory(tour tour,Model model) {
		
		model.addAttribute("campTour", campDao.tourCategory(tour));
		return campDao.tourCategory(tour);
	}
	
}
