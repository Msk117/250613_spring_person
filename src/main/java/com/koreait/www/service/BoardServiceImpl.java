package com.koreait.www.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.koreait.www.domain.BoardDTO;
import com.koreait.www.domain.BoardVO;
import com.koreait.www.domain.FileVO;
import com.koreait.www.domain.PagingVO;
import com.koreait.www.repository.BoardDAO;
import com.koreait.www.repository.FileDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {

	private final BoardDAO bdao;
	private final FileDAO fdao;

	@Transactional
	@Override
	public int insert(BoardDTO bdto) {

		int isOk = bdao.insert(bdto.getBvo());
		if (bdto.getFlist() == null) {
			return isOk;
		}

		if (isOk > 0) {
			long bno = bdao.getBno();
			for (FileVO fvo : bdto.getFlist()) {
				fvo.setBno(bno);

				isOk *= fdao.insertFile(fvo);
			}
			isOk *= bdao.fileQtyUpdate(bno, bdto.getFlist().size());
		}
		return isOk;
	}

	@Override
	public List<BoardVO> getList(PagingVO pgvo) {
		return bdao.getList(pgvo);
	}

	@Transactional
	@Override
	public BoardDTO getDetail(long bno) {
		// TODO Auto-generated method stub
		BoardVO bvo = bdao.getDetail(bno);
		List<FileVO> flist = fdao.getList(bno);
		BoardDTO bdto = new BoardDTO(bvo, flist);
		return bdto;
	}

	@Transactional
	@Override
	public int update(BoardDTO boardDTO) {

		if (boardDTO == null || boardDTO.getBvo() == null) {
			log.error("❌ BoardDTO 또는 내부 BVO가 null입니다.");
			return 0;
		}

		BoardVO bvo = boardDTO.getBvo();
		Long bno = bvo.getBno();

		if (bno == null || bno <= 0) {
			log.error("❌ 유효하지 않은 bno: {}", bno);
			return 0;
		}

		int isOk = bdao.readCountUp(bno, -1);

		if (isOk > 0) {
			isOk *= bdao.update(bvo);
		}

		List<FileVO> flist = boardDTO.getFlist();
		if (flist == null || flist.isEmpty()) {
			return isOk;
		}

		if (isOk > 0) {
			for (FileVO fvo : flist) {
				fvo.setBno(bno);
				int fileOk = fdao.insertFile(fvo);
				if (fileOk <= 0) {
					log.warn("❗ 파일 저장 실패: {}", fvo);
				}
				isOk *= fileOk;
			}

		}

		return isOk;
	}

	@Override
	public int delete(long bno) {
		// TODO Auto-generated method stub
		return bdao.delete(bno);
	}

	@Override
	public int readCountUp(long bno, int i) {
		// TODO Auto-generated method stub
		return bdao.readCountUp(bno, i);
	}

	@Override
	public int getTotalCount(PagingVO pgvo) {
		// TODO Auto-generated method stub
		return bdao.getTotalCount(pgvo);
	}

	@Transactional
	@Override
	public int removeFile(String uuid) {
		// TODO Auto-generated method stub
		long bno = fdao.getBno(uuid);
		int isOk = fdao.removeFile(uuid);
		if (isOk > 0) {
			isOk *= bdao.fileQtyUpdate(bno, -1);
		}
		return fdao.removeFile(uuid);
	}

	@Override
	public FileVO getFile(String uuid) {
		// TODO Auto-generated method stub
		return fdao.getFile(uuid);
	}

}
