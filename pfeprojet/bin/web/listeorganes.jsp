<!DOCTYPE HTML>
<html>
<head>
<title>Liste des organes </title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">

<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="datatables.css" />
<script type="text/javascript" src="jquery.dataTables.js"></script>

<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/v/dt/dt-1.10.12/datatables.min.css" />

<script type="text/javascript"
	src="https://cdn.datatables.net/v/dt/dt-1.10.12/datatables.min.js"></script>

<script type="text/javascript" charset="utf-8">
	$(document).ready(function() {
		$('#datatables').dataTable();
		$('#datatables1').dataTable();
		$('#datatables2').dataTable();
		$('#datatables3').dataTable();
		$('#datatables4').dataTable();
		$('#datatables5').dataTable();
		$('#datatables6').dataTable();
	})
</script>
</head>

<body>
	
		<header class="header">
			<a class="logo" href="http://www.desentec.fr/"><img
				src="http://www.desentec.fr/wp-content/uploads/2015/06/logo-site.png">
			</a>
				<br>
	<%! int statut;
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
		<% }
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
		<br><br><br><br><br><br>
		<div id="container">
		<%@ page import="java.net.URL"%>
		<%@ page import="java.net.URLConnection"%>
		<%@ page import="java.io.* "%>
		<%@ page import="ejb.sessions.*"%>
		<%@ page import="ejb.entites.* "%>
		<%@ page import="java.util.Collection"%>
		<%@ page import="java.util.Set"%>
		<%@ page import="java.util.List"%>
		<%@ page import="javax.naming.InitialContext"%>
		<%@ page import="javax.naming.NamingException"%>
		<%@ page import="java.util.Date"%>
		<%@ page import="java.text.SimpleDateFormat"%>
		<%@ page import="java.text.DateFormat"%>
		<%@ page import="java.util.HashSet"%>

		<%!
		int i; 
		String numBatiment;
    	
    	int num;
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
	 	Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	 	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
		
	 	out.print("<center>");
		out.println("<b>Liste des Organes</b><br><br>");
		
		// Extincteur
		List<Organe> organe = service.rechercheOrganeBatiment(num);
		
		out.println("Extincteur<br>");
		out.print("</center>");
    	out.print("<br/><table id=\"datatables\" class=\"display\" >");
 	 	out.print("<thead><tr><th>N°</th><th>Emplacement</th><th>Observation</th><th>Année</th><th>Type</th><th>Marque</th></tr>");
 	 	out.print("</thead><tbody>");
		for(int j=0;j<organe.size();j++){
	    
		List<Extincteur> extincteur = service.rechercheExtincteurNum(organe.get(j).getNumero());
		  if(organe.get(j) instanceof Extincteur){
		    
		  for(i=0;i<extincteur.size();i++){
			out.print(" <tr><td>"+extincteur.get(i).getNumero()+"</td><td>"+extincteur.get(i).getEmplacement()+"</td><td>"+extincteur.get(i).getObservation()+"</td>"
			+"<td>"+extincteur.get(i).getAnnee()+"</td><td>"+extincteur.get(i).getType().getNom()+"</td><td>"+extincteur.get(i).getMarque().getNom()+"</td></tr>");
		  }
		  
		 
	     }
		  
		 }
		 out.print("</tbody></table><br>");
		 
		// Coupefeu
		out.print("<center>");
		out.println("Coupefeu<br>");
		out.print("</center>");
	    out.print("<br/><table id=\"datatables1\" class=\"display\" >");
		out.print("<thead><tr><th>N°</th><th>Emplacement</th><th>Observation</th><th>Année</th><th>Type</th><th>Marque</th></tr>");
		out.print("</thead><tbody>");
		 
		 for(int j=0;j<organe.size();j++){
			
			if(organe.get(j) instanceof Coupefeu){
	    	 
		 	 
		 	
	      }
		 }
		 out.print("</tbody></table><br>");
		 
		 //Poteaux
		 out.print("<center>");
		 out.println("Poteaux<br>");
		 out.print("</center>");
	     out.print("<br/><table id=\"datatables2\" class=\"display\" >");
		 out.print("<thead><tr><th>N°</th><th>Emplacement</th><th>Observation</th><th>Année</th><th>Type</th><th>Marque</th></tr>");
		 out.print("</thead><tbody>");
		  
		  for(int j=0;j<organe.size();j++){
			 if(organe.get(j) instanceof Poteaux){
	    	 
		 	 
		 	
	    	 
	      }
		 }
		 out.print("</tbody></table><br>");
		  
		 //RIA
		out.print("<center>");
		out.println("RIA<br>");
		out.print("</center>");
   	    out.print("<br/><table id=\"datatables3\" class=\"display\" >");
	 	 out.print("<thead><tr><th>N°</th><th>Emplacement</th><th>Observation</th><th>Année</th><th>Type</th><th>Marque</th></tr>");
	 	 out.print("</thead><tbody>");
		for(int j=0;j<organe.size();j++){
	     if(organe.get(j) instanceof RIA){
	    	 

	    	 
	      }
		}
		out.print("</tbody></table><br>");
		//Signaletique
		organe = service.rechercheOrganeBatiment(num);
		out.print("<center>");
		out.println("Signaletique<br>");
		out.print("</center>");
   	    out.print("<br/><table id=\"datatables4\" class=\"display\" >");
	 	 out.print("<thead><tr><th>N°</th><th>Emplacement</th><th>Observation</th><th>Année</th><th>Type</th><th>Marque</th></tr>");
	 	 out.print("</thead><tbody>");
		for(int j=0;j<organe.size();j++){  
		  if(organe.get(j) instanceof Signaletique){
	    	 
		 	 
		 	
	    	 
	       }
		}
		out.print("</tbody></table><br>");
		
		//Pharmacie
		out.print("<center>");
		out.println("Pharmacie<br>");
		out.print("</center>");
   	    out.print("<br/><table id=\"datatables5\" class=\"display\" >");
	 	out.print("<thead><tr><th>N°</th><th>Emplacement</th><th>Observation</th><th>Année</th><th>Type</th><th>Marque</th></tr>");
	 	out.print("</thead><tbody>");
		for(int j=0;j<organe.size();j++){  
	        if(organe.get(j) instanceof Pharmacie){
	    	 
		 	 
		 	
	    	 
	     }
		}
		out.print("</tbody></table><br>");
		//Eclairage
		out.print("<center>");
		out.println("Eclairage<br>");
		out.print("</center>");
   	    out.print("<br/><table id=\"datatables6\" class=\"display\" >");
	 	out.print("<thead><tr><th>N°</th><th>Emplacement</th><th>Observation</th><th>Année</th><th>Type</th><th>Marque</th></tr>");
	 	out.print("</thead><tbody>");
		for(int j=0;j<organe.size();j++){  
		 if(organe.get(j) instanceof Eclairage){
	    	 
		 	 
		 	
	     }
		}
		out.print("</tbody></table><br>");
		
		
		
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