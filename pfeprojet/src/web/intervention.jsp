<html>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.io.* "%>
<%@ page import="ejb.sessions.*"%>
<%@ page import="ejb.entites.* "%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.NamingException"%>
	<%@ page import= "java.util.List"%>
<head>
<title></title>
<link href="style.css" rel="stylesheet" type="text/css">
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
	 if(statut==1)
	 {
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
	</header>
	
<%!String typeinterv, typeorg, numeroB;
List<Intervention> interv;
%>
<%
	interv=(List<Intervention>)session.getAttribute("interv");
	if(interv!=null) interv.clear();
	typeinterv = request.getParameter("choixinterv");

	typeorg = request.getParameter("choixorg");

	if (typeinterv.compareTo("installation") == 0 && typeorg.compareTo("extincteur") == 0) {
		out.println("<meta http-equiv=\"refresh\" content=\"1; URL=installationextincteur.jsp\">");
	}
	if (typeinterv.compareTo("verification") == 0 && typeorg.compareTo("extincteur") == 0) {
		out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationextincteur.jsp\">");
	}
	if (typeinterv.compareTo("maintenancecorr") == 0 && typeorg.compareTo("extincteur") == 0) {
		out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrextincteur.jsp\">");
	}
	if (typeinterv.compareTo("maintenanceprev") == 0 && typeorg.compareTo("extincteur") == 0) {
		out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenanceprevextincteur.jsp\">");
	}
	
%>
	<%
	 }
	 }
	 else
	 	out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
	%>
</body>
</html>