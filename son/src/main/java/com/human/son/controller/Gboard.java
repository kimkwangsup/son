package com.human.son.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.human.son.dao.GboardDao;

@Controller
public class Gboard {
	@Autowired(required=false)
	GboardDao gDao;

}
