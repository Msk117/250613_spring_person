package com.koreait.www.handler;

import java.io.File;

import com.koreait.www.domain.FileVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileRemoveHandler {

	private final String DIR = "D:\\web_0226_kms\\_myProject\\_java\\_fileUpload";

	public int removeFile(FileVO fvo) {

		boolean isDel = false;

		File fileDir = new File(DIR, fvo.getSaveDir());
		String removeFile = fvo.getUuid() + "_" + fvo.getFileName();
		File deleteFile = new File(fileDir, removeFile);
		String removeThFile = fvo.getUuid() + "_th_" + fvo.getFileName();
		File deleteThFile = new File(fileDir, removeFile);

		try {

			if (deleteFile.exists()) {
				isDel = deleteFile.delete();
				log.info(">>>> delete File Success");
				if (fvo.getFileType() == 1 && deleteThFile.exists()) {
					isDel = deleteThFile.delete();
					log.info(">>>> delete File Success>> {}", deleteThFile.toString());

				}
			}

		} catch (Exception e) {
			// TODO: handle exception
			log.info(">>>> delete File Error");
			e.printStackTrace();
		}

		return isDel ? 1 : 0;
	}

}