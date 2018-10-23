package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import model.CampDao;

@Controller
public class ControllerCamp {
	@Autowired
	CampDao campDao;
	
	//		��ü ����ϱ�	==========================================================================
	@RequestMapping(value = "/campList.do")
	public ModelAndView campList() {
		return new ModelAndView("camp/campList", "campList", campDao.campList());
	}
	
	//		�Խ��� ������ �̵�(����)	===================================================================
	@RequestMapping(value = "/{pageName}.do")
	public String getSinglePage(@PathVariable("pageName")String pageName) {
		return "camp/" + pageName;
	}
}
