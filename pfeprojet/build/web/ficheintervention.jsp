<html>

<head>
<title>Fiche : Intervention</title>
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
     $('#datatables1').dataTable();
     $('#datatables2').dataTable();
     $('#datatables3').dataTable();
     $('#datatables4').dataTable();
     $('#datatables5').dataTable();
     $('#datatables6').dataTable();
     $('#datatables7').dataTable();
     $('#datatables8').dataTable();
     })
    </script>
</head>
<body>
	<header class="header">
		<a class="logo" href="http://www.desentec.fr/"><img
			src="http://www.desentec.fr/wp-content/uploads/2015/06/logo-site.png">
		</a>
	<%@ page import= "ejb.entites.* "%>
	<%@ page import= "java.util.List"%>
	<%! int statut;
		List<Intervention> interv;
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
			<li><a href="ficheentreprise.jsp">Afficher tous les clients</a></li>
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
			}
			if(statut==2){
		%>
	<ul id="menu">
	<li><a href="accueilclient.jsp">Accueil</a>
	</li>
	<li><a href="#">Gestion des Batiments</a>
	<ul>
		<li><a href="affichertoutesentreprises.jsp">Afficher tous les batiments</a></li>
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
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.naming.NamingException"%>
	<%@ page import="java.util.List"%>
	<%@ page import="java.util.ArrayList"%>

	<%!String numPdf, marche;
	   int num, i,j;
	   Pdfgenere pdf;
	   List<Intervention> interventions = new ArrayList<Intervention>();
	   List<Piece> pieces = new ArrayList<Piece>();
	   List<Organe> organes;
	   String ajout;
	%>
	<%
		session = request.getSession();
		Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
		pdf=null;
		session.setAttribute("pdf",pdf);
		numPdf = request.getParameter("numPdf");
		num = Integer.parseInt(numPdf);
		
		
		InitialContext ctx = new InitialContext();
		Object obj = ctx.lookup(
			"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
		
		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
		out.print("<center>");
		out.print("<h3>Fiche de l'intervention</h3><br><br>");

		interventions=service.rechercheInterventionPdf(num);
		
		if(interventions.get(0).getOrgane() instanceof Extincteur){
			out.print("<br><br> <table id=\"datatables\" class=\"display\" >"); 
			out.print("<thead><tr><th> Numero de l'intervention </th><th> Numero de l'organe </th><th> Année </th><th> Emplacement </th><th> Type </th><th> Marque </th><th> Observation </th></tr>");
			out.print("</thead><tbody>");
			for(i=0;i<interventions.size();i++){
			out.println("<tr><td>"+interventions.get(i).getNumero()
						+"</td><td>"+interventions.get(i).getOrgane().getNumero()
						+"</td><td>"+((Extincteur)interventions.get(i).getOrgane()).getAnnee()
						+"</td><td>"+interventions.get(i).getOrgane().getEmplacement()
						+"</td><td>"+((Extincteur)interventions.get(i).getOrgane()).getType().getNom()
						+"</td><td>"+((Extincteur)interventions.get(i).getOrgane()).getMarque().getNom()
						+"</td><td>"+interventions.get(i).getOrgane().getObservation()
					+"</td></tr>");
			}
			out.print("</tbody></table>");
		}
		else {
			if(interventions.get(0).getOrgane() instanceof Pharmacie){
				out.print("<br><br> <table id=\"datatables1\" class=\"display\" >"); 
				out.print("<thead><tr><th> Numero de l'intervention </th><th> Numero de l'organe </th><th> Emplacement </th><th> Capacité </th><th> Année </th><th> Observation </th></tr>");
				out.print("</thead><tbody>");
				for(i=0;i<interventions.size();i++){
					out.println("<tr><td>"+interventions.get(i).getNumero()
								+"</td><td>"+interventions.get(i).getOrgane().getNumero()
								+"</td><td>"+interventions.get(i).getOrgane().getEmplacement()
								+"</td><td>"+((Pharmacie)interventions.get(i).getOrgane()).getCapacite()
								+"</td><td>"+((Pharmacie)interventions.get(i).getOrgane()).getAnnee()
								+"</td><td>"+interventions.get(i).getOrgane().getObservation()
							+"</td></tr>");
					}
				out.print("</tbody></table>");
			}
			else {
				if(interventions.get(0).getOrgane() instanceof Coupefeu){
					out.print("<br><br> <table id=\"datatables2\" class=\"display\" >"); 
					out.print("<thead><tr><th> Numero de l'intervention </th><th> Numero de l'organe </th><th> Emplacement </th><th> Type </th><th> Observation </th></tr>");
					out.print("</thead><tbody>");
					for(i=0;i<interventions.size();i++){
						out.println("<tr><td>"+interventions.get(i).getNumero()
									+"</td><td>"+interventions.get(i).getOrgane().getNumero()
									+"</td><td>"+interventions.get(i).getOrgane().getEmplacement()
									+"</td><td>"+((Coupefeu)interventions.get(i).getOrgane()).getType().getNom()
									+"</td><td>"+interventions.get(i).getOrgane().getObservation()
								+"</td></tr>");
						}
					out.print("</tbody></table>");
				}
				else {
					if(interventions.get(0).getOrgane() instanceof Poteaux){
						out.print("<br><br> <table id=\"datatables3\" class=\"display\" >"); 
						out.print("<thead><tr><th> Numero de l'intervention </th><th> Numero de l'organe </th><th> Emplacement </th><th> Diamètre </th><th> Pression statique </th><th> Pression 60</th><th> Pression 1bar </th><th> Observation </th></tr>");
						out.print("</thead><tbody>");
						for(i=0;i<interventions.size();i++){
							out.println("<tr><td>"+interventions.get(i).getNumero()
										+"</td><td>"+interventions.get(i).getOrgane().getNumero()
										+"</td><td>"+interventions.get(i).getOrgane().getEmplacement()
										+"</td><td>"+((Poteaux)interventions.get(i).getOrgane()).getDiametre()
										+"</td><td>"+((Poteaux)interventions.get(i).getOrgane()).getPressionstat()
										+"</td><td>"+((Poteaux)interventions.get(i).getOrgane()).getPression60()
										+"</td><td>"+((Poteaux)interventions.get(i).getOrgane()).getPression1bar()
										+"</td><td>"+interventions.get(i).getOrgane().getObservation()
									+"</td></tr>");
							}
						out.print("</tbody></table>");
					}
					else {
						if(interventions.get(0).getOrgane() instanceof Eclairage){
							String presence;
							String fonctionne;
							out.print("<br><br> <table id=\"datatables4\" class=\"display\" >"); 
							out.print("<thead><tr><th> Numero de l'intervention </th><th> Numero de l'organe </th><th>Emplacement</th><th>Type</th><th> Marque </th><th>Présence télécommande </th><th>fonctionnement télécommande </th><th>Type télécommande </th><th> Observation </th></tr>");
							out.print("</thead><tbody>");
							for(i=0;i<interventions.size();i++){
								 	if(((Eclairage)interventions.get(i).getOrgane()).isPresencetelecommande()==true)
											presence="oui";
									else
											presence="non";
									if(((Eclairage)interventions.get(i).getOrgane()).isFonctionnementtelecommande()==true)
											fonctionne="oui";
										else
											fonctionne="non";
								out.println("<tr><td>"+interventions.get(i).getNumero()
											+"</td><td>"+interventions.get(i).getOrgane().getNumero()
											+"</td><td>"+interventions.get(i).getOrgane().getEmplacement()
											+"</td><td>"+((Eclairage)interventions.get(i).getOrgane()).getType().getNom()
											+"</td><td>"+((Eclairage)interventions.get(i).getOrgane()).getMarque().getNom()
											+"</td><td>"+presence
											+"</td><td>"+fonctionne
											+"</td><td>"+((Eclairage)interventions.get(i).getOrgane()).getTypetelecommande().getNom()
											+"</td><td>"+interventions.get(i).getOrgane().getObservation()
											+"</td></tr>");
							}
							out.print("</tbody></table>");
						}
						else {
							if(interventions.get(0).getOrgane() instanceof Signaletique){
								out.print("<br><br> <table id=\"datatables5\" class=\"display\" >"); 
								out.print("<thead><tr><th> Numero de l'intervention </th><th> Numero de l'organe </th><th>Emplacement</th><th> Observation </th></tr>");
								out.print("</thead><tbody>");
								for(i=0;i<interventions.size();i++){
									out.println("<tr><td>"+interventions.get(i).getNumero()
											+"</td><td>"+interventions.get(i).getOrgane().getNumero()
											+"</td><td>"+interventions.get(i).getOrgane().getEmplacement()
											+"</td><td>"+interventions.get(i).getOrgane().getObservation()
											+"</td></tr>");
								}
								out.print("</tbody></table>");
							}
							else {
								if(interventions.get(0).getOrgane() instanceof RIA){
									out.print("<br><br> <table id=\"datatables6\" class=\"display\" >"); 
									out.print("<thead><tr><th> Numero de l'intervention </th><th> Numero de l'organe </th><th>Emplacement</th><th>Type</th><th>Pression Statique</th><th>Pression Dynamique</th><th>Portee</th><th> Observation </th></tr>");
									out.print("</thead><tbody>");
									for(i=0;i<interventions.size();i++){
										out.println("<tr><td>"+interventions.get(i).getNumero()
												+"</td><td>"+interventions.get(i).getOrgane().getNumero()
												+"</td><td>"+interventions.get(i).getOrgane().getEmplacement()
												+"</td><td>"+((RIA)interventions.get(i).getOrgane()).getType().getNom()
												+"</td><td>"+((RIA)interventions.get(i).getOrgane()).getPressionStatique()
												+"</td><td>"+((RIA)interventions.get(i).getOrgane()).getPressionDynamique()
												+"</td><td>"+((RIA)interventions.get(i).getOrgane()).getPortee()
												+"</td><td>"+interventions.get(i).getOrgane().getObservation()
												+"</td></tr>");
									}
									out.print("</tbody></table>");

								}
								else{
									if(interventions.get(0).getOrgane() instanceof Alarme){
										out.print("<br><br> <table id=\"datatables8\" class=\"display\" >"); 
										out.print("<thead><tr><th> Numero de l'intervention </th><th> Numero de l'organe </th><th>Emplacement</th><th>Type</th><th> Observation </th><th> Fiche </th></tr>");
										out.print("</thead><tbody>");
										for(i=0;i<interventions.size();i++){
											out.println("<tr><td>"+interventions.get(i).getNumero()
													+"</td><td>"+interventions.get(i).getOrgane().getNumero()
													+"</td><td>"+interventions.get(i).getOrgane().getEmplacement()
													+"</td><td>"+((Alarme)interventions.get(i).getOrgane()).getType().getNom()
													+"</td><td>"+interventions.get(i).getOrgane().getObservation()
													+"</td><td> <form action=\"fichealarme.jsp\" method=\"GET\" ><input type=\"hidden\" id=\"idintervention\" name=\"numintervention\" value="
													+ interventions.get(i).getNumero()
													+ "> <input type=\"submit\" name=\" Consulter la fiche de l'alarme  \" value=\" Consulter la fiche de l'alarme \" /></form></td></tr>"
													);
										}
									}
								}
							}
						}
					}
				}
			}
		}
		out.print("<center><h4>Liste des Pièces</h4></center><br><br>");
		if(interventions.get(0) instanceof Preventive){		
			out.print("<br><br> <table id=\"datatables7\" class=\"display\" >"); 
			out.print("<thead><tr><th> Numero de la pièce </th><th> Numero de l'organe </th></th></tr>");
			out.print("</thead><tbody>");
			
			for(i=0;i<interventions.size();i++){
				pieces=service.recherchePieceIntervention(interventions.get(i).getNumero());
				if(pieces!=null){
					for(j=0;j<pieces.size();j++){
						out.println("<tr><td>"+pieces.get(j).getNumero()
						+"</td><td>"+pieces.get(j).getOrgane().getNumero()
						+"</td></tr>");
					}
				}
				pieces=null;
			}
			out.print("</tbody></table>");
		}
		out.println("<br><center>Conclusion : </center>");
		out.println("<br><center>"+interventions.get(0).getConclusion()+"</center>");
		session.setAttribute("pdf",pdf);
		out.println("<br><br><table><tr><td><input type=\"button\" name=\"Imprimerpdf\" value=\"Imprimer la fiche de l'intervention\"  onclick=\"self.location.href='interventionpdf.jsp'\"></button></td></tr></table>");

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