<!DOCTYPE HTML>
<html>
<head>
<title>Accès Technicien</title>
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
	
	<%! Integer statut;
		List<Intervention> interv;
		List<Organe> organes;
		String ajout;
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
	<%
		organes=(List<Organe>)session.getAttribute("organes");
		if(organes!=null) organes.clear();
		ajout=String.valueOf(session.getAttribute("ajout"));
		if(ajout!=null) ajout=null;
		
		interv=(List<Intervention>)session.getAttribute("interv");
		if(interv!=null) interv.clear();
		Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
		pdf=null;
	 	}
	}
 	else
 		out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
	%>
</body>
</html>