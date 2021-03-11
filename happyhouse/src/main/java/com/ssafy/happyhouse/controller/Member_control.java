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

      // 1. cookie 삭제
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
      // 2. session 종료
      HttpSession session = request.getSession();
      session.removeAttribute("loginId"); // 세션 안에는 여러개 넣을 수 있다. 장바구니에 이것이 적절
      session.invalidate();
      
      // 3. index.jsp로 이동
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
         member = MemberService.selectService(id); // select 통해서 값 가져오기
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
      // 2-1. Service 는 inser 를 위해서 DTO 사용 할듯
      String id = (String) session.getAttribute("loginId");
      
      try {
         result = MemberService.delete(id);
         System.out.println("result : " + result);
         System.out.println("id : " + id);
         
         if (result > 0) {
            request.setAttribute("msg", "삭제 성공 ! ");
            System.out.println("delete 성공 ! ");
            
            // 2. session 종료
            session.removeAttribute("loginId"); // 세션 안에는 여러개 넣을 수 있다. 장바구니에 이것이 적절
            session.invalidate();
            target = "index";
            // index.jsp forward
         } else {
            System.out.println("삭제 되지 않았습니다. ");
            target = "Member_Edit";
         } 
      }catch ( Exception e ) {
         e.printStackTrace();
         System.out.println("Delete 에러 발생");
      }
/*
      // 3. 삭제하기 유도
      if (result == 1) {
         request.setAttribute("msg", "삭제 성공 ! ");
         System.out.println("delete 성공 ! ");
         
         // 2. session 종료
         session.invalidate();
         // index.jsp forward
      } else {
         System.out.println("삭제 되지 않았습니다. ");
      } */
      return target;
   }
   @RequestMapping(value = "/login", method = RequestMethod.POST)
   public String login(@RequestParam Map<String, String> map, HttpServletRequest request, HttpServletResponse response)
         throws Exception {
      // TODO Auto-generated method stub
      System.out.println("login 시작 ! ");
      Member member = null;
      String target = "";
//      String id = request.getParameter("id");
//      String pass = request.getParameter("passwd");
      String id = map.get("id");
      String pass = map.get("passwd");
      System.out.println("내가 입력한 id : " + id );
      System.out.println("내가 입력한 pw : " + pass );
      
      try {
         Member result = MemberService.login(map);
         if( result == null ) {
            System.out.println("로그인 실패!! ");
            request.setAttribute("msg", "아이디 / 비밀번호를 확인하세요.");
            target = "login";

         } else {
            System.out.println("로그인 성공! ");
            HttpSession session = request.getSession();
            session.setAttribute("loginId", id);
            session.setAttribute("loginpasswd", result.getPasswd());
            session.setAttribute("loginname", result.getName());
            session.setAttribute("loginemail", result.getEmail());
            // 세션이 저장이 안된다.
            System.out.println(session.toString());
            target = "index";
         }
         
      }
      catch( Exception e ) {
         e.printStackTrace();
         System.out.println("로그인 에러 발생");
      }
      /*
      // 성공 -> main.jsp, 세션 등록, 쿠키 저장
      if (result) {
         Cookie cookie = new Cookie("loginId", id);
         cookie.setMaxAge(60 * 1);
         cookie.setPath("/");
         response.addCookie(cookie);

         // 세션에 태워서 보내기
         member = MemberService.selectService(id);
         HttpSession session = request.getSession();
         session.setAttribute("loginId", id);
         session.setAttribute("loginpasswd", member.getPasswd());
         session.setAttribute("loginname", member.getName());
         session.setAttribute("loginemail", member.getEmail());
         //response.sendRedirect(request.getContextPath() + "/index.jsp");
         target = "index";
      }
      // 실패 --> index.jsp
      else {
         request.setAttribute("msg", "아이디 / 비밀번호를 확인하세요.");
         System.out.println("login 실패 ");
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
      // 1. parameter 분석 --> Member
      String id = request.getParameter("id");
      String name = request.getParameter("pw");
      String pass = request.getParameter("name");
      String email = request.getParameter("email");
      Member member = new Member(id, name, pass, email);
      System.out.println(member.toString());
      // 2. member를 Service에 전달
      // 2-1. Service 는 inser 를 위해서 DTO 사용 할듯
      try {
         
         int mem = MemberService.register(member);
         System.out.println( " 등록건 수 : " + mem );
         if( mem == 0 ) {
            request.setAttribute("msg", "가입 실패 했습니다.");
            System.out.println( " 가입 실패 "  );
            target = "register";
         } else {
            request.setAttribute("msg", "가입 성공, 로그인 후 사용해주세요.");
            System.out.println( " 가입 성공  " );
            
            target = "login";
         }
      }catch(Exception e ) {
         e.printStackTrace();
         System.out.println("에러발생");
      }
       /*
      // 3. login 유도
      if (result == 1) {
         request.setAttribute("msg", "가입 성공, 로그인 후 사용해주세요.");
         System.out.println("회원 가입 성공 !!");
         // index.jsp forward
         RequestDispatcher disp = request.getRequestDispatcher("/login.jsp");
         //disp.forward(request, response);
         target = "login";
      } else {
         request.setAttribute("msg", "가입 실패 했습니다.");
         System.out.println(" 회원 가입 실패 !!");
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
      
      System.out.println("수정 컨트롤러 ! ");
      String target = "";
      String id = request.getParameter("id");
      String pass = request.getParameter("pw");
      String name = request.getParameter("name");
      String email = request.getParameter("email");
      Member member = new Member(id, pass, name, email);

      // 2. member를 Service에 전달
      // 2-1. Service 는 inser 를 위해서 DTO 사용 할듯
      try {
         
         int result = MemberService.edit(member);
         if( result == 0 ) {
            request.setAttribute("msg", "가입 실패 했습니다.");
            System.out.println(" 회원 정보 수정 실패 !!");
            target = "Member_Edit";
         } else {
            request.setAttribute("msg", "가입 성공, 로그인 후 사용해주세요.");
            System.out.println("회원 정보 수정 성공  !!");
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
         request.setAttribute("msg", "수정 실패.");
         System.out.println("수정실패!");
      }
      /*
      // 3. login 유도
      if (result == 1) {
         request.setAttribute("msg", "가입 성공, 로그인 후 사용해주세요.");
         System.out.println("회원 정보 수정 성공  !!");
         
         // session 값 변경된거로 바꿔주기 
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
         request.setAttribute("msg", "가입 실패 했습니다.");
         System.out.println(" 회원 정보 수정 실패 !!");
         RequestDispatcher disp = request.getRequestDispatcher("/Member_Edit.jsp");
         //disp.forward(request, response);
         target = "Member_Edit";
      }
      */
      return target;
   }
}