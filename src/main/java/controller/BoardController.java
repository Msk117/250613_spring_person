package controller;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import service.BoardService;



@RequestMapping("/board/*")
@Slf4j
@RequiredArgsConstructor
@Controller
public class BoardController {

	private final BoardService bsv;
	
	 @RequestMapping("/home")
	    public String home() {
	        // /WEB-INF/views/home.jsp로 forward
	        return "home";
	    }
	
}
