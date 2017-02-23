<!DOCTYPE HTML>
<html>
<head>
<title>Ajout d'une entreprise</title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" media="screen and (max-width: 2560px)">
</head>

<body>
   
	<header class="header">
		<a class="logo" href="http://www.desentec.fr/"><img
			src="http://www.desentec.fr/wp-content/uploads/2015/06/logo-site.png">
		</a>
		
		<%! int statut;
	%>
	<%
	 if(session.getAttribute("statut")!=null)
	 {
	 	session = request.getSession();
	 	statut=(Integer)session.getAttribute("statut");	 
	 	if(statut==0)
	 	{
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
	</header>
	<br><br><br><br><br>
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
	<%@ page import="java.util.List"%>
		<%!
		  String numEntreprise;
	      String nomBat;
	      String adresse;
	      String nomResp;
	      String prenomResp;
	      String telresponsable;
	      int numE;
	    %>
		<%
		   numEntreprise = request.getParameter("numEntreprise");
		   nomBat= request.getParameter("nomBatiment");
		   adresse= request.getParameter("adresse");
		   nomResp= request.getParameter("nomresponsable");
		   prenomResp= request.getParameter("prenomresponsable");
		   numE= Integer.parseInt(numEntreprise);
		   telresponsable=request.getParameter("telresponsable");
		   
		   InitialContext ctx = new InitialContext();
			Object obj = ctx.lookup(
					"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");

			ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
			
		   service.ajouterBatiment(numE, nomBat, adresse, nomResp, prenomResp,telresponsable);
		   out.println("<center><h3>Ajout effectué avec succès<h3><br>");
		   out.println("<meta http-equiv=\"refresh\" content=\"2; URL=affichertoutesentreprises.jsp\">");
		   
		%>	
		
	<%
	 	}
	 }
	 else
	 	out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
	%>
</body>
</html>