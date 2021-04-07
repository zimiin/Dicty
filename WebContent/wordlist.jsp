<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.ArrayList" %>
<%@ page import="wordList.WordListDTO" %>
<%@ page import="wordList.WordListDAO" %>

<!DOCTYPE html>
<html>
<head>
	<title>Dicty</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
	
	<div class="searchcon">
		<h1 class="smalltitle"><a href="./index.jsp">Dicty</a></h1>
		<div class="searchboxwht">
			<form action="./search.jsp" method="get">
				<input type="text" name="q" id="q" class="searchbarwht">
				<button type="submit" class="searchbtnwht">GO</button>
			</form>
		</div>
	</div>
	
	<%
	ArrayList<WordListDTO> wordList = new WordListDAO().getList();
	
	if (wordList != null) {
	%>
	
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
			<% 
			for (WordListDTO word : wordList) {
			%>
				<div class="card">
					<div class="card-body">
						<h2 class="card-title"><%=word.getWord() %></h2>
						<p class="card-text"><%=word.getDef() %></p>
					</div>
				</div>
			<%
			}
			%>
			</div>
		</div>
	</div>
	
	<%
	}
	%>

	<script> 
	    window.onload = function() { 
	        document.getElementById("q").focus(); 
	    }
    </script> 
    
	<script src="./js/jquery.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	<script src="./js/popper.min.js"></script>
</body>
</html>