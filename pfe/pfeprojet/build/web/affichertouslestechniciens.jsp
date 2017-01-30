
<html>

<head>
<title>Liste de tous les techniciens</title>
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
	<%@ page import="java.util.List"%>


	<%!String nomEntreprise;
	List<Entreprise> E;
	int i;%>


	<%
		out.println("Liste de tous les techniciens : <br> ");

		session = request.getSession();
		InitialContext ctx = new InitialContext();
		Object obj = ctx.lookup(
				"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;

		for (i = 0; i < service.getlisteEntreprises().size(); i++) {
			out.println("<a href=\"fichetechnicien.jsp\">"
					+ service.getlisteTechniciens().get(i).getNom().toString() + "</a><br>");
			session.setAttribute("techniciennom", service.getlisteTechniciens().get(i).getNom().toString());
			session.setAttribute("technicientel", service.getlisteTechniciens().get(i).getTel().toString());
			session.setAttribute("technicienadresse", service.getlisteTechniciens().get(i).getAdresse().toString());

		}
	%>