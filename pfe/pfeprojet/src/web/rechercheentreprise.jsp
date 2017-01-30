<html>

<head>
<title>Résultat de la recherche</title>
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
	Entreprise Ent;
	int i;%>


	<%
		out.println("Résultat de la recherche : ");

		nomEntreprise = request.getParameter("nomEntreprise");

		InitialContext ctx = new InitialContext();
		Object obj = ctx.lookup(
				"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
		out.print(
				"<br> <table border=\"1\" cellpadding=\"10\" cellspacing=\"1\" width=\"100%\"> <tr><th width=\"20%\" align=\"center\"> Nom de l'entreprise </th><th width=\"40%\" align=\"center\"> Adresse de l'entreprise </th><th width=\"20%\" align=\"center\"> Numero de telephone de l'entreprise </th><thth width=\"20%\" align=\"center\">  </th></tr>");
		for (i = 0; i < service.rechercheEntreprise(nomEntreprise).size(); i++) {
			out.print(" <tr><td align=\"center\"> "
					+ service.rechercheEntreprise(nomEntreprise).get(i).getNom().toString()
					+ "</td><td <td align=\"center\">"
					+ service.rechercheEntreprise(nomEntreprise).get(i).getAdresse().toString()
					+ "</td><td align=\"center\">"
					+ service.rechercheEntreprise(nomEntreprise).get(i).getTel().toString()
					+ "</td><td align=\"center\"> <form action=\"ficheentreprise\" method=\"GET\" ><input type=\"hidden\" id=\"thisField\" name=\"numEntreprise\" value="
					+ service.rechercheEntreprise(nomEntreprise).get(i).getNumero()
					+ "> <input type=\"submit\" name=\" Consulter la fiche \" value=\" Consulter la fiche \" /></form></td></tr>");
		}
		out.print("</table>");
	%>

</body>
</html>






