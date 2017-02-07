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
	
	<%@ page import= "ejb.entites.* "%>
	<%@ page import= "java.util.List"%>
	
	<%! int statut;
		List<Intervention> interv;
	%>
	<%
	 if(session.getAttribute("statut")!=null)
	 {
	 session = request.getSession();
	 statut=(Integer)session.getAttribute("statut");	 
	 if(statut==0 || statut==1 || statut==2)
	 {
		 if(statut==0){
	%>
	<ul id="menu">
	<li><a href="accueiladministrateur.jsp">Accueil</a>
	</li>
	<li><a href="#">Gestion des Clients</a>
		<ul>
			<li><a href="affichertoutesentreprises.jsp">Afficher tous les clients</a></li>
			<li><a href="ajoutentreprise.jsp">Ajout d'un client</a></li>
		</ul>
	</li>
	<li><a href="#">Gestion des Techniciens</a>
		<ul>
			<li><a href="affichertouslestechniciens.jsp">Afficher tous les techniciens</a></li>
			<li><a href="ajouttechnicien.jsp">Ajout d'un technicien</a></li>
		</ul>
	</li>
	<li><a href="#">Mon compte</a>
		<ul>
			<li><a href="gestioncompte.jsp">Gestion du compte</a></li>
		</ul>
		</li>
	<li><a href="deconnexion.jsp">Déconnexion</a>
	</li>
	</ul>
	<% }
		 if(statut==1){
	%>
		<ul id="menu">
		<li><a href="accueiltechnicien.jsp">Accueil</a>
		</li>
		<li><a href="#">Gestion des Clients - Interventions </a>
		<ul>
			<li><a href="affichertoutesentreprises.jsp">Afficher tous les clients</a></li>
		</ul>
		</li>
		<li><a href="#">Mon compte</a>
			<ul>
			<li><a href="gestioncompte.jsp">Gestion du compte</a></li>
			</ul>
		</li>
		<li><a href="deconnexion.jsp">Déconnexion</a>
		</li>
		</ul>
		<% 		interv=(List<Intervention>)session.getAttribute("interv");
		if(interv!=null) interv.clear();
		}
			if(statut==2){
		%>
	<ul id="menu">
	<li><a href="accueilclient.jsp">Accueil</a>
	</li>
	<li><a href="#">Gestion des Batiments</a>
	<ul>
		<li><a href="ficheentreprise.jsp">Afficher tous les batiments</a></li>
	</ul>
	</li>
	<li><a href="#">Mon compte</a>
		<ul>
			<li><a href="gestioncompte.jsp">Gestion du compte</a></li>
		</ul>
		</li>
	<li><a href="deconnexion.jsp">Déconnexion</a>
	</li>
	</ul>
	<%
	}%>
	</header>
	  <div id="container">
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
	String numeroB;
	%>
	<%
		 session = request.getSession();
		 numBatiment = request.getParameter("numBatiment");
		 if(numBatiment==null){
			 numeroB = (String)session.getAttribute("numBatiment");
			 num=Integer.parseInt(numeroB);
		 }
		 else{
			 num = Integer.parseInt(numBatiment);
		 }
		session.setAttribute("numBatiment",String.valueOf(num));
		InitialContext ctx = new InitialContext();
		Object obj = ctx.lookup(
				"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
		out.println("<center>");
		out.println("<h3>Fiche du batiment <h3> <br> <br> ");
		B = service.rechercheBatimentnum(num);
		out.println("<table border=\"1\" cellpadding=\"10\" cellspacing=\"1\" >");
		out.print("<thead><tr><th> Nom du batiment </th><th> Adresse du batiment </th><th> Entreprise </th></tr>");
		out.print("</thead><tbody>");
		out.print("<tr><td>" + B.getNom() + "</td><td>  " + B.getAdresse()
			+ "</td><td>" + B.getEntreprise().getNom()+"</td></tr></tbody></table>");
		if(statut==1){
			out.println(
					"<br><br><table><tr><td><form action=\"choixintervention\" method=\"GET\" ><input type=\"hidden\" id=\"idintervention\" name=\"numBatiment\" value="
							+ B.getNumero()
							+ "> <input type=\"submit\" name=\" Effectuer une intervention \" value=\" Effectuer une intervention \" /></form></td><td>&nbsp;&nbsp;</td>");	
		}
		out.println(
				"<td><form action=\"listeorganes\" method=\"GET\" ><input type=\"hidden\" id=\"idlisteorganes\" name=\"numBatiment\" value="
						+ B.getNumero()
						+ "> <input type=\"submit\" name=\" Consulter la liste des organes de securite \" value=\" Consulter la liste des organes de securite \" /></form></td>");
		out.println("</tr></table>");
		
		out.println("<br><form action=\"ficheentreprise\" method=\"GET\" ><input type=\"submit\" name=\" Retour a la fiche du client \" value=\" Retour a la fiche du client \" /></form></center>");
		out.println("</center>");
	%>
	</div>
	<%
	 }
	 }
	 else
	 	out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
	%>
</body>
</html>