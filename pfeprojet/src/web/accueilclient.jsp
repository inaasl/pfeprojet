<!DOCTYPE HTML>
<html>
<head>
<title>Acces Client</title>
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
	})
</script>
</head>

<body>
	<div id="bloc_page">
		<header class="header">
			<a class="logo" href="http://www.desentec.fr/"><img
				src="http://www.desentec.fr/wp-content/uploads/2015/06/logo-site.png">
			</a>
				<br>
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
		</header>
		<%@ page import="java.net.URL"%>
		<%@ page import="java.net.URLConnection"%>
		<%@ page import="java.io.* "%>
		<%@ page import="ejb.sessions.*"%>
		<%@ page import="ejb.entites.* "%>
		<%@ page import="java.util.Collection"%>
		<%@ page import="java.util.Set"%>
		<%@ page import="javax.naming.InitialContext"%>
		<%@ page import="javax.naming.NamingException"%>
		<%@ page import="java.util.Date"%>
		<%@ page import="java.text.SimpleDateFormat"%>
		<%@ page import="java.text.DateFormat"%>
		<%@ page import="java.util.HashSet"%>

		<%!Entreprise E;
		int i, statut;%>
		<%
     session = request.getSession();
  	 statut=(Integer)session.getAttribute("statut");	 
	 if(statut==2)
	 {
     	int numClient = (int) session.getAttribute("numPersonne");
  	 	InitialContext ctx = new InitialContext();
	 	Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	 	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	 	E=service.rechercheEntreprisenum(numClient);
	 	out.print("<center>");
		out.println("<b> "+E.getNom()+"<br/>"+E.getAdresse()+"<br/>"+E.getTel()+"</b>");
	 	out.print("<br/><table id=\"datatables\" class=\"display\" >");
	 	out.print("<thead><tr><th> Nom du batiment </th><th> Adresse du batiment </th><th>Fiche du bâtiment</th></tr>");
	 	out.print("</thead><tbody>");
		for(i=0;i<E.getBatiments().size();i++){
			out.print(" <tr><td> "+E.getBatiments().get(i).getNom() +"</td><td>"+E.getBatiments().get(i).getAdresse()+"</td><td align=\"center\"> <form action=\"fichebatiment\" method=\"post\" ><input type=\"hidden\" id=\"idfichebat\" name=\"numBatiment\" value="+E.getBatiments().get(i).getNumero()+"> <input type=\"submit\" name=\" Consulter la fiche \" value=\" Consulter la fiche \" /></form></td></tr>");
		}
		out.print("</tbody></table></center>");
	 }
	 else
		 	out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
  %>
</div>
</body>
</html>