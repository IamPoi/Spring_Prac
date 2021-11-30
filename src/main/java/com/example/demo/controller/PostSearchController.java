package com.example.demo.controller;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.model.PostDTO;
import com.example.demo.model.UserDTO;
import com.example.demo.service.PostSearchService;

@Controller
@RequestMapping("/")
public class PostSearchController {
	
	@Autowired
	private PostSearchService pss;
	
	@GetMapping("post_search")
	public String postSearch(@RequestParam Map<String, Object> map,Model model, HttpSession session) {
		
			System.out.println("????");
		
		try {
			UserDTO user = (UserDTO)session.getAttribute("user");
			
			Long dong_num = user.getDong_num();	
			
			PostDTO postDto = new PostDTO(0, null, null, null, dong_num);
			
			String search = (String)map.get("search");
			
			postDto.setContent(search);
			
			ArrayList<PostDTO> post =(ArrayList<PostDTO>)pss.postSearch(postDto);
			
			System.out.println(post);
			
			model.addAttribute("post_list",post);
			
			System.out.println(post.get(0).getContent());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "post_search";
	}
	

}
