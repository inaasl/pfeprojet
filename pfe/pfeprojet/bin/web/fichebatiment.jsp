<html>

<head>
<title>Fiche : entreprise</title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<header class="header">
		<a class="logo" href="http://www.desentec.fr/"><img
			src="http://www.desentec.fr/wp-content/uploads/2015/06/logo-site.png">
		</a>
		<p class="head">
		<center>
			<strong>Desentec - Protection incendie</strong>
		</center>
		</p>
	</header>
	<%@ page import="java.net.URL"%>
	<%@ page import="java.net.URLConnection"%>
	<%@ page import="java.io.* "%>
	<%@ page import="ejb.sessions.*"%>
	<%@ page import="ejb.entites.* "%>
	<%@ page import="java.util.Collection"%>
	<%@ page import="java.util.Set"%>
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.naming.NamingException"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>
	<%@ page import="java.text.DateFormat"%>
	<%@ page import="java.util.HashSet"%>



	<%!String numBatiment;
	Batiment B;
	int num, i;
	String numeroB;%>


	<%
		session = request.getSession();
		numeroB = (String) session.getAttribute("numeroB");
		
		if(numeroB==null){
			numBatiment = request.getParameter("numBatiment");
			num = Integer.parseInt(numBatiment);
		}
		else 
			num=Integer.parseInt(numeroB);
		
		session.setAttribute("numeroB",String.valueOf(num));
		InitialContext ctx = new InitialContext();
		Object obj = ctx.lookup(
				"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
		
		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;

		
		out.println("<center>");
		out.println("Fiche du batiment : <br> <br> ");
		B = service.rechercheBatimentnum(num);
		out.println("Nom du batiment : " + B.getNom() + "<br><br> Adresse du batiment : " + B.getAdresse()
				+ "<br><br> Entreprise : " + B.getEntreprise().getNom());
		out.println(
				"<br><br><table><tr><td><form action=\"choixintervention\" method=\"GET\" ><input type=\"hidden\" id=\"idintervention\" name=\"numBatiment\" value="
						+ B.getNumero()
						+ "> <input type=\"submit\" name=\" Effectuer une intervention \" value=\" Effectuer une intervention \" /></form></td><tr>");
		out.println(
				"<tr><td><form action=\"listeorganes\" method=\"GET\" ><input type=\"hidden\" id=\"idlisteorganes\" name=\"numBatiment\" value="
						+ B.getNumero()
						+ "> <input type=\"submit\" name=\" Consulter la liste des organes de securite \" value=\" Consulter la liste des organes de securite \" /></form></td></tr>");
		out.println("</table>");
		out.println("</center>");
		out.println("<a href=\"ficheentreprise.jsp\">retour à la fiche du client</a></center>");

	%>
</body>
</html>