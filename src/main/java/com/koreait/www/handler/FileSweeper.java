package com.koreait.www.handler;

import java.io.File;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.koreait.www.domain.FileVO;
import com.koreait.www.repository.FileDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@EnableScheduling
@Slf4j
@Component
@RequiredArgsConstructor
public class FileSweeper {

	private final FileDAO fdao;

	private final String DIR = "D:\\web_0226_kms\\_myProject\\_java\\_fileUpload\\";

	@Scheduled(cron = "00 33 15 * * *")
	public void fileSweeper() {
		log.info(">>>> FileSweeper Running Start~!! : {}", LocalDateTime.now());

		List<FileVO> dbList = fdao.getAllFileList();

		List<String> currFiles = new ArrayList<>();
		for (FileVO fvo : dbList) {
			String filePath = fvo.getSaveDir() + File.separator + fvo.getUuid();
			String fileName = fvo.getFileName();
			currFiles.add(DIR + filePath + "_" + fileName);

			if (fvo.getFileType() == 1) {
				currFiles.add(DIR + filePath + "_th_" + fileName);
			}
		}
		log.info(">>>> currFiles >> {}", currFiles);

		LocalDate now = LocalDate.now();
		String today = now.toString();
		today = today.replace("-", File.separator);

		File dir = Paths.get(DIR + today).toFile();

		File[] allFileObject = dir.listFiles();
		log.info(">>>> all file Objec >> {}", allFileObject.toString());

		for (File file : allFileObject) {
			String storedFileName = file.toPath().toString();
			if (!currFiles.contains(storedFileName)) {
				file.delete(); // 존재하지 않는다면 삭제
				log.info(">>>> delete file Objec >> {}", storedFileName);
			}
		}

		log.info(">>>> FileSweeper Running End~!! : {}", LocalDateTime.now());
	}

}
