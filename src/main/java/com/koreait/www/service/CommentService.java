package com.koreait.www.service;

import com.koreait.www.domain.CommentVO;
import com.koreait.www.domain.PagingVO;
import com.koreait.www.handler.PagingHandler;

public interface CommentService {

	int post(CommentVO cvo);

	PagingHandler getList(long bno, PagingVO pgvo);

	int remove(long cno);

	int update(CommentVO cvo);

	int remove(long cno, long bno);

}
