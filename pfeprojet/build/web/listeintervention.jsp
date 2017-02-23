<!DOCTYPE HTML>
<html>
<head>
<title>Liste des interventions </title>
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
		int i,num; 
		String numBatiment,numeroB,typeintervention,typeorgane,splitpt;
    	List<Pdfgenere> pdf;

		%>
		
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
	
		Pdfgenere pdfs=(Pdfgenere)session.getAttribute("pdf");
		pdfs=null;
		session.setAttribute("pdf",pdfs);

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
		
	 	pdf=service.recherchePdfgenereBatiment(num);
	 	
	 	out.print("<center>");
		out.println("<h3>Liste des Interventions</h3><br><br>");
		out.print("</center>");
		
    	out.print("<br/><table id=\"datatables\" class=\"display\" >");
 	 	out.print("<thead><tr><th>Type de l'intervention </th><th>Type de l'organe de sécurité </th><th>Date de l'intervention</th><th>Fiches</th></tr>");
 	 	out.print("</thead><tbody>");
 	 	for(i=0;i<pdf.size();i++){
 	 		if(pdf.get(i).getInterventions().get(0) instanceof Installation){
 	 			typeintervention="Installation";
 	 		}
 	 		else {
 	 			if(pdf.get(i).getInterventions().get(0) instanceof Verification) {
 	 				typeintervention="Vérification";
 	 			}
 	 			else {
 	 				if(pdf.get(i).getInterventions().get(0) instanceof Corrective){
 	 					typeintervention="Maintenance corrective";
 	 				}
 	 				else
 	 					typeintervention="Maintenance Préventive";
 	 			}
 	 		}
 	 		if(pdf.get(i).getInterventions().get(0).getOrgane() instanceof Extincteur){
 	 			typeorgane="Extincteur";
 	 		}
 	 		else {
 	 			if(pdf.get(i).getInterventions().get(0).getOrgane() instanceof Eclairage){
 	 				typeorgane="Eclairage";
 	 			}
 	 			else {
 	 				if(pdf.get(i).getInterventions().get(0).getOrgane() instanceof Pharmacie){
 	 					typeorgane="Pharmacie";
 	 				}
 	 				else {
 	 					if(pdf.get(i).getInterventions().get(0).getOrgane() instanceof Coupefeu){
 	 						typeorgane="Porte Coupe-feu";
 	 					}
 	 					else {
 	 						if(pdf.get(i).getInterventions().get(0).getOrgane() instanceof RIA){
 	 							typeorgane="RIA";
 	 						}
 	 						else {
 	 							if(pdf.get(i).getInterventions().get(0).getOrgane() instanceof Poteaux){
 	 								typeorgane="Poteaux incendie";
 	 							}
 	 							else {
 	 								if(pdf.get(i).getInterventions().get(0).getOrgane() instanceof Signaletique){
 	 									typeorgane="Signalétique";
 	 								}
 	 								else {
 	 									if(pdf.get(i).getInterventions().get(0).getOrgane() instanceof Alarme){
 	 										typeorgane="Alarme";
 	 									}
 	 									else {
 	 										if(pdf.get(i).getInterventions().get(0).getOrgane() instanceof DesenfumageNaturel){
 	 											typeorgane="Désenfumage Naturel";
 	 										}
 	 									}
 	 								}
 	 							}
 	 						}
 	 					}
 	 				}
 	 			}
 	 		}
 	 		out.print(" <tr><td>"+typeintervention
 	 				+"</td><td>"+typeorgane
 	 				+"</td><td>"+pdf.get(i).getInterventions().get(0).getDate()
 	 				+"</td><td><form action=\"ficheintervention.jsp\" method=\"GET\" ><input type=\"hidden\" id=\"idficheinterv\" name=\"numPdf\" value="
 	 						+ pdf.get(i).getNumero()
 	 						+ "> <input type=\"submit\" name=\" Consulter la fiche \" value=\" Consulter la fiche \" /></form></td></tr>");
 	 	}
		out.print("</tbody></table><br>");
 		out.println("<br><center><form action=\"fichebatiment\" method=\"GET\" ><input type=\"button\" name=\"Fichebatiment\" value=\"Retour a la fiche du batiment \" onclick=\"self.location.href='fichebatiment.jsp'\"></button></form></center>");
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