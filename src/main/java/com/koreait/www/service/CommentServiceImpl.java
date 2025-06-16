package com.koreait.www.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.koreait.www.domain.CommentVO;
import com.koreait.www.domain.PagingVO;
import com.koreait.www.handler.PagingHandler;
import com.koreait.www.repository.BoardDAO;
import com.koreait.www.repository.CommentDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService{
	
	private final CommentDAO cdao;
	private final BoardDAO bdao;

	@Override
	public int post(CommentVO cvo) {
		
		int isOk = cdao.post(cvo);
		if (isOk > 0 ) {
			isOk *= bdao.cmtQtyUpdate(cvo.getBno(), 1);
		}
		return cdao.post(cvo);
	}



	@Override
	public PagingHandler getList(long bno, PagingVO pgvo) {
		// TODO Auto-generated method stub
		List<CommentVO> list = cdao.getList(bno, pgvo);
		int totalCount = cdao.getTotal(bno);
		PagingHandler ph = new PagingHandler(totalCount, pgvo, list);
		return ph;
	}

	@Override
	public int remove(long cno, long bno) {
		// TODO Auto-generated method stub
		int isOk = cdao.remove(cno);
		if(isOk > 0) {
			isOk *= bdao.cmtQtyUpdate(bno, -1);
		}
		return cdao.remove(cno);
	}

	@Override
	public int update(CommentVO cvo) {
		// TODO Auto-generated method stub
		return cdao.update(cvo);
	}

	@Override
	public int remove(long cno) {
		// TODO Auto-generated method stub
		return cdao.remove(cno);
	}	
}
