package com.ssafy.happyhouse.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.ssafy.happyhouse.model.dto.HouseBuyDto;
import com.ssafy.happyhouse.model.dto.HouseDealDto;
import com.ssafy.happyhouse.model.dto.HouseInfoDto;
import com.ssafy.happyhouse.model.dto.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.service.HouseBuyServiceImpl;
import com.ssafy.happyhouse.model.service.HouseMapService;
import com.ssafy.happyhouse.model.service.HouseMapServiceImpl;

@Controller
public class HouseMapController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Autowired
	private HouseMapService houseMapService;
	
	@GetMapping("/map")
	public void mapping(Model model, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		String act = request.getParameter("act");
		if("sido".equals(act)) {
			PrintWriter out = response.getWriter();
			List<SidoGugunCodeDto> list = null;
			JSONArray arr = new JSONArray();
			try {
				list = HouseMapServiceImpl.getHouseMapService().getSido();
				for(SidoGugunCodeDto dto : list) {
					JSONObject obj = new JSONObject();
					obj.put("sido_code", dto.getSidoCode());
					obj.put("sido_name", dto.getSidoName());
					arr.add(obj);
				}
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
		}//sido
		else if("gugun".equals(act)) {
			String sido = request.getParameter("sido");
			PrintWriter out = response.getWriter();
			List<SidoGugunCodeDto> list = null;
			JSONArray arr = new JSONArray();
			try {
				list = HouseMapServiceImpl.getHouseMapService().getGugunInSido(sido);
				for(SidoGugunCodeDto dto : list) {
					JSONObject obj = new JSONObject();
					obj.put("gugun_code", dto.getGugunCode());
					obj.put("gugun_name", dto.getGugunName());
					arr.add(obj);
					
				}
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
		}//gugun
		else if("dong".equals(act)) {
			String gugun = request.getParameter("gugun");
			PrintWriter out = response.getWriter();
			List<HouseInfoDto> list = null;
			JSONArray arr = new JSONArray();
			try {
				list = HouseMapServiceImpl.getHouseMapService().getDongInGugun(gugun);
				for(HouseInfoDto dto : list) {
					JSONObject obj = new JSONObject();
					obj.put("code", dto.getCode());
					obj.put("dong", dto.getDong());
					arr.add(obj);
				}
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
		}//dong
		else if("apt".equals(act)) {
			String dong = request.getParameter("dong");
			PrintWriter out = response.getWriter();
			List<HouseInfoDto> list = null;
			JSONArray arr = new JSONArray();
			try {
				list = HouseMapServiceImpl.getHouseMapService().getAptInDong(dong);
				for(HouseInfoDto dto : list) {
					JSONObject obj = new JSONObject();
					obj.put("no", dto.getNo());
					obj.put("dong", dto.getDong());
					obj.put("aptName", dto.getAptName());
					obj.put("code", dto.getCode());
					obj.put("jibun", dto.getJibun());
					arr.add(obj);
				}
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
		}//apt
		else if("apt2".equals(act)) {
			String apt = request.getParameter("apt");
			String jibun = request.getParameter("jibun");
			PrintWriter out = response.getWriter();
			List<HouseDealDto> list = null;
			JSONArray arr = new JSONArray();
			try {
				list = HouseMapServiceImpl.getHouseMapService().getApt2InApt(apt,jibun);
				for(HouseDealDto dto : list) {
					JSONObject obj = new JSONObject();
					obj.put("dong", dto.getDong());
					obj.put("aptName", dto.getAptName());
					obj.put("dealAmount", dto.getDealAmount());
					obj.put("area", dto.getArea());
					obj.put("jibun", dto.getJibun());
					arr.add(obj);
				}
			} catch (Exception e) {
				arr = new JSONArray();
				JSONObject obj = new JSONObject();
				obj.put("message_code", "-1");
				arr.add(obj);
				e.printStackTrace();
			} finally {
				out.print(arr.toJSONString());
				out.close();
		}//apt2
		}else if("house".equals(act)) {
			String dong = request.getParameter("dong");
			PrintWriter out = response.getWriter();
			List<HouseBuyDto> list = null;
			JSONArray arr = new JSONArray();
			try {
				list = HouseBuyServiceImpl.getHouseBuyService().getHouseBuyInfo(dong);
				for(HouseBuyDto dto : list) {
					JSONObject obj = new JSONObject();
					obj.put("dong", dto.getDong());
					obj.put("buildingName", dto.getBuildingName());
					obj.put("buildYear", dto.getBuildYear());
					obj.put("dealAmount", dto.getDealamount());
					obj.put("area", dto.getArea());
					obj.put("floor", dto.getFloor());
					obj.put("roadname",dto.getRoadname());
					arr.add(obj);
				}
			} catch (Exception e) {
				arr = new JSONArray();
				JSONObject obj = new JSONObject();
				obj.put("message_code", "-1");
				arr.add(obj);
				e.printStackTrace();
			} finally {
				out.print(arr.toJSONString());
				out.close();
		}//house
		}
	}
}