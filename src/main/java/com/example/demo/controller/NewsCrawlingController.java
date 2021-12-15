package com.example.demo.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.swing.text.BadLocationException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.model.NewsDTO;

@Controller
@RequestMapping("/")
public class NewsCrawlingController {
	
	@GetMapping("/")
	public String newsCrawling(Model model) throws IOException, BadLocationException {
	
		System.out.println("뉴스 크롤링");
		
		try {
		String headLine = "https://news.naver.com/";
		String boodong = "https://search.naver.com/search.naver?where=news&sm=tab_jum&query=부동산";
		
		Document doc = Jsoup.connect(headLine).get();
		Document doc2 = Jsoup.connect(boodong).get();
		
		Elements element = doc.select("div.cjs_journal_wrap>a");
//		System.out.println("11111");
		Elements element2 = doc2.select("div.news_area a.news_tit");
		
		Elements want_title = doc.select("div.cjs_t");
		
	
		
//		System.out.println(element);
		
		Iterator<Element> titles = element.iterator();
		Iterator<Element> titles2 = element2.iterator();
		
		String hrefs = titles.next().attr("abs:href");
		String hrefs2 = titles2.next().attr("abs:href");
		
//		System.out.println(hrefs);
//		System.out.println(hrefs2);
		
		NewsDTO dto = null;
		
		ArrayList<NewsDTO> newsList = new ArrayList<NewsDTO>();
		ArrayList<NewsDTO> newsList2 = new ArrayList<NewsDTO>();
		
//		System.out.println(element);
		
		// 반복문....
		for(Element ele : want_title) {
			
			String title = ele.ownText();
			
			dto = new NewsDTO(title, "");
			
			newsList.add(dto);
		}
		
		for(int i =0; i < newsList.size(); i++) {
			String href = element.get(i).attr("abs:href");
			
//			System.out.println("href="+href);
			
			newsList.get(i).setHref(href);
			
		}
		
		
		
		
		for(Element ele : element2) {
			String href = ele.attr("abs:href");
			
			String title = ele.ownText();
			
			dto = new NewsDTO(title, href);
			
			newsList2.add(dto);
			
		}
		
		model.addAttribute("newsList",newsList.subList(0, 5));
		model.addAttribute("newsList2",newsList2.subList(0, 5));
		
		} catch (Exception e) {
			System.out.println("JSoup 안됨");
		}
		
		return "index";
		
	}
	

}
