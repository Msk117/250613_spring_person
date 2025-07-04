package com.koreait.www.domain;

import java.util.List;

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
public class BoardDTO {
	
	private BoardVO bvo;
	private List<FileVO> flist;
	
	private BoardVO prev;
	private BoardVO next;
	
	public BoardDTO(BoardVO bvo, List<FileVO> flist) {
		this.bvo = bvo;
		this.flist = flist;
	}
}
