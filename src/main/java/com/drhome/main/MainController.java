package com.drhome.main;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.drhome.search.SearchService;

@Controller
public class MainController {
	@Autowired
	MainService mainService;
	@Autowired
	SearchService searchService;

	

}
