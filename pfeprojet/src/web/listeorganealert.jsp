<!DOCTYPE HTML>
<html>
<head>
<title>Liste des organes défectueux </title>
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
		$('#datatables7').dataTable();
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
		<%@ page import="java.util.Date"%>
		<%@ page import="java.text.SimpleDateFormat"%>
		<%@ page import="java.text.DateFormat"%>
		<%@ page import="java.util.HashSet"%>

		<%!
		int i; 
		String numBatiment;
		List<Extincteur> extincteur;
		List<Pharmacie> pharmacie;
		List<Eclairage> eclairage;
		List<Poteaux> poteaux;
		List<RIA> ria;
		List<Signaletique> signaletique;
		List<Coupefeu> coupefeu;
    	int num;
    	String numeroB,marche;
   	 	List<Organe> organes;
   	 	String ajout;
		%>
		<%
		session = request.getSession();
		 numBatiment = request.getParameter("batiment");
		 if(numBatiment==null){
			 numeroB = (String)session.getAttribute("numBatiment");
			 num=Integer.parseInt(numeroB);
		 }
		 else{
			 num = Integer.parseInt(numBatiment);
		 }
		
		Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
		pdf=null;
		
		organes=(List<Organe>)session.getAttribute("organes");
		if(organes!=null) organes.clear();
		ajout=String.valueOf(session.getAttribute("ajout"));
		if(ajout!=null) ajout=null;
		 
		session.setAttribute("numBatiment",String.valueOf(num));
	    
		InitialContext ctx = new InitialContext();
	 	Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	 	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
		
	 	out.print("<center>");
		out.println("<h3>Liste des Organes</h3><br><br>");
		
		// Extincteur
		
		List<Organe> organe = service.rechercheOrganeDefectBatiment(num);
		
		for(int j=0;j<organe.size();j++){
			if(organe.get(j) instanceof Extincteur){
				if(extincteur==null){
					extincteur=new ArrayList<Extincteur>();
					extincteur.add((Extincteur)organe.get(j));
				}
				else
					extincteur.add((Extincteur)organe.get(j));
			}
			else {
				if(organe.get(j) instanceof Pharmacie){
					if(pharmacie==null){
						pharmacie=new ArrayList<Pharmacie>();
						pharmacie.add((Pharmacie)organe.get(j));
					}
					else
						pharmacie.add((Pharmacie)organe.get(j));
				}
				else {
					if(organe.get(j) instanceof Eclairage){
						if(eclairage==null){
							eclairage=new ArrayList<Eclairage>();
							eclairage.add((Eclairage)organe.get(j));
						}
						else
							eclairage.add((Eclairage)organe.get(j));
					}
					else {
						if(organe.get(j) instanceof Poteaux){
							if(poteaux==null){
								poteaux=new ArrayList<Poteaux>();
								poteaux.add((Poteaux)organe.get(j));
							}
							else
								poteaux.add((Poteaux)organe.get(j));
						}
						else {
							if(organe.get(j) instanceof RIA){
								if(ria==null){
									ria=new ArrayList<RIA>();
									ria.add((RIA)organe.get(j));
								}
								else
									ria.add((RIA)organe.get(j));
							}
							else {
								if(organe.get(j) instanceof Coupefeu){
									if(coupefeu==null){
										coupefeu=new ArrayList<Coupefeu>();
										coupefeu.add((Coupefeu)organe.get(j));
									}
									else
										coupefeu.add((Coupefeu)organe.get(j));
								}
								else {
									if(organe.get(j) instanceof Signaletique){
										if(signaletique==null){
											signaletique=new ArrayList<Signaletique>();
											signaletique.add((Signaletique)organe.get(j));
										}
										else
											signaletique.add((Signaletique)organe.get(j));
									}
								}
							}
						}
					}
				}
			}
		}
		if(extincteur!=null){
			out.println("<h4>Extincteur</h4><br>");
			out.print("</center>");
	    	out.print("<br/><table id=\"datatables1\" class=\"display\" >");
	 	 	out.print("<thead><tr><th>N°</th><th>Emplacement</th><th>Année</th><th>Type</th><th>Marque</th><th>Observation</th><th>Etat</th></tr>");
	 	 	out.print("</thead><tbody>");
			for(i=0;i<extincteur.size();i++){
				if(extincteur.get(i).isMarche()==true)
					marche="<img src=\"marchtrue.jpg\">";
				else
					marche="<img src=\"marchefalse.png\">";
					
					out.print(" <tr><td>"+extincteur.get(i).getNumero()
							+"</td><td>"+extincteur.get(i).getEmplacement()
							+"</td><td>"+extincteur.get(i).getAnnee()
							+"</td><td>"+extincteur.get(i).getType().getNom()
							+"</td><td>"+extincteur.get(i).getMarque().getNom()
							+"</td><td>"+extincteur.get(i).getObservation()
							+"</td><td>"+marche
							+"</td></tr>");
			 }
		  out.print("</tbody></table><br>");
		}
		
		if(eclairage!=null) {
			if(eclairage.get(i).isMarche()==true)
				marche="<img src=\"marchtrue.jpg\">";
			else
				marche="<img src=\"marchefalse.png\">";
			out.println("<h4>Eclairage</h4><br>");
			out.print("</center>");
	    	out.print("<br/><table id=\"datatables2\" class=\"display\" >");
	 	 	out.print("<thead><tr><th>N°</th><th>Emplacement</th><th>Type</th><th> Marque </th><th>Présence télécommande </th><th>fonctionnement télécommande </th><th>Type télécommande </th><th>Observation</th><th>Etat</th></tr>");
	 	 	out.print("</thead><tbody>");
			out.print("</tbody></table><br>");
		}
		
		if(pharmacie!=null) {
			if(pharmacie.get(i).isMarche()==true)
				marche="<img src=\"marchtrue.jpg\">";
			else
				marche="<img src=\"marchefalse.png\">";
			out.println("<h4>Pharmacie</h4><br>");
			out.print("</center>");
	    	out.print("<br/><table id=\"datatables3\" class=\"display\" >");
	 	 	out.print("<thead><tr><th>N°</th><th>Emplacement</th><th> Capacité </th><th> Année </th><th>Observation</th><th>Etat</th></tr>");
	 	 	out.print("</thead><tbody>");
		  	out.print("</tbody></table><br>");
		}
		
		if(coupefeu!=null) {
			if(coupefeu.get(i).isMarche()==true)
				marche="<img src=\"marchtrue.jpg\">";
			else
				marche="<img src=\"marchefalse.png\">";
			out.println("<h4>Porte Coupe-feu</h4><br>");
			out.print("</center>");
	    	out.print("<br/><table id=\"datatables4\" class=\"display\" >");
	 	 	out.print("<thead><tr><th>N°</th><th>Emplacement</th><th>Type</th><th>Observation</th><th>Etat</th></tr>");
	 	 	out.print("</thead><tbody>");
		  	out.print("</tbody></table><br>");
		}
		
		if(ria!=null) {
			if(ria.get(i).isMarche()==true)
				marche="<img src=\"marchtrue.jpg\">";
			else
				marche="<img src=\"marchefalse.png\">";
			out.println("<h4>RIA</h4><br>");
			out.print("</center>");
	    	out.print("<br/><table id=\"datatables5\" class=\"display\" >");
	 	 	out.print("<thead><tr><th>N°</th><th>Emplacement</th><th>Type</th><th>Observation</th><th>Etat</th></tr>");
	 	 	out.print("</thead><tbody>");
			out.print("</tbody></table><br>");
		}
		
		if(poteaux!=null) {
			if(poteaux.get(i).isMarche()==true)
				marche="<img src=\"marchtrue.jpg\">";
			else
				marche="<img src=\"marchefalse.png\">";
			out.println("<h4>Poteaux Incendie</h4><br>");
			out.print("</center>");
	    	out.print("<br/><table id=\"datatables6\" class=\"display\" >");
	 	 	out.print("<thead><tr><th>N°</th><th>Emplacement</th><th>diamètre</th><th> Pression statique </th><th>Pression 60</th><th>Pression 1bar</th><th>Observation</th><th>Etat</th></tr>");
	 	 	out.print("</thead><tbody>");
			out.print("</tbody></table><br>");
		}
		
		if(signaletique!=null) {
			if(signaletique.get(i).isMarche()==true)
				marche="<img src=\"marchtrue.jpg\">";
			else
				marche="<img src=\"marchefalse.png\">";
			out.println("<h4>Signalétique</h4><br>");
			out.print("</center>");
	    	out.print("<br/><table id=\"datatables7\" class=\"display\" >");
	 	 	out.print("<thead><tr><th>N°</th><th>Emplacement</th><th>Observation</th><th>Etat</th></tr>");
	 	 	out.print("</thead><tbody>");
			out.print("</tbody></table><br>");
		
		}
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