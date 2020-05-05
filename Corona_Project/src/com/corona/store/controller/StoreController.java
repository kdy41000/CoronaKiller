package com.corona.store.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.corona.store.dto.StoreDto;


@WebServlet("/store.do")
public class StoreController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public StoreController() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("text/html;charset=UTF-8");
         request.setCharacterEncoding("UTF-8");
		
		String command = request.getParameter("command");
		
		if(command.equals("store")) {
		
			response.sendRedirect("store/storepage.jsp");
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("text/html;charset=UTF-8");
         request.setCharacterEncoding("UTF-8");
		
		String command = request.getParameter("command");
		
		if(command.equals("ajaxList")) {
			System.out.println("들어왓ㄷ사");
	       	 JSONObject txt = readJsonFromUrl("https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json");
	       	
	       	 List<StoreDto>list = new ArrayList<StoreDto>();
	       	 System.out.println(txt.getJSONArray("stores").length()+"::랭스");
	       	 
	       	 for(int i = 0; i < txt.getJSONArray("stores").length(); i++) {
	       		 JSONObject jobj= (JSONObject) txt.getJSONArray("stores").get(i);
	       	 System.out.println(jobj+"::이건머냐");
	       	 System.out.println(jobj.get("code")+"::쉬바"+i);
	       			/*JsonElement code = (JsonElement) jobj.get("code");  //JsonObject담긴  key를 지정하여 다시 JsonElement에 대입 
	   				JsonElement lng = (JsonElement) jobj.get("lng");
	   				JsonElement stock_at = (JsonElement) jobj.get("stock_at");
	   				JsonElement name = (JsonElement) jobj.get("name");
	   				JsonElement created_at = (JsonElement) jobj.get("created_at");
	   				JsonElement addr = (JsonElement) jobj.get("addr");
	   				JsonElement type = (JsonElement) jobj.get("type");
	   				JsonElement remain_stat = (JsonElement) jobj.get("remain_stat");
	   				JsonElement lat = (JsonElement) jobj.get("lat");
	   				*/
	   				String codeRes = (jobj.isNull("code"))? "0" : (String)jobj.get("code");  //JsonElement에 담긴 key를 String형으로 변환하여 대입
	   				double lngRes = (jobj.isNull("lng"))? 0 : (double)jobj.get("lng");
	   				String stock_atRes = (jobj.isNull("stock_at"))?"0" : (String)jobj.get("stock_at");
	   				String nameRes = (jobj.isNull("name"))? "0" : (String)jobj.get("name");
	   				String created_atRes = (jobj.isNull("created_at"))? "0" : (String)jobj.get("created_at");
	   				String addrRes = (jobj.isNull("addr"))? "0" : (String)jobj.get("addr");
	   				String typeRes = (jobj.isNull("type"))? "0" : (String)jobj.get("type");
	   				String remain_statRes = (jobj.isNull("remain_stat"))? "0" : (String)jobj.get("remain_stat");
	   				double latRes = (jobj.isNull("lat"))? 0 : (double)jobj.get("lat");
	   				
	   				StoreDto dto = new StoreDto();
	   				dto.setAddrRes(addrRes);
	   				dto.setCodeRes(codeRes);
	   				dto.setCreated_atRes(created_atRes);
	   				dto.setLatRes(latRes);
	   				dto.setLngRes(lngRes);
	   				dto.setNameRes(nameRes);
	   				dto.setRemain_statRes(remain_statRes);
	   				dto.setStock_atRes(stock_atRes);
	   				dto.setTypeRes(typeRes);
	   				
	   				list.add(dto);
	   				
	       	 }
	       	 
	       	 int count = (int)txt.get("count");
	       	 System.out.println(count+"::카운트");
	       	 //int res = biz.insertData(list,count);
	       	HttpSession session = request.getSession();
	       	session.setAttribute("list", list);
	       	session.setAttribute("count", count);
	       	response.sendRedirect("store/maskinfo.jsp");
		}
		doGet(request, response);
	}
	
	 public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
		    InputStream is = new URL(url).openStream();
		    try {
		      BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
		      String jsonText = readAll(rd);
		      JSONObject json = new JSONObject(jsonText);
		      return json;
		    } finally {
		      is.close();
		    }
		  }
	 
	 private static String readAll(Reader rd) throws IOException {
		    StringBuilder sb = new StringBuilder();
		    int cp;
		    while ((cp = rd.read()) != -1) {
		      sb.append((char) cp);
		    }
		    return sb.toString();
		  }

}
