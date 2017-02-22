<html>
<head>
<title>Maintenance Corrective : Alarme Incendie</title>
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
	List<Alarme> A = new ArrayList<Alarme>();
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
		A.clear();
		A=service.rechercheAlarmeBatiment(num);
		out.println("<br><center><h3>Maintenance Corrective des Alarmes Incendie</h3></center><br>");
		out.println("<center><input type=\"button\" name=\"AjoutAlarme\" value=\"Ajouter une Alarme incendie\"  onclick=\"self.location.href='installationalarme.jsp?ajout=22'\"></button></center>");
		out.println("<br><center><h4> Liste des Alarmes Incendie </h4></center>");
		// Tableau
		out.print("<br> <table id=\"datatables\" class=\"display\" >");
		out.print("<thead><tr><th> N° Alarme </th><th> Emplacement </th><th> Type </th><th></th></tr>");
		out.print("</thead><tbody>");
	      
		for(i=0;i<A.size();i++){
					out.println(" <tr><td > " + A.get(i).getNumero()+
						"</td> <td>" + A.get(i).getEmplacement()+
						"</td> <td >" + A.get(i).getType().getNom()+
						"</td><td> <form action=\"maintenancecorralarmevalidee.jsp\" method=\"GET\" ><input type=\"hidden\" id=\"idalarme\" name=\"numalarme\" value="
						+ A.get(i).getNumero()
						+ "> <input type=\"submit\" name=\" Effectuer une maintenance corrective \" value=\" Effectuer une maintenancecorrective \" /></form></td></tr>"
						);
		}
		out.println("</tbody></table><br><br>"); 
		session.setAttribute("Alarme",A);
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