<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8");
    String name = (String)session.getAttribute("userName");
    String id = (String)session.getAttribute("userId");
    String pw = (String)session.getAttribute("userPw");
    String role = (String)session.getAttribute("role");
    String team =(String)session.getAttribute("team");
    String tel = (String)session.getAttribute("tel");
    int idx = (Integer)session.getAttribute("idx");

    if (name==null){
        response.sendRedirect("login.jsp");
    }
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week10","Sohyunxxi","1234");

    String sql = "SELECT user_idx, id, name FROM user WHERE department= ? AND role = '팀원'";

    
    PreparedStatement query = connect.prepareStatement(sql);

    query.setString(1,team);

    ResultSet rs= null;
    rs=query.executeQuery();
    ResultSet result = query.executeQuery();

    ArrayList<String> nameList= new ArrayList<String>();
    ArrayList<String> idList= new ArrayList<String>();
        
    while(result.next()){ // next가 가능할 때까지 반복문을 돌린다.
        String t_id=result.getString(2);// 첫번째 컬럼
        String t_name=result.getString(3);// 두번째 컬럼
        nameList.add("\""+t_name +"\"");
        idList.add("\""+t_id+"\"");
    }           
%>