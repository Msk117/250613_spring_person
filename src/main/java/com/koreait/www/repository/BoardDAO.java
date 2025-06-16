package com.koreait.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.koreait.www.domain.BoardVO;
import com.koreait.www.domain.PagingVO;

public interface BoardDAO {

	List<BoardVO> getList(PagingVO pgvo);

	int insert(BoardVO bvo);

	BoardVO getDetail(long bno);

	int update(BoardVO bvo);

	int remove(BoardVO bno);

	int delete(long bno);

	int readCountUp(@Param("bno") long bno, @Param("i") int i);

	int getTotalCount(PagingVO pgvo);

	long getBno();

	int cmtQtyUpdate(@Param("bno")long bno, @Param("i")int i);

	int fileQtyUpdate(@Param("bno")long bno, @Param("size")int size);

	
}
