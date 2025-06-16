package com.koreait.www.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreait.www.domain.BoardDTO;
import com.koreait.www.domain.BoardVO;
import com.koreait.www.domain.FileVO;
import com.koreait.www.domain.PagingVO;
import com.koreait.www.handler.FileHandler;
import com.koreait.www.handler.FileRemoveHandler;
import com.koreait.www.handler.PagingHandler;
import com.koreait.www.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/board/*")
@Slf4j
@RequiredArgsConstructor
@Controller
public class BoardController {

	private final BoardService bsv;
	private final FileHandler fh;;

	@GetMapping("/register")
	public void register() {
	}

	@PostMapping("/insert")
	public String insert(BoardVO bvo, MultipartFile[] files) {
		log.info(">>>> bvo >> {}", bvo);

		List<FileVO> flist = null;
		if (files[0].getSize() > 0) {
			flist = fh.uploadFile(files);
			log.info(">>> flist >> {}", flist);

		}
		BoardDTO bdto = new BoardDTO(bvo, flist);

		int isOk = bsv.insert(bdto);
		log.info(">>> insert isOk >> {}", (isOk > 0) ? "ok" : "fail");
		return "redirect:/board/list";
	}

	@GetMapping("/list")
	public void list(Model m, PagingVO pgvo) {

		
		if (pgvo.getSort() == null || pgvo.getSort().isEmpty()) {
			pgvo.setSort("recent");
		}

		List<BoardVO> list = bsv.getList(pgvo); 
		int totalCount = bsv.getTotalCount(pgvo);

		PagingHandler ph = new PagingHandler(totalCount, pgvo);
		log.info(">>> PagingHandler >> {}", ph);

		m.addAttribute("ph", ph);
		m.addAttribute("list", list);
	}

	@GetMapping({ "/detail", "/modify" })
	public String detail(@RequestParam(value = "bno", required = false) Long bno, Model m, HttpServletRequest request) {
		if (bno == null) {

			return "redirect:/board/list";
		}
		String path = request.getServletPath();
		log.info(">>>> uri >> {}", request.getRequestURI());
		if (path.equals("/board/detail")) {
			bsv.readCountUp(bno, 1);
		}
		BoardDTO bdto = bsv.getDetail(bno);
		if (bdto == null) {

			return "redirect:/board/list";
		}
		BoardVO prev = bsv.getPrev(bno);
		BoardVO next = bsv.getNext(bno);
		bdto.setPrev(prev);
		bdto.setNext(next);
		
		m.addAttribute("bdto", bdto);
		m.addAttribute("bvo", bdto.getBvo());
		m.addAttribute("flist", bdto.getFlist());

		if (path.equals("/board/modify")) {
			return "board/modify";
		} else {
			return "board/detail";
		}
	}

	@PostMapping("/update")
	public String update(BoardVO bvo, RedirectAttributes re,
			@RequestParam(value = "files", required = false) MultipartFile[] files) {

		log.info("Update 호출 - bvo: {}", bvo);

		if (bvo == null || bvo.getBno() == 0) {
			log.error("Invalid BoardVO or bno value.");
			return "redirect:/board/list";
		}

		List<FileVO> flist = null;
		if (files != null && files.length > 0 && files[0] != null && files[0].getSize() > 0) {
			flist = fh.uploadFile(files);
			log.info("Uploaded files: {}", flist);
		} else {
			log.info("No new files attached or files is null");
		}

		BoardDTO bdto = new BoardDTO(bvo, flist);
		log.info("BoardDTO 생성됨: {}", bdto);

		int isOk = bsv.update(bdto);
		log.info("Service.update 결과: {}", isOk);

		re.addAttribute("bno", bvo.getBno());
		return "redirect:/board/detail";
	}

	@GetMapping("/remove")
	public String remove(@RequestParam("bno") long bno) {
		int isOk = bsv.delete(bno);
		return "redirect:/board/list";

	}

	@ResponseBody
	@DeleteMapping("/file/{uuid}")
	public String fileDelete(@PathVariable("uuid") String uuid) {

		int isOk = bsv.removeFile(uuid);

		return isOk > 0 ? "1" : "0";
	}

}
