package com.koreait.www.handler;

import lombok.extern.slf4j.Slf4j;
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.tika.Tika;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.koreait.www.domain.FileVO;

import net.coobird.thumbnailator.Thumbnails;

@Slf4j
@Component
public class FileHandler {

	private final String UP_DIR = "D:\\web_0226_kms\\_myProject\\_java\\_fileUpload";

	public List<FileVO> uploadFile(MultipartFile[] files) {

		List<FileVO> flist = new ArrayList<FileVO>();

		LocalDate date = LocalDate.now();
		log.info(">>>> date >>{}", date);
		String today = date.toString();
		today = today.replace("-", File.separator);

		File folders = new File(UP_DIR, today);

		if (!folders.exists()) {
			folders.mkdirs();
		}

		for (MultipartFile file : files) {
			FileVO fvo = new FileVO();

			fvo.setSaveDir(today);
			fvo.setFileSize(file.getSize());
			log.info(">>> getName >> {}", file.getName());
			log.info(">>> getOriginalFilename >> {}", file.getOriginalFilename());
			String fileName = file.getOriginalFilename();
			fvo.setFileName(fileName);

			UUID uuid = UUID.randomUUID();
			String uuidStr = uuid.toString();
			fvo.setUuid(uuidStr);

			String fullFileName = uuidStr + "_" + fileName;
			File storeFile = new File(folders, fullFileName);

			log.info(">>>> file {}", storeFile);

			try {
				file.transferTo(storeFile);

				if (isImageFile(storeFile)) {
					fvo.setFileType(1);

					File thumbNail = new File(folders, uuidStr + "_th_" + fileName);
					Thumbnails.of(storeFile).size(100, 100).toFile(thumbNail);
				}

			} catch (Exception e) {
				// TODO: handle exception
				log.info("file store error");
				e.printStackTrace();
			}

			flist.add(fvo);
		}

		return flist;
	}

	private boolean isImageFile(File storeFile) throws IOException {

		String mimeType = new Tika().detect(storeFile);
		return mimeType.startsWith("image") ? true : false;
	}

}