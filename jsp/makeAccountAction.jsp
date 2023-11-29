<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.PrintWriter" %>

<%
    request.setCharacterEncoding("UTF-8");
    String username = request.getParameter("name");
    String idValue = request.getParameter("id");
    String pwValue = request.getParameter("pw");
    String tel = request.getParameter("tel");
    String team = request.getParameter("team");
    String company = request.getParameter("company");

    int accountSet = 0;
    PrintWriter out = response.getWriter();

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week6", "Sohyunxxi", "1234");

        // 중복 체크 로직
        String duplicateCheckSql = "SELECT COUNT(*) AS count FROM user WHERE id = ?";
        PreparedStatement query = connect.prepareStatement(duplicateCheckSql);
        query.setString(1, idValue);
        ResultSet rs = query.executeQuery();
        rs.next();
        int count = rs.getInt("count");

        if (count > 0) {
            out.println("<script>alert('해당 아이디는 이미 사용 중입니다.');</script>");
        } else {
            // 회원가입 로직
            String insertSql = "INSERT INTO user (id, pw, name, tel, team, company) VALUES (?, ?, ?, ?, ?, ?)";
            query = connect.prepareStatement(insertSql);
            query.setString(1, idValue);
            query.setString(2, pwValue);
            query.setString(3, username);
            if (tel != null && !tel.isEmpty()) {
                query.setString(4, tel);
            } else {
                query.setNull(4, java.sql.Types.INTEGER);
            }
            query.setString(5, team);
            query.setString(6, company);

            accountSet = query.executeUpdate();

            if (accountSet > 0) {
                out.println("<script>alert('회원가입에 성공하였습니다. 로그인을 해 주세요.'); location.href='login.jsp';</script>");
            }
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
%>
