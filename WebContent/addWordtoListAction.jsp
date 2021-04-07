<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter" %>
<%@ page import="wordList.WordListDAO" %>
<%@ page import="wordList.WordListDTO" %>

<%
request.setCharacterEncoding("UTF-8");

String word = null;
String def = null;

if (request.getParameter("word") != null) {
	word = request.getParameter("word");
}
if (request.getParameter("def") != null) {
	def = request.getParameter("def");
}

if (word == null || def == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('단어장에 추가할 내용이 없습니다.');");
	script.println("history.back();");
	script.println("</script>");
	script.close();
	return;
}

WordListDAO wordListDAO = new WordListDAO();
int result = wordListDAO.insert(new WordListDTO(word, def));

if (result == -1) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('단어장에 추가하지 못했습니다.');");
	script.println("history.back();");
	script.println("</script>");
	script.close();
}
else {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('성공적으로 단어장에 추가되었습니다.');");
	script.println("history.back();");
	script.println("</script>");
	script.close();
}
%>