<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<div class="indexbox">
		<h1 class="title"><a href="./index.jsp"></a>Dicty</h1>
		<div class="searchbox">
			<form action="./search.jsp" method="get">
				<input type="text" name="q" id="q" placeholder="검색할 단어를 입력하세요." class="searchbar">
				<button type="submit" class="searchbtn">GO</button>
			</form>
		</div>
	</div>

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