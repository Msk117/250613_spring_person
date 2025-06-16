package com.koreait.www.handler;

import java.util.List;

import com.koreait.www.domain.CommentVO;
import com.koreait.www.domain.PagingVO;

import lombok.Getter;

@Getter
public class PagingHandler {

	private int qty;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;

	private int totalCount;
	private PagingVO pgvo;

	private int realEndPage;

	private List<CommentVO> cmtList;

	public PagingHandler(int totalCount, PagingVO pgvo) {
		this.qty = 10;
		this.pgvo = pgvo;
		this.totalCount = totalCount;

		this.endPage = (int) Math.ceil(pgvo.getPageNo() / (double) this.qty) * this.qty;
		this.startPage = this.endPage - (this.qty - 1);

		this.realEndPage = (int) Math.ceil(totalCount / (double) pgvo.getQty());

		this.prev = this.startPage > 1;
		this.next = this.endPage < this.realEndPage;

		if (endPage > realEndPage) {
			this.endPage = realEndPage;
		}

	}

	public PagingHandler(int totalCount, PagingVO pgvo, List<CommentVO> cmtList) {
		this(totalCount, pgvo);
		this.cmtList = cmtList;
	}

}
