package service;

import java.util.List;

import domain.BoardVO;

public interface BoardService {
	List<BoardVO> getList(String sort);
	
    BoardVO getDetail(Long bno, boolean increaseReadCount);
    
    void register(BoardVO vo);
    
    void modify(BoardVO vo);
    
    void remove(Long bno);
}
