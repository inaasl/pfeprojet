<html>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.io.* "%>
<%@ page import="ejb.sessions.*"%>
<%@ page import="ejb.entites.* "%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page import="java.util.List"%>

<head>
<title></title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<header class="header">
		<a class="logo" href="http://www.desentec.fr/"><img
			src="http://www.desentec.fr/wp-content/uploads/2015/06/logo-site.png">
		</a>
		<p class="head">
		<center></center>
		</p>
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
		<li><a href="#">Déconnexion</a>
		</li>
		</ul>
	</header>

	<%!List<Intervention> Interv;
	String conclu;
	%>
<%
	session = request.getSession();
	InitialContext ctx = new InitialContext();
	Object obj = ctx.lookup(
	"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	conclu = request.getParameter("conclusion");
	Interv = (List<Intervention>)session.getAttribute("interv");
	service.listeIntervention(Interv,conclu);
	out.println("<center><br>Intervention effectuée avec succès");
	out.println("<a href=\"fichebatiment.jsp\">retour à la fiche du bâtiment</a></center>");
%>
	<%
	 }
	 }
	 else
	 	out.println("</header><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\">");
	%>
</body>
</html>