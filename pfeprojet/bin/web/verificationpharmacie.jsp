<html>
<head>
<title>V�rification Pharmacie</title>
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
		<li><a href="deconnexion.jsp">D�connexion</a>
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
	List<Pharmacie> P = new ArrayList<Pharmacie>();
	%>
	<%
		session = request.getSession();
	
	
		List<Organe> organes=(List<Organe>)session.getAttribute("organes");
		if(organes!=null) organes.clear();
		session.setAttribute("organes",organes);
	
		String ajout=String.valueOf(session.getAttribute("ajout"));
		if(ajout!=null) ajout="0";
		session.setAttribute("ajout",ajout);
		
		List<Intervention> interv=(List<Intervention>)session.getAttribute("interv");
		if(interv!=null) interv.clear();
		session.setAttribute("Interv",interv);
	
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
		P.clear();
		P=service.recherchePharmacieBatiment(num);
		out.println("<br><center><h3>V�rification de la Pharmacie</h3></center><br>");
		out.println("<center><input type=\"button\" name=\"AjoutPharm\" value=\"Ajouter une pharmacie\"  onclick=\"self.location.href='installationpharmacie.jsp?ajout=4'\"></button></center>");
		out.println("<br><center><h4> Liste des Pharmacies </h4></center>");
		// Tableau
		out.println("<br><form action=\"verificationvalidee.jsp\">");
		out.print("<br> <table id=\"datatables\" class=\"display\" >");
		out.print("<thead><tr><th> N� Pharmacie </th><th> Emplacement </th><th> Capacit� </th><th>Annee </th><th>Observation</th><th>Etat d�fecteux</th></tr>");
		out.print("</thead><tbody>");
	      
		for(i=0;i<P.size();i++){
					observation=service.rechercheObservationVerification(P.get(i).getNumero());
					out.println(" <tr><td > " + P.get(i).getNumero()+
						"</td> <td>" + P.get(i).getEmplacement()+
						"</td> <td >" + P.get(i).getCapacite()+
						"</td> <td >" + P.get(i).getAnnee()+
						"</td> <td> <input type=\"text\" name="+i+" value="+observation+
						"></td><td><INPUT id=\"oui\" type= \"radio\" name="+(i+100)+" value=\"oui\"><label for=\"oui\">OUI</label>&nbsp;&nbsp;&nbsp;<INPUT id=\"non\" type= \"radio\" name="+(i+100)+" value=\"non\"><label for=\"non\">NON</label></td></tr>"
						);
		}
		conclusion=service.rechercheConclusionVerificationPharmacie(num);
		out.println("</tbody></table><br><br>"); 
		out.println("<center><table><tr><td>Conclusion</td> <td></td> <td><textarea name=\"Conclusion\" rows=\"5\" cols=\"47\" required>"+conclusion+"</textarea></td></tr></table>");
		out.println("<br><input type=\"submit\" value=\"Valider\"></center></form>");
		session.setAttribute("organes",P);
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