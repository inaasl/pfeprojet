<html>
<head>
<title>Fiche : Alarme Incendie </title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
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
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.naming.NamingException"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>
	<%@ page import="java.text.DateFormat"%>
	<%@ page import="java.util.List"%>

		<%!String numBat,observation,numintervention,conclusion,observinterv;
			int i,num,numdesenfumage,intinterv;
			String observationouvrant;
			DesenfumageNaturel D;
			String[] result;%>
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
			
			numBat = String.valueOf(session.getAttribute("num"));
			session.setAttribute("num", numBat);
			
			numintervention=request.getParameter("numintervention");
			if(numintervention==null) {
			numdesenfumage = Integer.parseInt(request.getParameter("numalarme"));
			D =(DesenfumageNaturel)service.rechercheOrganeNum(numdesenfumage);
			conclusion=D.getConclusion();
			}
			else {
				intinterv=Integer.parseInt(numintervention);
				Intervention I = service.rechercheInterventionNum(intinterv);
				D=(DesenfumageNaturel)I.getOrgane();
				String obs;
				obs=I.getObservation();
				result=obs.split(";");
				conclusion=I.getConclusion();
			}
		%>
		
		 <fieldset>
	 <legend><b>Fiche Désenfumage Naturel</b></legend>
	<br>
	<table>
	
	<tr><td><i>Emplacement du désenfumage : </i></td>
	<td><%out.println(D.getEmplacement()); %></td></tr>
	
	<tr><td><i>Cartouches : </i></td>
	<td><%out.println(D.getCartouches()); %></td>
	</tr>
	</table>
	<table id="datatables" class="display" >
	<tr><td><h5>Ouvrants : </h5></td></tr>
	<%
	if(numintervention!=null) {
		out.print("<thead><tr><th>Numéro</th><th>Commande</th><th>Ouvrant</th><th>Observations Lors de l'intervention</th></tr>");
		out.print("</thead><tbody>");
		for(int i=0;i< D.getOuvrants().size();i++){
			observationouvrant=result[i];
			out.print("<tr><td>"+D.getOuvrants().get(i).getCommande()+
						"</td><td>"+D.getOuvrants().get(i).getNom()+
						"</td><td>"+observationouvrant+"</td></tr>"
			);
		}
		out.print("</tbody></table>");
	}
	else {
		out.print("<thead><tr><th>Numéro</th><th>Commande</th><th>Ouvrant</th><th>Observations Lors de la dernière intervention</th></tr>");
		out.print("</thead><tbody>");
		for(int i=0;i< D.getOuvrants().size();i++){
			observationouvrant=result[i];
			out.print("<tr><td>"+D.getOuvrants().get(i).getCommande()+
						"</td><td>"+D.getOuvrants().get(i).getNom()+
						"</td><td>"+D.getOuvrants().get(i).getObservation()+"</td></tr>"
			);
		}
		out.print("</tbody></table>");
	}
	%>
	</table>
	<table>
	<% if(numintervention!=null){ %>
	<tr><td><i>Conclusion : </i></td><td>
	<%out.println(conclusion);%>
	</td>
	</tr>
	<% } else { %>
	<tr><td><i>Conclusion de la dernière intervention: </i></td><td>
	<%out.println(conclusion);%>
	</td>
	</tr>
	<%} %>
	</table>
	<br>
	</fieldset>
	</div>
	<%
	 }
	 }
	 else
	 	out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
	%>
</body>
</html>