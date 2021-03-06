package com.ssafy.happyhouse.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.dto.Member;
import com.ssafy.happyhouse.model.service.MemberService;

/**
 * Servlet implementation class Member_control
 */
//@WebServlet("/Member_control")
@Controller
@RequestMapping("/Member_control")
public class Member_control extends HttpServlet {
   private static final long serialVersionUID = 1L;

   @Autowired
   private MemberService MemberService;
   /**
    * @see HttpServlet#HttpServlet()
    */
   @GetMapping("/mv_home")
   public String mv_home()  {
      
      // TODO Auto-generated method stub
      return "index";
   }
   
   //@RequestMapping(value = "/login_page", method = RequestMethod.GET)
   @GetMapping("/login_page")
   public String move_login_page()  {
      
      // TODO Auto-generated method stub
      return "login";
   }
   
   @RequestMapping(value = "/register_page", method = RequestMethod.GET)
   public String move_register_page() {
      // TODO Auto-generated method stub
      return "register";
   }
   
   @RequestMapping(value = "/logout", method = RequestMethod.GET)
   public String logout(HttpServletRequest request) {
      // TODO Auto-generated method stub
      /*Cookie[] cookies = request.getCookies();

      // 1. cookie ??????
      if (cookies != null) {
         for (Cookie cookie : cookies) {
            if (cookie.getName().equals("loginId")) {

               cookie.setMaxAge(0);
               cookie.setPath("/");
               response.addCookie(cookie);
               break;
            }
         }
      }
      */
      // 2. session ??????
      HttpSession session = request.getSession();
      session.removeAttribute("loginId"); // ?????? ????????? ????????? ?????? ??? ??????. ??????????????? ????????? ??????
      session.invalidate();
      
      // 3. index.jsp??? ??????
      return "index";
   }
   @RequestMapping(value = "/Edit_info_page", method = RequestMethod.GET)
   public String move_edit_info_page(){
      // TODO Auto-generated method stub
      return "Member_Edit";
   }
   /*
   @RequestMapping(value = "/basic_Info", method = RequestMethod.GET)
   public String basic_info(HttpServletRequest request, HttpServletResponse response) throws IOException {
      // TODO Auto-generated method stub
      PrintWriter out = response.getWriter();
      Member member = null;
      JSONArray arr = new JSONArray();
      HttpSession session = request.getSession();
      String id = (String) session.getAttribute("loginId");

      try {
         member = MemberService.selectService(id); // select ????????? ??? ????????????
         JSONObject obj = new JSONObject();
         obj.put("user_id", member.getId());
         obj.put("user_passwd", member.getPasswd());
         obj.put("user_name", member.getName());
         obj.put("user_email", member.getEmail());
         arr.add(obj);
      } catch (Exception e) {
         arr = new JSONArray();
         JSONObject obj = new JSONObject();
         obj.put("message_code", "-1");
         arr.add(obj);
         e.printStackTrace();
      } finally {
         out.print(arr.toJSONString());
         out.close();
      }
      return "Member_Edit";
   }
   */
   @GetMapping("/delete")
   public String delete(HttpServletRequest request, HttpSession session)  {
      // TODO Auto-generated method stub
      int result =0;
      String target = "";
      // 2-1. Service ??? inser ??? ????????? DTO ?????? ??????
      String id = (String) session.getAttribute("loginId");
      
      try {
         result = MemberService.delete(id);
         System.out.println("result : " + result);
         System.out.println("id : " + id);
         
         if (result > 0) {
            request.setAttribute("msg", "?????? ?????? ! ");
            System.out.println("delete ?????? ! ");
            
            // 2. session ??????
            session.removeAttribute("loginId"); // ?????? ????????? ????????? ?????? ??? ??????. ??????????????? ????????? ??????
            session.invalidate();
            target = "index";
            // index.jsp forward
         } else {
            System.out.println("?????? ?????? ???????????????. ");
            target = "Member_Edit";
         } 
      }catch ( Exception e ) {
         e.printStackTrace();
         System.out.println("Delete ?????? ??????");
      }
/*
      // 3. ???????????? ??????
      if (result == 1) {
         request.setAttribute("msg", "?????? ?????? ! ");
         System.out.println("delete ?????? ! ");
         
         // 2. session ??????
         session.invalidate();
         // index.jsp forward
      } else {
         System.out.println("?????? ?????? ???????????????. ");
      } */
      return target;
   }
   @RequestMapping(value = "/login", method = RequestMethod.POST)
   public String login(@RequestParam Map<String, String> map, HttpServletRequest request, HttpServletResponse response)
         throws Exception {
      // TODO Auto-generated method stub
      System.out.println("login ?????? ! ");
      Member member = null;
      String target = "";
//      String id = request.getParameter("id");
//      String pass = request.getParameter("passwd");
      String id = map.get("id");
      String pass = map.get("passwd");
      System.out.println("?????? ????????? id : " + id );
      System.out.println("?????? ????????? pw : " + pass );
      
      try {
         Member result = MemberService.login(map);
         if( result == null ) {
            System.out.println("????????? ??????!! ");
            request.setAttribute("msg", "????????? / ??????????????? ???????????????.");
            target = "login";

         } else {
            System.out.println("????????? ??????! ");
            HttpSession session = request.getSession();
            session.setAttribute("loginId", id);
            session.setAttribute("loginpasswd", result.getPasswd());
            session.setAttribute("loginname", result.getName());
            session.setAttribute("loginemail", result.getEmail());
            // ????????? ????????? ?????????.
            System.out.println(session.toString());
            target = "index";
         }
         
      }
      catch( Exception e ) {
         e.printStackTrace();
         System.out.println("????????? ?????? ??????");
      }
      /*
      // ?????? -> main.jsp, ?????? ??????, ?????? ??????
      if (result) {
         Cookie cookie = new Cookie("loginId", id);
         cookie.setMaxAge(60 * 1);
         cookie.setPath("/");
         response.addCookie(cookie);

         // ????????? ????????? ?????????
         member = MemberService.selectService(id);
         HttpSession session = request.getSession();
         session.setAttribute("loginId", id);
         session.setAttribute("loginpasswd", member.getPasswd());
         session.setAttribute("loginname", member.getName());
         session.setAttribute("loginemail", member.getEmail());
         //response.sendRedirect(request.getContextPath() + "/index.jsp");
         target = "index";
      }
      // ?????? --> index.jsp
      else {
         request.setAttribute("msg", "????????? / ??????????????? ???????????????.");
         System.out.println("login ?????? ");
         RequestDispatcher disp = request.getRequestDispatcher("/login.jsp");
         target = "login";
         //disp.forward(request, response);
      }
      */
      
      return target;
   }
   
   @PostMapping("/register")
   public String register(HttpServletRequest request) throws Exception{
         
      // TODO Auto-generated method stub
      String target = "";
      // 1. parameter ?????? --> Member
      String id = request.getParameter("id");
      String name = request.getParameter("pw");
      String pass = request.getParameter("name");
      String email = request.getParameter("email");
      Member member = new Member(id, name, pass, email);
      System.out.println(member.toString());
      // 2. member??? Service??? ??????
      // 2-1. Service ??? inser ??? ????????? DTO ?????? ??????
      try {
         
         int mem = MemberService.register(member);
         System.out.println( " ????????? ??? : " + mem );
         if( mem == 0 ) {
            request.setAttribute("msg", "?????? ?????? ????????????.");
            System.out.println( " ?????? ?????? "  );
            target = "register";
         } else {
            request.setAttribute("msg", "?????? ??????, ????????? ??? ??????????????????.");
            System.out.println( " ?????? ??????  " );
            
            target = "login";
         }
      }catch(Exception e ) {
         e.printStackTrace();
         System.out.println("????????????");
      }
       /*
      // 3. login ??????
      if (result == 1) {
         request.setAttribute("msg", "?????? ??????, ????????? ??? ??????????????????.");
         System.out.println("?????? ?????? ?????? !!");
         // index.jsp forward
         RequestDispatcher disp = request.getRequestDispatcher("/login.jsp");
         //disp.forward(request, response);
         target = "login";
      } else {
         request.setAttribute("msg", "?????? ?????? ????????????.");
         System.out.println(" ?????? ?????? ?????? !!");
         RequestDispatcher disp = request.getRequestDispatcher("/register.jsp");
         //disp.forward(request, response);
         target = "register";
      }
      */
      return target;
   }
   @PostMapping("/edit")
   public String edit(HttpServletRequest request)
         throws SQLException {
      // TODO Auto-generated method stub
      
      System.out.println("?????? ???????????? ! ");
      String target = "";
      String id = request.getParameter("id");
      String pass = request.getParameter("pw");
      String name = request.getParameter("name");
      String email = request.getParameter("email");
      Member member = new Member(id, pass, name, email);

      // 2. member??? Service??? ??????
      // 2-1. Service ??? inser ??? ????????? DTO ?????? ??????
      try {
         
         int result = MemberService.edit(member);
         if( result == 0 ) {
            request.setAttribute("msg", "?????? ?????? ????????????.");
            System.out.println(" ?????? ?????? ?????? ?????? !!");
            target = "Member_Edit";
         } else {
            request.setAttribute("msg", "?????? ??????, ????????? ??? ??????????????????.");
            System.out.println("?????? ?????? ?????? ??????  !!");
            member = MemberService.selectService(id);
            HttpSession session = request.getSession();
            session.setAttribute("loginId", id);
            session.setAttribute("loginpasswd", member.getPasswd());
            session.setAttribute("loginname", member.getName());
            session.setAttribute("loginemail", member.getEmail());
            target = "index";
         }
         
      } catch( Exception e ) {
         e.printStackTrace();
         request.setAttribute("msg", "?????? ??????.");
         System.out.println("????????????!");
      }
      /*
      // 3. login ??????
      if (result == 1) {
         request.setAttribute("msg", "?????? ??????, ????????? ??? ??????????????????.");
         System.out.println("?????? ?????? ?????? ??????  !!");
         
         // session ??? ??????????????? ???????????? 
         member = MemberService.selectService(id);
         HttpSession session = request.getSession();
         session.setAttribute("loginId", id);
         session.setAttribute("loginpasswd", member.getPasswd());
         session.setAttribute("loginname", member.getName());
         session.setAttribute("loginemail", member.getEmail());
         
         // index.jsp forward
         RequestDispatcher disp = request.getRequestDispatcher("/index.jsp");
         //disp.forward(request, response);
         target = "index";
      } else {
         request.setAttribute("msg", "?????? ?????? ????????????.");
         System.out.println(" ?????? ?????? ?????? ?????? !!");
         RequestDispatcher disp = request.getRequestDispatcher("/Member_Edit.jsp");
         //disp.forward(request, response);
         target = "Member_Edit";
      }
      */
      return target;
   }
}