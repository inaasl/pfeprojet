<html>
<head>
<title> Installation d'un Extincteur</title>
    <meta charset="UTF-8" />
    <link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<header class="header">
    	        <a class="logo" href="http://www.desentec.fr/"><img src="http://www.desentec.fr/wp-content/uploads/2015/06/logo-site.png"> </a>
    	       <p class="head"><center><strong>Desentec - Protection incendie</strong></center></p>
</header>
		<%@ page import="java.net.URL" %>
        <%@ page import="java.net.URLConnection" %>
        <%@ page import="java.io.* " %>
		<%@ page import= "ejb.sessions.*"%>
		<%@ page import= "ejb.entites.* "%>
		<%@ page import= "java.util.Collection"%>
		<%@ page import= "java.util.Set"%>
		<%@ page import= "javax.naming.InitialContext"%>
		<%@ page import= "javax.naming.NamingException"%>
		<%@ page import= "java.sql.Date"%>
		<%@ page import= "java.text.SimpleDateFormat"%>
		<%@ page import= "java.text.DateFormat"%>
		<%@ page import= "java.util.HashSet"%>
		<%@ page import= "java.util.List"%>
		<%@ page import= "java.util.ArrayList"%>
		
		
<%! String numBat, annee,observ,numtech,conclu,empla, type,marque;
	int numB,numT,anneeInt;
	List<Installation> interv;
%>
<%
	annee =request.getParameter("annee");
	observ =request.getParameter("observations");
	numtech =request.getParameter("technicien");
	conclu =request.getParameter("conclusion");
	empla=request.getParameter("emplacement");
	type=request.getParameter("typeextincteur");
	marque=request.getParameter("marqueextincteur");
	
	
	numBat=String.valueOf(session.getAttribute("num"));
	numB=Integer.parseInt(numBat);
	numT=Integer.parseInt(numtech);
	anneeInt=Integer.parseInt(annee);
	
	InitialContext ctx = new InitialContext();
	Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	String format = "yyyy-MM-dd";
	java.text.SimpleDateFormat formater = new java.text.SimpleDateFormat(format);
	java.util.Date date = new java.util.Date();
	service.InstallationExtincteur(anneeInt, empla, observ,Date.valueOf(formater.format(date)),numT,numB,type,marque);
	
	interv = (List<Installation>) session.getAttribute("interv");
	if (interv == null) {
		interv = new ArrayList<Installation>();
	} 
	interv.add(service.getlisteInstallation().get(service.getlisteInstallation().size() - 1));
	session.setAttribute("interv", interv);
	
	out.println("<br><center> Installation effectuée avec succès </center>");

	out.println("<center><a href=\"installationextincteur.jsp\">Ajout d'un nouvel extincteur</a></center>");

	out.println(
			"<center><form action=\"interventionvalidee.jsp\"> <p> Conclusion : <input type=\"text\" name=\"conclusion\" /></p> <input type=\"submit\" value=\"Valider\"> </center>");
%>