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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entity.Board;
import entity.Page;
import entity.Reply;
import model.BoardDao;
import model.ReplyDao;

@Controller
public class ControllerBoard {
	@Autowired
	BoardDao boardDao;
	@Autowired
	ReplyDao replyDao;

	// 게시판 페이지 이동(공통)==============================================
	@RequestMapping(value = "/{pageName}.do")
	public String goPage(@PathVariable("pageName") String pageName) {
		return "board/" + pageName;
	}

	// 마켓 글 쓰기 =============================================================
	@RequestMapping(value = "/marketInsert.do", method = RequestMethod.POST)
	public ModelAndView marketInsert(Board board, Page page, Model model) throws Exception {
		board.setBoardName("market");
		boardDao.write(board);
		List<Board> list = boardDao.listSearch(board, page);

		page.setTotalCount(boardDao.countSearch(board, page));
		model.addAttribute("page", page);
		return new ModelAndView("board/marketListSearch", "list", list);
	}

	// 마켓 글 조회===============================================
	@RequestMapping(value = "/marketRead.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView marketRead(Board board, @ModelAttribute("page") Page page, Model model) throws Exception {
		board.setBoardName("market");
		model.addAttribute("page", page);
		
/*		// 조회 수 증가
		Board board2 = boardDao.read(board);
		board2.setBoardName("market");
		board2.setClick(board2.getClick()+1);
		boardDao.updateClick(board2);*/

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		return new ModelAndView("board/marketRead", "read", boardDao.read(board));
	}
	
	// 마켓 조회 수 증가
	@RequestMapping(value = "/marketUpdateClick.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public ModelAndView marketUpdateClick(Board board) throws Exception{
		board.setBoardName("market");
		board.setClick(board.getClick()+1);
		boardDao.updateClick(board);
		return null;
	}

	// 마켓 글 수정 ==================================================
	@RequestMapping(value = "/marketModify.do", method = RequestMethod.POST)
	public ModelAndView marketModify(Board board, @ModelAttribute("page") Page page, RedirectAttributes rttr)
			throws Exception {
		board.setBoardName("market");
		rttr.addAttribute("page", page.getPage());
		rttr.addAttribute("perPageNum", page.getPerPageNum());
		rttr.addAttribute("searchType", page.getSearchType());
		rttr.addAttribute("keyword", page.getKeyword());
		return new ModelAndView("board/marketModify", "modify", board);
	}

	// 마켓 글 업데이트====================================================
	@RequestMapping(value = "/marketUpdate.do", method = RequestMethod.POST)
	public ModelAndView marketUpdate(Board board, @ModelAttribute("page") Page page, RedirectAttributes rttr)
			throws Exception {
		board.setBoardName("market");
		boardDao.update(board);
		rttr.addAttribute("page", page.getPage());
		rttr.addAttribute("perPageNum", page.getPerPageNum());
		rttr.addAttribute("searchType", page.getSearchType());
		rttr.addAttribute("keyword", page.getKeyword());
		return new ModelAndView("board/marketRead", "read", boardDao.read(board));
	}

	// 마켓 글 삭제====================================================
	@RequestMapping(value = "/marketDelete.do", method = RequestMethod.POST)
	public ModelAndView marketDelete(Board board, @ModelAttribute("page") Page page, Model model) throws Exception {
		board.setBoardName("market");
		boardDao.delete(board);
		List<Board> list = boardDao.listSearch(board, page);

		page.setTotalCount(boardDao.countSearch(board, page));
		model.addAttribute("page", page);
		return new ModelAndView("board/marketListSearch", "list", list);
	}

	// 마켓 글 목록 ===========================================================
	@RequestMapping(value = "/marketList.do")
	public ModelAndView marketList(Board board) throws Exception {
		board.setBoardName("market");
		List<Board> list = boardDao.list(board);
		return new ModelAndView("board/marketList", "list", list);
	}

	// 마켓 글 목록 + 페이징=================================================
	@RequestMapping(value = "/marketListPage.do")
	public ModelAndView marketListPage(Board board, Page page, Model model) throws Exception {
		board.setBoardName("market");
		List<Board> list = boardDao.list(board, page);

		page.setTotalCount(boardDao.listCount(board));
		model.addAttribute("page", page);
		return new ModelAndView("board/marketList", "list", list);
	}

	// 마켓 글 목록 + 페이징 + 검색==============================================
	@RequestMapping(value = "/marketListSearch.do")
	public ModelAndView marketListSearch(Board board, Page page, Model model) throws Exception {
		board.setBoardName("market");
		List<Board> list = boardDao.listSearch(board, page);

		replyDao.replyCount(board);
		
		
		page.setTotalCount(boardDao.countSearch(board, page));
		model.addAttribute("page", page);
		return new ModelAndView("board/marketListSearch", "list", list);
	}
	
	// 마켓 댓글 작성
	@RequestMapping(value = "/marketReplyWrite.do", method = RequestMethod.POST)
	@ResponseBody
	public List<Reply> marketReplyWrite(Board board, Reply reply, Page page, Model model) throws Exception {
		board.setBoardName("market");
		replyDao.writeReply(board, reply);

		return replyDao.readReply(board);
	}

/*	// 마켓 댓글 작성
	@RequestMapping(value = "/marketReplyWrite.do", method = RequestMethod.POST)
	public ModelAndView marketReplyWrite(Board board, Reply reply, Page page, Model model) throws Exception {
		board.setBoardName("market");
		replyDao.writeReply(board, reply);

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		return new ModelAndView("board/marketRead", "read", boardDao.read(board));
	}*/
	
	// 마켓 댓글 삭제
	@RequestMapping(value="/marketReplyDelete.do", method = RequestMethod.POST)
	public ModelAndView marketReplyDelete(Board board, Reply reply, Page page, Model model) throws Exception{
		board.setBoardName("market");
		replyDao.deleteReply(board, reply);
		
		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		return new ModelAndView("board/marketRead", "read", boardDao.read(board));
	}
}
