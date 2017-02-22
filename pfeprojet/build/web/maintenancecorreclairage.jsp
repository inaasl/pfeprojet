<html>
<head>
<title>Maintenance Corrective : Eclairage</title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="datatables.css" />
    <script type="text/javascript" src="jquery.dataTables.js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.12/datatables.min.css"/>
 
    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.12/datatables.min.js"></script>

    <script type="text/javascript" charset="utf-8">
     $(document).ready(function(){
     $('#datatables').dataTable();
    
     })
    </script>
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
	  <div id="container">
	<%@ page import="java.net.URL"%>
	<%@ page import="java.net.URLConnection"%>
	<%@ page import="java.io.* "%>
	<%@ page import="ejb.sessions.*"%>
	<%@ page import="ejb.entites.* "%>
	<%@ page import="java.util.List"%>
	<%@ page import="java.util.ArrayList"%>
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.naming.NamingException"%>

	<%!String numBat,conclusion, observation;
	int num,i;
	List<Eclairage> E = new ArrayList<Eclairage>();
	%>
	<%
		session = request.getSession();
		List<Organe> organes=(List<Organe>)session.getAttribute("organes");
		if(organes!=null) organes.clear();
		session.setAttribute("organes",organes);
	
		String ajout=String.valueOf(session.getAttribute("ajout"));
		if(ajout!=null) ajout="0";
		session.setAttribute("ajout",ajout);
		
		Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
		pdf=null;
		session.setAttribute("pdf",pdf);
		
		InitialContext ctx = new InitialContext();
		Object obj = ctx.lookup(
				"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
		numBat = String.valueOf(session.getAttribute("numBatiment"));
		session.setAttribute("numBatiment", numBat);
 		num=Integer.parseInt(numBat);
		E.clear();
		E=service.rechercheEclairageBatiment(num);
		out.println("<br><center><h3>Maintenance Corrective des Porte Eclairages</h3></center><br>");
		out.println("<center><input type=\"button\" name=\"AjoutEclairage\" value=\"Ajouter un Eclairage \"  onclick=\"self.location.href='installationeclairage.jsp?ajout=8'\"></button></center>");
		out.println("<br><center><h4> Liste des Eclairages </h4></center>");
		// Tableau
		out.print("<br> <table id=\"datatables\" class=\"display\" >");
		out.print("<thead><tr><th> N° Eclairage </th><th> Emplacement </th><th> Type </th><th> Marque </th><th> Type télécommande </th><th></th></tr>");
		out.print("</thead><tbody>");
	      
		for(i=0;i<E.size();i++){
					out.println(" <tr><td > " + E.get(i).getNumero()+
						"</td> <td>" + E.get(i).getEmplacement()+
						"</td> <td >" + E.get(i).getType().getNom()+
						"</td> <td >" + E.get(i).getMarque().getNom()+
						"</td> <td >" + E.get(i).getTypetelecommande().getNom()+
						"</td><td> <form action=\"maintenancecorreclairagevalidee.jsp\" method=\"GET\" ><input type=\"hidden\" id=\"idcf\" name=\"numeclairage\" value="
						+ E.get(i).getNumero()
						+ "> <input type=\"submit\" name=\" Effectuer une maintenance corrective \" value=\" Effectuer une maintenance corrective \" /></form></td></tr>"
						);
		}
		out.println("</tbody></table><br><br>"); 
		session.setAttribute("Eclairage",E);
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