package com.ChaMg.MyProJect.StudyBoard_Recruit;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ChaMg.MyProJect.StudyBoard_Recruit.UploadFileUtils;
import com.ChaMg.MyProJect.StudyBoard_Recruit.MediaUtils;

@Controller
@RequestMapping("/sample/upload/*")
public class UploadController {
	@Autowired
	SqlSession sqlsession;
	
	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	private String base_uploadPath = uploadPath;
	
	@RequestMapping(value = "/uploadForm", method = RequestMethod.GET)
	public String uploadFormGET() {
		return "/sample/upload/uploadForm";
	}
	
	//Post 방식 파일 업로드
	@RequestMapping(value = "/uploadForm", method = RequestMethod.POST)
	public String uploadFormPOST(MultipartFile file, Model model) throws Exception {
		
		logger.info("uploadFormPost");
		
		if(file != null) {
			logger.info("originalName:" + file.getOriginalFilename());
			logger.info("size:" + file.getSize());
			logger.info("ContentType:" + file.getContentType());
		}
		
		String savedName = uploadFile(file.getOriginalFilename(), file.getBytes());
		
		model.addAttribute("savedName", savedName);
		
		return "/sample/upload/uploadForm";
	}
	
	//업로드된 파일을 저장하는 함수
	private String uploadFile(String originalName, byte[] fileDate) throws IOException {
		
		UUID uid = UUID.randomUUID();
		
		String savedName = uid.toString() + "_" + originalName;
		File target = new File(uploadPath, savedName);
		
		//org.springframework.util 패키지의 FileCopyUtils는 파일 데이터를 파일로 처리하거나, 복사하는 등의 기능이 있다.
		FileCopyUtils.copy(fileDate, target);
		
		return savedName;
		
	}
	
	//Ajax 파일 업로드
	@RequestMapping(value="/sample/upload/uploadAjax", method = RequestMethod.GET)
	public String uploadAjaxGET() {
		return "/sample/upload/uploadAjax";
	}
	
	
	//Ajax 파일 업로드 produces는 한국어를 정상적으로 전송하기 위한 속성
	@ResponseBody
	@RequestMapping(value="/sample/upload/uploadAjax", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> uploadAjaxPOST(MultipartFile file, String id) throws Exception {
		
		logger.info("originalName:" + file.getOriginalFilename());
		logger.info("size:" + file.getSize());
		logger.info("contentType:" + file.getContentType());
		System.out.println("uploadPath yeah="+uploadPath+id);
		String baseloot = "STRC";
		base_uploadPath = uploadPath+baseloot+"\\\\"+id;
		//String savedName = uploadFile(file.getOriginalFilename(), file.getBytes());
		
		//HttpStatus.CREATED : 리소스가 정상적으로 생성되었다는 상태코드.
		//return new ResponseEntity<>(file.getOriginalFilename(), HttpStatus.CREATED);
		return new ResponseEntity<String>(UploadFileUtils.uploadFile(base_uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.CREATED);
	}
	
	//화면에 저장된 파일을 보여주는 컨트롤러
	// displayFile?fileName=
	@ResponseBody
	@RequestMapping(value="/sample/upload/displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		logger.info("File name: " + fileName);
		
		try {
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
			
			MediaType mType = MediaUtils.getMediaType(formatName);
			System.out.println(mType);
			
			HttpHeaders headers = new HttpHeaders();
			
			in = new FileInputStream(base_uploadPath + fileName);
			
			
			if(mType != null) {
				headers.setContentType(mType);
			}else {
				fileName = fileName.substring(fileName.indexOf("_")+1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
			}// else
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		
		return entity;
	}// displayFile
	
	
	//업로드된 파일 삭제 처리
	@ResponseBody
	@RequestMapping(value="/sample/upload/deleteFile", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName) throws Exception {
		logger.info("delete file:" + fileName);
		String primary_location = fileName.substring(3);
		String thum_location = fileName.substring(1);
		System.out.println(thum_location);
		int base_length = base_uploadPath.length();
		System.out.println(base_length);
		File deletepath1 = new File(base_uploadPath);
		File[] deleteFolder1 = deletepath1.listFiles();
		for (int j = 0; j < deleteFolder1.length; j++  ) {
			String img_file = deleteFolder1[j].toString().substring(base_length-3);
			String thum_file = deleteFolder1[j].toString().substring(base_length-3);
			System.out.println(thum_file);
			if(primary_location.equals(img_file) || thum_location.equals(thum_file)) {
				deleteFolder1[j].delete();
			}
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
		
	}
	
	//업로드된 파일 수정 처리
		@ResponseBody
		@RequestMapping(value="/sample/upload/updateFile")
		public ResponseEntity<String> updateFile(
				@RequestParam("fileName") String fileName,
				@RequestParam("id") String id) throws Exception {
			String baseloot = "STRC";
			base_uploadPath = uploadPath+baseloot+"\\\\"+id;
			logger.info("delete file:" + fileName);
			String primary_location = fileName.substring(3);
			String thum_location = fileName.substring(1);
			int base_length = base_uploadPath.length();
			File deletepath1 = new File(base_uploadPath);
			File[] deleteFolder1 = deletepath1.listFiles();
			for (int j = 0; j < deleteFolder1.length; j++  ) {
				System.out.println("이까지 되나?");
				String img_file = deleteFolder1[j].toString().substring(base_length-3);
				String thum_file = deleteFolder1[j].toString().substring(base_length-3);
				System.out.println(thum_file);
				if(primary_location.equals(img_file) || thum_location.equals(thum_file)) {
					deleteFolder1[j].delete();
				}
			}
			return new ResponseEntity<String>("deleted", HttpStatus.OK);
			
		}
}
