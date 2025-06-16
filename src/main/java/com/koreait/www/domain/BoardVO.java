package com.koreait.www.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class BoardVO {
	/*
	 * create table board( bno bigint not null auto_increment, title varchar(200)
	 * not null, writer varchar(200) not null, content text, is_del varchar(5)
	 * default 'N', reg_date datetime default now(), read_count int default 0,
	 * primary key(bno));
	 */
	
	private Long bno;
	private String title;
	private String writer;
	private String content;
	private String isDel;
	private String regDate;
	private Integer readCount;
	private int cmtQty;
	private int fileQty;
	
	
	
}
