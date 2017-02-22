<html>
<head>
<title>Maintenance Corrective : RIA</title>
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
	List<RIA> R = new ArrayList<RIA>();
	List<Organe> organes;
	String ajout;
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
		R.clear();
		R=service.rechercheRiaBatiment(num);
		out.println("<br><center><h3>Maintenance Corrective des Ria</h3></center><br>");
		out.println("<center><input type=\"button\" name=\"AjoutRIA\" value=\"Ajouter RIA \"  onclick=\"self.location.href='installationria.jsp?ajout=14'\"></button></center>");
		out.println("<br><center><h4> Liste des RIA </h4></center>");
		// Tableau
		out.print("<br> <table id=\"datatables\" class=\"display\" >");
		out.print("<thead><tr><th> N° RIA </th><th> Emplacement </th><th>Pression statique</th><th>Pression Dynamique</th><th>Portee</th><th> Type </th><th></th></tr>");
		out.print("</thead><tbody>");
	      
		for(i=0;i<R.size();i++){
					out.println(" <tr><td > " + R.get(i).getNumero()+
						"</td><td>" + R.get(i).getEmplacement()+
						"</td><td>" + R.get(i).getPressionStatique()+
						"</td><td>" + R.get(i).getPressionDynamique()+
						"</td><td>" + R.get(i).getPortee()+
						"</td><td>" + R.get(i).getType().getNom()+
						"</td><td> <form action=\"maintenancecorrriavalidee.jsp\" method=\"GET\" ><input type=\"hidden\" id=\"idria\" name=\"numria\" value="
						+ R.get(i).getNumero()
						+ "> <input type=\"submit\" name=\" Effectuer une maintenance corrective \" value=\" Effectuer une maintenance corrective \" /></form></td></tr>"
						);
		}
		out.println("</tbody></table><br><br>"); 
		session.setAttribute("Ria",R);
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