<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="word.Etymology" %>
<%@ page import="word.Longman" %>
<%@ page import="word.LongmanSense" %>
<%@ page import="word.WordRef" %>

<%
	request.setCharacterEncoding("UTF-8");
	String q = null;
	String placeholder = "검색할 단어를 입력하세요";
	
	// Document variables
	Document longmanDoc = null;
	Document etymologyDoc = null;
	Document wordRefDoc = null;
	
	// address variables
	String longmanaddr = null;
	String wordrefaddr = null;
	
	if (request.getParameter("q") != null && request.getParameter("q") != "") {
		q = request.getParameter("q");
		placeholder = q;
		
		// Online Etymology
		String address = "https://www.etymonline.com/search?q=" + q;
		etymologyDoc = Jsoup.connect(address).get();

		// Longman Dictionary
		longmanaddr = "https://www.ldoceonline.com/dictionary/" + q;
		longmanDoc = Jsoup.connect(longmanaddr).get();
		
		// WordReference English-Korean
		wordrefaddr = "https://www.wordreference.com/enko/" + q;
		wordRefDoc = Jsoup.connect(wordrefaddr).get();
	}
	
	ArrayList<Etymology> etymList = new ArrayList<Etymology>();
	
	// Extract word and definition from the html of etymology dictionary
	if (etymologyDoc != null) {
		
		Elements bundle = etymologyDoc.body().getElementsByClass("word--C9UPa word_4pc--2SZw8");
		
		for (Element e : bundle) {
			
			Etymology etym = new Etymology();
			
			etym.setWord(e.select("a.word__name--TTbAA").text());
			etym.setDef(e.select("section.word__defination--2q7ZH").first().html());
			etym.setMoreInfo(e.select("a.word_4pc__footer--2yfj3").attr("href"));
			etymList.add(etym);
		}		
	}
	
	ArrayList<Longman> longmanList = new ArrayList<Longman>();
	
	// Extract word, sense and definition from the html of Longman dictionary
	if (longmanDoc != null) {
		
		Elements bundle = longmanDoc.body().getElementsByClass("dictentry");
		
		for (Element e : bundle) {
			
			Longman longman = new Longman();
			longman.setWord(e.select("span.HWD").first().text());
			
			if (e.getElementsByClass("Sense").size() > 0) {
				
				longman.setId(e.getElementsByClass("Sense").first().attr("id"));
				
				for (Element s : e.getElementsByClass("Sense")) {

					LongmanSense sense = new LongmanSense();
					
					if (s.select("span.SIGNPOST").first() != null || s.select("span.DEF").first() != null) {
						
						if(s.select("span.SIGNPOST").first() != null) {
							sense.setSignPost(s.select("span.SIGNPOST").first().text());
						}
						
						for (Element d : s.getElementsByClass("DEF")) {
							sense.addDef(d.text());
						}
						
						longman.addSense(sense);
					}
				}
			}
			
			longmanList.add(longman);
		}
	}
	
	ArrayList<WordRef> wordRefList = new ArrayList<WordRef>();
	
	// Extract word and definition from the html of Word Reference
	if (wordRefDoc != null) {

		if (wordRefDoc.body().select("table.WRD").size() > 0) {
			
			Element table = wordRefDoc.body().select("table.WRD").first();
			
			for (Element tr : table.select("tr")) {
				
				if(tr.select("td.FrWrd").first() != null) {
					
					if (tr.select("td.FrWrd").first().select("strong") != null && tr.select("td.FrWrd").first().select("strong").hasText()) {
						
						String word = tr.select("td.FrWrd").first().select("strong").text().replace("⇒", "");
						String id = tr.attr("id");
						String def = null;
						
						if (tr.select("td.ToWrd").first().childrenSize() > 0) {
							def = tr.select("td.ToWrd").first().childNodes().get(0).toString();
						}
						
						wordRefList.add(new WordRef(word, def, id));
						
					}
				}
			}
		}
	}		
%>

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
				<input type="text" name="q" id="q" placeholder="<%= placeholder %>" class="searchbarwht">
				<button type="submit" class="searchbtnwht">GO</button>
			</form>
		</div>
	</div>
	
	<nav class="navbar justify-content-end">
		<a href="./wordlist.jsp" class="btn btn-info" role="button">단어장으로 가기</a>
	</nav>
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-4">
			<% 
			for (Etymology etym : etymList) {
			%>
				<div class="card">
					<div class="card-body">
						<h2 class="card-title"><a href="https://www.etymonline.com<%=etym.getMoreInfo() %>" class="etymology"><%=etym.getWord() %></a></h2>
						<p class="card-text"><%=etym.getDef() %></p>
					</div>
				</div>
			<%
			}
			%>
			</div>
			<div class="col-sm-4">
				<%
				for (Longman longman : longmanList) {
				%>
					<div class="card">
						<div class="card-body">
							<h2 class="card-title"><a href="<%=longmanaddr %>#<%=longman.getId() %>" class="longman"><%=longman.getWord() %></a></h2>
							<p class="card-text">
								<ol>
								<% for (LongmanSense ls : longman.getSense()) { %>
									<li>
									
									<% if (ls.getSignPost() != null) { %>
										<span class="signpost"><%=ls.getSignPost() %></span><br>
										
										<% if (ls.getDef().size() <= 1) { %>
							 				<%=ls.getDef().get(0)  %>
							 				
					 					<% } else { %> 
											<ol>
											
											<% for (String def : ls.getDef()) { %>
												<li type="a"><%=def %></li>
											<% } %>
											
											</ol>
										<% } 
										} else { %>
											<%=ls.getDef().get(0) %>
									<% } %>
									</li>
								<% } %>
								</ol>
							</p>
						</div>
					</div>
				<%
				}
				%>
			</div>
			<div class="col-sm-4">
			<% 
			for (WordRef wordRef : wordRefList) {
			%>
				<div class="card">
					<div class="card-body">
						<h2 class="card-title"><a href="<%=wordrefaddr %>#<%=wordRef.getId() %>" class="wordref"><%=wordRef.getWord() %></a></h2>
						<p class="card-text">
						<%=wordRef.getDef() %>
						</p>
					</div>
					<div class="card-footer text-right">
						<form action="./addWordtoListAction.jsp" method="post">
							<input type="hidden" name="word" value="<%=wordRef.getWord() %>">
							<input type="hidden" name="def" value="<%=wordRef.getDef() %>">
							<button type="submit" class="btn btn-outline-success">단어장에 추가</button>
						</form>
					</div>
				</div>
			<%
			}
			%>
			</div>
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