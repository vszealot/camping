package controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entity.Board;
import entity.ImageFile;
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
	public ModelAndView marketInsert(Board board, Page page, Model model, MultipartHttpServletRequest request) throws Exception {
		board.setBoardName("market");
		boardDao.write(board, request);
		
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

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
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
	public ModelAndView marketModify(Board board, @ModelAttribute("page") Page page, RedirectAttributes rttr, Model model)
			throws Exception {
		board.setBoardName("market");
		rttr.addAttribute("page", page.getPage());
		rttr.addAttribute("perPageNum", page.getPerPageNum());
		rttr.addAttribute("searchType", page.getSearchType());
		rttr.addAttribute("keyword", page.getKeyword());
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/marketModify", "modify", board);
	}

	// 마켓 글 업데이트====================================================
	@RequestMapping(value = "/marketUpdate.do", method = RequestMethod.POST)
	public ModelAndView marketUpdate(Board board, @ModelAttribute("page") Page page, RedirectAttributes rttr,
			Model model, MultipartHttpServletRequest request, @RequestParam Map<String, String> mapmap) throws Exception {
		board.setBoardName("market");
		boardDao.update(board, request, mapmap);
		rttr.addAttribute("page", page.getPage());
		rttr.addAttribute("perPageNum", page.getPerPageNum());
		rttr.addAttribute("searchType", page.getSearchType());
		rttr.addAttribute("keyword", page.getKeyword());
		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
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

		Board board2 = new Board();
		board2.setBoardName("notice");
		List<Board> notice = boardDao.listSearch(board2, new Page());
		model.addAttribute("notice", notice);
		
		page.setTotalCount(boardDao.countSearch(board, page));
		model.addAttribute("page", page);
		return new ModelAndView("board/marketListSearch", "list", list);
	}
	
	// 마켓 댓글 작성
	@RequestMapping(value = "/marketReplyWrite.do", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView marketReplyWrite(Board board, Reply reply, Page page, Model model) throws Exception {
		board.setBoardName("market");
		replyDao.writeReply(board, reply);

		model.addAttribute("page", page);

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/marketRead", "read", boardDao.read(board));
	}
	
	// 마켓 댓글 삭제
	@RequestMapping(value="/marketReplyDelete.do", method = RequestMethod.POST)
	public ModelAndView marketReplyDelete(Board board, Reply reply, Page page, Model model) throws Exception{
		board.setBoardName("market");
		replyDao.deleteReply(board, reply);

		model.addAttribute("page", page);

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/marketRead", "read", boardDao.read(board));
	}
	
	// 마켓 추천 수 갱신
	@RequestMapping(value = "/marketUpdateRecommend.do", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView marketUpdateRecommend(Board board, Page page, Model model) throws Exception {
		board.setBoardName("market");
		replyDao.updateRecommend(board);

		model.addAttribute("page", page);

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/marketRead", "read", boardDao.read(board));
	}
	
	// 후기 글 쓰기 =============================================================
	@RequestMapping(value = "/reviewInsert.do", method = RequestMethod.POST)
	public ModelAndView reviewInsert(Board board, Page page, Model model, MultipartHttpServletRequest request) throws Exception {
		board.setBoardName("review");
		boardDao.write(board, request);
		
		List<Board> list = boardDao.listSearch(board, page);

		page.setTotalCount(boardDao.countSearch(board, page));
		model.addAttribute("page", page);
		return new ModelAndView("board/reviewListSearch", "list", list);
	}

	// 후기 글 조회===============================================
	@RequestMapping(value = "/reviewRead.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView reviewRead(Board board, @ModelAttribute("page") Page page, Model model) throws Exception {
		board.setBoardName("review");
		model.addAttribute("page", page);

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/reviewRead", "read", boardDao.read(board));
	}
	
	// 후기 조회 수 증가
	@RequestMapping(value = "/reviewUpdateClick.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public ModelAndView reviewUpdateClick(Board board) throws Exception{
		board.setBoardName("review");
		board.setClick(board.getClick()+1);
		boardDao.updateClick(board);
		return null;
	}

	// 후기 글 수정 ==================================================
	@RequestMapping(value = "/reviewModify.do", method = RequestMethod.POST)
	public ModelAndView reviewModify(Board board, @ModelAttribute("page") Page page, RedirectAttributes rttr, Model model)
			throws Exception {
		board.setBoardName("review");
		rttr.addAttribute("page", page.getPage());
		rttr.addAttribute("perPageNum", page.getPerPageNum());
		rttr.addAttribute("searchType", page.getSearchType());
		rttr.addAttribute("keyword", page.getKeyword());
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/reviewModify", "modify", board);
	}

	// 후기 글 업데이트====================================================
	@RequestMapping(value = "/reviewUpdate.do", method = RequestMethod.POST)
	public ModelAndView reviewUpdate(Board board, @ModelAttribute("page") Page page, RedirectAttributes rttr,
			Model model, MultipartHttpServletRequest request, @RequestParam Map<String, String> mapmap) throws Exception {
		board.setBoardName("review");
		boardDao.update(board, request, mapmap);
		rttr.addAttribute("page", page.getPage());
		rttr.addAttribute("perPageNum", page.getPerPageNum());
		rttr.addAttribute("searchType", page.getSearchType());
		rttr.addAttribute("keyword", page.getKeyword());
		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/reviewRead", "read", boardDao.read(board));
	}

	// 후기 글 삭제====================================================
	@RequestMapping(value = "/reviewDelete.do", method = RequestMethod.POST)
	public ModelAndView reviewDelete(Board board, @ModelAttribute("page") Page page, Model model) throws Exception {
		board.setBoardName("review");
		boardDao.delete(board);
		List<Board> list = boardDao.listSearch(board, page);

		page.setTotalCount(boardDao.countSearch(board, page));
		model.addAttribute("page", page);
		return new ModelAndView("board/reviewListSearch", "list", list);
	}

	// 후기 글 목록 ===========================================================
	@RequestMapping(value = "/reviewList.do")
	public ModelAndView reviewList(Board board) throws Exception {
		board.setBoardName("review");
		List<Board> list = boardDao.list(board);
		return new ModelAndView("board/reviewList", "list", list);
	}

	// 후기 글 목록 + 페이징=================================================
	@RequestMapping(value = "/reviewListPage.do")
	public ModelAndView reviewListPage(Board board, Page page, Model model) throws Exception {
		board.setBoardName("review");
		List<Board> list = boardDao.list(board, page);

		page.setTotalCount(boardDao.listCount(board));
		model.addAttribute("page", page);
		return new ModelAndView("board/reviewList", "list", list);
	}

	// 후기 글 목록 + 페이징 + 검색==============================================
	@RequestMapping(value = "/reviewListSearch.do")
	public ModelAndView reviewListSearch(Board board, Page page, Model model) throws Exception {
		board.setBoardName("review");
		List<Board> list = boardDao.listSearch(board, page);
		
		Board board2 = new Board();
		board2.setBoardName("notice");
		List<Board> notice = boardDao.listSearch(board2, new Page());
		model.addAttribute("notice", notice);
		
		page.setTotalCount(boardDao.countSearch(board, page));
		model.addAttribute("page", page);
		return new ModelAndView("board/reviewListSearch", "list", list);
	}
	
	// 후기 댓글 작성
	@RequestMapping(value = "/reviewReplyWrite.do", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView reviewReplyWrite(Board board, Reply reply, Page page, Model model) throws Exception {
		board.setBoardName("review");
		replyDao.writeReply(board, reply);

		model.addAttribute("page", page);

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/reviewRead", "read", boardDao.read(board));
	}
	
	// 후기 댓글 삭제
	@RequestMapping(value="/reviewReplyDelete.do", method = RequestMethod.POST)
	public ModelAndView reviewReplyDelete(Board board, Reply reply, Page page, Model model) throws Exception{
		board.setBoardName("review");
		replyDao.deleteReply(board, reply);

		model.addAttribute("page", page);

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/reviewRead", "read", boardDao.read(board));
	}
	
	// 후기 추천 수 갱신
	@RequestMapping(value = "/reviewUpdateRecommend.do", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView reviewUpdateRecommend(Board board, Page page, Model model) throws Exception {
		board.setBoardName("review");
		replyDao.updateRecommend(board);

		model.addAttribute("page", page);

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/reviewRead", "read", boardDao.read(board));
	}
	
	// 질문 글 쓰기 =============================================================
	@RequestMapping(value = "/qnaInsert.do", method = RequestMethod.POST)
	public ModelAndView qnaInsert(Board board, Page page, Model model, MultipartHttpServletRequest request) throws Exception {
		board.setBoardName("qna");
		boardDao.write(board, request);
		
		List<Board> list = boardDao.listSearch(board, page);

		page.setTotalCount(boardDao.countSearch(board, page));
		model.addAttribute("page", page);
		return new ModelAndView("board/qnaListSearch", "list", list);
	}

	// 질문 글 조회===============================================
	@RequestMapping(value = "/qnaRead.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView qnaRead(Board board, @ModelAttribute("page") Page page, Model model) throws Exception {
		board.setBoardName("qna");
		model.addAttribute("page", page);

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/qnaRead", "read", boardDao.read(board));
	}
	
	// 질문 조회 수 증가
	@RequestMapping(value = "/qnaUpdateClick.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public ModelAndView qnaUpdateClick(Board board) throws Exception{
		board.setBoardName("qna");
		board.setClick(board.getClick()+1);
		boardDao.updateClick(board);
		return null;
	}

	// 질문 글 수정 ==================================================
	@RequestMapping(value = "/qnaModify.do", method = RequestMethod.POST)
	public ModelAndView qnaModify(Board board, @ModelAttribute("page") Page page, RedirectAttributes rttr, Model model)
			throws Exception {
		board.setBoardName("qna");
		rttr.addAttribute("page", page.getPage());
		rttr.addAttribute("perPageNum", page.getPerPageNum());
		rttr.addAttribute("searchType", page.getSearchType());
		rttr.addAttribute("keyword", page.getKeyword());
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/qnaModify", "modify", board);
	}

	// 질문 글 업데이트====================================================
	@RequestMapping(value = "/qnaUpdate.do", method = RequestMethod.POST)
	public ModelAndView qnaUpdate(Board board, @ModelAttribute("page") Page page, RedirectAttributes rttr,
			Model model, MultipartHttpServletRequest request, @RequestParam Map<String, String> mapmap) throws Exception {
		board.setBoardName("qna");
		boardDao.update(board, request, mapmap);
		rttr.addAttribute("page", page.getPage());
		rttr.addAttribute("perPageNum", page.getPerPageNum());
		rttr.addAttribute("searchType", page.getSearchType());
		rttr.addAttribute("keyword", page.getKeyword());
		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/qnaRead", "read", boardDao.read(board));
	}

	// 질문 글 삭제====================================================
	@RequestMapping(value = "/qnaDelete.do", method = RequestMethod.POST)
	public ModelAndView qnaDelete(Board board, @ModelAttribute("page") Page page, Model model) throws Exception {
		board.setBoardName("qna");
		boardDao.delete(board);
		List<Board> list = boardDao.listSearch(board, page);

		page.setTotalCount(boardDao.countSearch(board, page));
		model.addAttribute("page", page);
		return new ModelAndView("board/qnaListSearch", "list", list);
	}

	// 질문 글 목록 ===========================================================
	@RequestMapping(value = "/qnaList.do")
	public ModelAndView qnaList(Board board) throws Exception {
		board.setBoardName("qna");
		List<Board> list = boardDao.list(board);
		return new ModelAndView("board/qnaList", "list", list);
	}

	// 질문 글 목록 + 페이징=================================================
	@RequestMapping(value = "/qnaListPage.do")
	public ModelAndView qnaListPage(Board board, Page page, Model model) throws Exception {
		board.setBoardName("qna");
		List<Board> list = boardDao.list(board, page);

		page.setTotalCount(boardDao.listCount(board));
		model.addAttribute("page", page);
		return new ModelAndView("board/qnaList", "list", list);
	}

	// 질문 글 목록 + 페이징 + 검색==============================================
	@RequestMapping(value = "/qnaListSearch.do")
	public ModelAndView qnaListSearch(Board board, Page page, Model model) throws Exception {
		board.setBoardName("qna");
		List<Board> list = boardDao.listSearch(board, page);
		
		Board board2 = new Board();
		board2.setBoardName("notice");
		List<Board> notice = boardDao.listSearch(board2, new Page());
		model.addAttribute("notice", notice);
		
		page.setTotalCount(boardDao.countSearch(board, page));
		model.addAttribute("page", page);
		return new ModelAndView("board/qnaListSearch", "list", list);
	}
	
	// 질문 댓글 작성
	@RequestMapping(value = "/qnaReplyWrite.do", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView qnaReplyWrite(Board board, Reply reply, Page page, Model model) throws Exception {
		board.setBoardName("qna");
		replyDao.writeReply(board, reply);

		model.addAttribute("page", page);

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/qnaRead", "read", boardDao.read(board));
	}
	
	// 질문 댓글 삭제
	@RequestMapping(value="/qnaReplyDelete.do", method = RequestMethod.POST)
	public ModelAndView qnaReplyDelete(Board board, Reply reply, Page page, Model model) throws Exception{
		board.setBoardName("qna");
		replyDao.deleteReply(board, reply);

		model.addAttribute("page", page);

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/qnaRead", "read", boardDao.read(board));
	}
	
	// 질문 추천 수 갱신
	@RequestMapping(value = "/qnaUpdateRecommend.do", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView qnaUpdateRecommend(Board board, Page page, Model model) throws Exception {
		board.setBoardName("qna");
		replyDao.updateRecommend(board);

		model.addAttribute("page", page);

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/qnaRead", "read", boardDao.read(board));
	}
	
	// 공지 글 쓰기 =============================================================
	@RequestMapping(value = "/noticeInsert.do", method = RequestMethod.POST)
	public ModelAndView noticeInsert(Board board, Page page, Model model, MultipartHttpServletRequest request) throws Exception {
		board.setBoardName("notice");
		boardDao.write(board, request);
		
		List<Board> list = boardDao.listSearch(board, page);

		page.setTotalCount(boardDao.countSearch(board, page));
		model.addAttribute("page", page);
		return new ModelAndView("board/noticeListSearch", "list", list);
	}

	// 공지 글 조회===============================================
	@RequestMapping(value = "/noticeRead.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView noticeRead(Board board, @ModelAttribute("page") Page page, Model model) throws Exception {
		board.setBoardName("notice");
		model.addAttribute("page", page);

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/noticeRead", "read", boardDao.read(board));
	}
	
	// 공지 조회 수 증가
	@RequestMapping(value = "/noticeUpdateClick.do", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public ModelAndView noticeUpdateClick(Board board) throws Exception{
		board.setBoardName("notice");
		board.setClick(board.getClick()+1);
		boardDao.updateClick(board);
		return null;
	}

	// 공지 글 수정 ==================================================
	@RequestMapping(value = "/noticeModify.do", method = RequestMethod.POST)
	public ModelAndView noticeModify(Board board, @ModelAttribute("page") Page page, RedirectAttributes rttr, Model model)
			throws Exception {
		board.setBoardName("notice");
		rttr.addAttribute("page", page.getPage());
		rttr.addAttribute("perPageNum", page.getPerPageNum());
		rttr.addAttribute("searchType", page.getSearchType());
		rttr.addAttribute("keyword", page.getKeyword());
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/noticeModify", "modify", board);
	}

	// 공지 글 업데이트====================================================
	@RequestMapping(value = "/noticeUpdate.do", method = RequestMethod.POST)
	public ModelAndView noticeUpdate(Board board, @ModelAttribute("page") Page page, RedirectAttributes rttr,
			Model model, MultipartHttpServletRequest request, @RequestParam Map<String, String> mapmap) throws Exception {
		board.setBoardName("notice");
		boardDao.update(board, request, mapmap);
		rttr.addAttribute("page", page.getPage());
		rttr.addAttribute("perPageNum", page.getPerPageNum());
		rttr.addAttribute("searchType", page.getSearchType());
		rttr.addAttribute("keyword", page.getKeyword());
		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/noticeRead", "read", boardDao.read(board));
	}

	// 공지 글 삭제====================================================
	@RequestMapping(value = "/noticeDelete.do", method = RequestMethod.POST)
	public ModelAndView noticeDelete(Board board, @ModelAttribute("page") Page page, Model model) throws Exception {
		board.setBoardName("notice");
		boardDao.delete(board);
		List<Board> list = boardDao.listSearch(board, page);

		page.setTotalCount(boardDao.countSearch(board, page));
		model.addAttribute("page", page);
		return new ModelAndView("board/noticeListSearch", "list", list);
	}

	// 공지 글 목록 ===========================================================
	@RequestMapping(value = "/noticeList.do")
	public ModelAndView noticeList(Board board) throws Exception {
		board.setBoardName("notice");
		List<Board> list = boardDao.list(board);
		return new ModelAndView("board/noticeList", "list", list);
	}

	// 공지 글 목록 + 페이징=================================================
	@RequestMapping(value = "/noticeListPage.do")
	public ModelAndView noticeListPage(Board board, Page page, Model model) throws Exception {
		board.setBoardName("notice");
		List<Board> list = boardDao.list(board, page);

		page.setTotalCount(boardDao.listCount(board));
		model.addAttribute("page", page);
		return new ModelAndView("board/noticeList", "list", list);
	}

	// 공지 글 목록 + 페이징 + 검색==============================================
	@RequestMapping(value = "/noticeListSearch.do")
	public ModelAndView noticeListSearch(Board board, Page page, Model model) throws Exception {
		board.setBoardName("notice");
		List<Board> list = boardDao.listSearch(board, page);
		
		Board board2 = new Board();
		board2.setBoardName("notice");
		List<Board> notice = boardDao.listSearch(board2, new Page());
		model.addAttribute("notice", notice);
		
		page.setTotalCount(boardDao.countSearch(board, page));
		model.addAttribute("page", page);
		return new ModelAndView("board/noticeListSearch", "list", list);
	}
	
	// 공지 댓글 작성
	@RequestMapping(value = "/noticeReplyWrite.do", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView noticeReplyWrite(Board board, Reply reply, Page page, Model model) throws Exception {
		board.setBoardName("notice");
		replyDao.writeReply(board, reply);

		model.addAttribute("page", page);

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/noticeRead", "read", boardDao.read(board));
	}
	
	// 공지 댓글 삭제
	@RequestMapping(value="/noticeReplyDelete.do", method = RequestMethod.POST)
	public ModelAndView noticeReplyDelete(Board board, Reply reply, Page page, Model model) throws Exception{
		board.setBoardName("notice");
		replyDao.deleteReply(board, reply);

		model.addAttribute("page", page);

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/noticeRead", "read", boardDao.read(board));
	}
	
	// 공지 추천 수 갱신
	@RequestMapping(value = "/noticeUpdateRecommend.do", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView noticeUpdateRecommend(Board board, Page page, Model model) throws Exception {
		board.setBoardName("notice");
		replyDao.updateRecommend(board);

		model.addAttribute("page", page);

		List<Reply> repList = replyDao.readReply(board);
		model.addAttribute("repList", repList);
		
		List<ImageFile> image = boardDao.readImage(board);
		model.addAttribute("image", image);
		
		return new ModelAndView("board/noticeRead", "read", boardDao.read(board));
	}
}
