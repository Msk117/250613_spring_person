package com.koreait.www.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class PagingVO {

	private int pageNo;
	private int qty;

	private String type;
	private String keyword;

	private String sort;
	
	public PagingVO() {
		this.pageNo = 1;
		this.qty = 10;
	}

	public PagingVO(int pageNo, int qty) {
		this.pageNo = pageNo;
		this.qty = qty;
	}

	public int getPageStart() {
		return (this.pageNo - 1) * this.qty;
	}

	public String[] getTypeToArray() {
		return this.type == null ? new String[] {} : this.type.split("");
	}

}
