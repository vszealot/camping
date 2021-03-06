package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import entity.Board;
import entity.CampInfo;
import entity.Page;
import entity.tour;
import entity.weather;
import model.CampDao;
import model.ReplyDao;

@Controller
public class ControllerCamp {
	@Autowired
	CampDao campDao;
	@Autowired
	ReplyDao replyDao;

	/*
	 * // ķ������Ʈ
	 * ==========================================================================
	 * 
	 * @RequestMapping(value = "/campList.do") public ModelAndView campList() {
	 * return new ModelAndView("camp/campList", "campList", campDao.campList()); }
	 */

	// ķ������Ʈ + ����¡
	// ==========================================================================
	@RequestMapping(value = "/campList.do", method = RequestMethod.GET)
	public String campList(Page page, Model model) {
		// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============
		page.setTotalCount(campDao.campListCount());
		model.addAttribute("page", page);
		model.addAttribute("campList", campDao.campListPage(page));
		model.addAttribute("campListMap", campDao.campList());
		// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============

		return "camp/campList";
	}

	// ī��ݸ���Ʈ + ����¡
	// ==========================================================================
	@RequestMapping(value = "/carvanList.do", method = RequestMethod.GET)
	public String carvanList(Page page, Model model) {
		// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============
		page.setTotalCount(campDao.carvanListCount());
		model.addAttribute("page", page);
		model.addAttribute("carvanList", campDao.carvanListPage(page));
		model.addAttribute("carvanListMap", campDao.carvanList());
		// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============

		return "camp/carvanList";
	}

	// �˻�
	// ó��---------------------------------------------------------------------------------
	@RequestMapping(value = "/searchProc.do", method = RequestMethod.GET)
	@ResponseBody
	public List<CampInfo> campSearch(Page page, Model model) {
		// System.out.println(page.getSearchWord());
		// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============
		page.setTotalCount(campDao.searchListCount(page));
		model.addAttribute("page", page);
		model.addAttribute("campListMap", campDao.searchListPage(page));
		// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============

		return campDao.searchListPage(page);
	}
	
	
	// ī��� �˻�
		// ó��---------------------------------------------------------------------------------
		@RequestMapping(value = "/searchProc_carvan.do", method = RequestMethod.GET)
		@ResponseBody
		public List<CampInfo> carvanSearch(Page page, Model model) {
			// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============
			page.setTotalCount(campDao.search_carvanListCount(page));
			model.addAttribute("page", page);
			model.addAttribute("campListMap", campDao.search_carvanListPage(page));
			// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============

			return campDao.search_carvanListPage(page);
		}

	// ajax ���� �κ�
	// =======================================================================
	@RequestMapping(value = "/campListAjax.do", method = RequestMethod.GET)
	@ResponseBody
	public List<CampInfo> campListAjax(Page page, Model model) {
		if (page.getSearchWord() == null) {
			// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============
			page.setTotalCount(campDao.campListCount());
			model.addAttribute("campList", campDao.campListPage(page));
			model.addAttribute("page", page);
			// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============

			return campDao.campListPage(page);
		} else {
			page.setTotalCount(campDao.searchListCount(page));
			model.addAttribute("campList", campDao.selectedListPage(page));
			model.addAttribute("page", page);
			return campDao.selectedListPage(page);
		}

	}
	
	
	// ajax(carvan) ���� �κ�
		// =======================================================================
		@RequestMapping(value = "/carvanListAjax.do", method = RequestMethod.GET)
		@ResponseBody
		public List<CampInfo> carvanListAjax(Page page, Model model) {
			if (page.getSearchWord() == null) {
				// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============
				page.setTotalCount(campDao.carvanListCount());
				model.addAttribute("campList", campDao.carvanListPage(page));
				model.addAttribute("page", page);
				// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============

				return campDao.carvanListPage(page);
			} else {
				page.setTotalCount(campDao.search_carvanListCount(page));
				model.addAttribute("campList", campDao.selected_carvanListPage(page));
				model.addAttribute("page", page);
				return campDao.selected_carvanListPage(page);
			}

		}
//ajax2(����¡ ���� �κ�)------------------------------------------------------------------------------
	@RequestMapping(value = "/campListAjax2.do", method = RequestMethod.GET)
	@ResponseBody
	public Page campListAjax2(Page page, Model model) {
		if (page.getSearchWord() == null) {
			// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============
			page.setTotalCount(campDao.campListCount());
			model.addAttribute("campList", campDao.campListPage(page));
			model.addAttribute("page", page);
			// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============
			return page;
		} else {
			page.setTotalCount(campDao.searchListCount(page));
			model.addAttribute("campList", campDao.selectedListPage(page));
			model.addAttribute("page", page);
			return page;
		}
	}
	
	//ajax2ī���(����¡ ���� �κ�)------------------------------------------------------------------------------	
	@RequestMapping(value = "/carvanListAjax2.do", method = RequestMethod.GET)
	@ResponseBody
	public Page carvanListAjax2(Page page, Model model) {
		if (page.getSearchWord() == null) {
			// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============
			page.setTotalCount(campDao.carvanListCount());
			model.addAttribute("campList", campDao.carvanListPage(page));
			model.addAttribute("page", page);
			// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============
			return page;
		} else {
			page.setTotalCount(campDao.search_carvanListCount(page));
			model.addAttribute("campList", campDao.selected_carvanListPage(page));
			model.addAttribute("page", page);
			return page;
		}
	}

	@RequestMapping(value = "/weather.do", method = RequestMethod.GET)
	@ResponseBody
	public weather weatherCheck(weather weather, Model model) {
		// System.out.println(weather.getAddr1());
		api.weather we = new api.weather();

		if (campDao.campWeather(we.weatherAddr(weather.getAddr1(), weather.getAddr2())) == null) {
			System.out.println("ok");
			model.addAttribute("campWeather",
					campDao.campWeather2(we.weatherAddr(weather.getAddr1(), weather.getAddr2())).get(0));
			return campDao.campWeather2(we.weatherAddr(weather.getAddr1(), weather.getAddr2())).get(0);
		} else {
			System.out.println("fail");
			model.addAttribute("campWeather",
					campDao.campWeather(we.weatherAddr(weather.getAddr1(), weather.getAddr2())));
			return campDao.campWeather(we.weatherAddr(weather.getAddr1(), weather.getAddr2()));
		}

	}

	@RequestMapping(value = "/tour.do", method = RequestMethod.GET)
	@ResponseBody
	public tour tourCategory(tour tour, Model model) {

		model.addAttribute("campTour", campDao.tourCategory(tour));
		return campDao.tourCategory(tour);
	}

	@RequestMapping(value = "/inquiryUp.do", method = RequestMethod.GET)
	@ResponseBody
	public void inquiryUp(weather weather) {
		campDao.inquiryUp(weather.getAddr1());
	}

	@RequestMapping(value = "/inquiryseq.do", method = RequestMethod.GET)
	@ResponseBody
	public List<CampInfo> inquiryseq() {
		// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============
		Page page = new Page();
		page.setTotalCount(campDao.inqiryCount());

		return campDao.inquirySeq(page);
	}
	
	
	
	@RequestMapping(value = "/inquiry_carvanseq.do", method = RequestMethod.GET)
	@ResponseBody
	public List<CampInfo> inquiry_carvanseq() {
		// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============
		Page page = new Page();
		page.setTotalCount(campDao.inqiry_carvanCount());

		return campDao.inquiry_carvanSeq(page);
	}

	@RequestMapping(value = "/campdetail.do", method = RequestMethod.GET)
	@ResponseBody
	public CampInfo campdetail(weather weather) {
		System.out.println(weather.getAddr1());

		return campDao.campinfo(weather.getAddr1());
	}
	
	
	// ķ�� ��õ �� ����
		@RequestMapping(value = "/campUpdateRecommend.do", method = RequestMethod.GET)
		@ResponseBody
		public int campUpdateRecommend(CampInfo campInfo, Board board, Model model) throws Exception {
			board.setBoardName("camp");
			replyDao.campUpdateRecommend(campInfo, board);
			
			int n = replyDao.reccount(campInfo);
			return n;
		}
		
		// ķ�� ��õ �� ����
		@RequestMapping(value = "/reccount.do", method = RequestMethod.GET)
		@ResponseBody
		public int reccount(CampInfo campInfo) throws Exception{
			int n = replyDao.reccount(campInfo);
			return n;
		}
		
		
		
		@RequestMapping(value = "/insertcamp.do", method = RequestMethod.GET)
		@ResponseBody
		public int insertcamp(@ModelAttribute CampInfo campInfo) throws Exception {
			
			
			return campDao.campinsert(campInfo);
		}
		
		
		
		@RequestMapping(value = "/recommendseq.do", method = RequestMethod.GET)
		@ResponseBody
		public List<CampInfo> recommendseq() {
			// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============
			Page page = new Page();
			page.setTotalCount(campDao.recommendCount());

			return campDao.recommendSeq(page);
		}
		
		
		@RequestMapping(value = "/recommendseqcarvan.do", method = RequestMethod.GET)
		@ResponseBody
		public List<CampInfo> recommendseqcarvan() {
			// ķ������Ʈ �� ���� ���ϴ� �ڵ� ===============
			Page page = new Page();
			page.setTotalCount(campDao.recommendcarvanCount());

			return campDao.recommendcarvanSeq(page);
		}

}
