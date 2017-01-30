<html>
<head>
<title>Verification d'un Extincteur</title>
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
	<%@ page import="java.util.List"%>
	<%@ page import="java.util.ArrayList"%>
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.naming.NamingException"%>
	<%@ page import="java.sql.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>
	<%@ page import="java.text.DateFormat"%>

	<%!String numBat, conclusion, observation;
	int num, i;%>

	<%
		session = request.getSession();
		InitialContext ctx = new InitialContext();
		Object obj = ctx.lookup(
				"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;

		numBat = String.valueOf(session.getAttribute("num"));
		session.setAttribute("num", numBat);
		num = Integer.parseInt(numBat);
		conclusion = request.getParameter("Conclusion");

		String format = "yyyy-MM-dd";
		java.text.SimpleDateFormat formater = new java.text.SimpleDateFormat(format);
		java.util.Date date = new java.util.Date();

		for (i=0;i < service.rechercheBatimentnum(num).getOrganes().size(); i++) {
			if(service.rechercheBatimentnum(num).getOrganes().get(i) instanceof Extincteur) { 
				observation = request.getParameter(String.valueOf(i));
				service.Verification(service.rechercheBatimentnum(num).getOrganes().get(i).getNumero(), observation, conclusion, 1,
					Date.valueOf(formater.format(date)));
			}
		}
		out.println("<center><br>Intervention effectuée avec succès");
		out.println("<a href=\"fichebatiment.jsp\">retour à la fiche du bâtiment</a></center>");
	%>
</body>
</html>

