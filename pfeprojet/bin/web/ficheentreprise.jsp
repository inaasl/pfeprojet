<html>

<head>
<title>Fiche : entreprise</title>
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
		<p class="head">
		<center></center>
		</p>
	<%! int statut;
	%>
	<%
	 if(session.getAttribute("statut")!=null)
	 {
	 	session = request.getSession();
	 	statut=(Integer)session.getAttribute("statut");	 
	 	if(statut==0 || statut==1 || statut!=2)
	 	{
	 		if(statut==0){
	%>
		<br>
	<ul id="menu">
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
		<% }
			if(statut==2){
		%>
		<ul id="menu">
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
	<%@ page import="java.net.URL"%>
	<%@ page import="java.net.URLConnection"%>
	<%@ page import="java.io.* "%>
	<%@ page import="ejb.sessions.*"%>
	<%@ page import="ejb.entites.* "%>
	<%@ page import="java.util.Collection"%>
	<%@ page import="java.util.Set"%>
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.naming.NamingException"%>
	<%@ page import="java.util.List"%>


	<%!String numEntreprise;
	Entreprise E;
	int num, i;
	String numeroE;
	List<Batiment> batiment;
	%>
	<%
		session = request.getSession();
		 numEntreprise = request.getParameter("numEntreprise");
		 if(numEntreprise==null){
			 numeroE = (String)session.getAttribute("numeroE");
			 num=Integer.parseInt(numeroE);
		 }
		 else
			 num = Integer.parseInt(numEntreprise);
		 session.setAttribute("numeroE",String.valueOf(num));
		InitialContext ctx = new InitialContext();
		Object obj = ctx.lookup(
				"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");

		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
		out.print("<br><br><center>");
		out.print("<h2>Fiche du Client</h2><hr>");
		E = service.rechercheEntreprisenum(num);
		batiment = service.rechercheBatimentEntreprise(num);
		out.println("<b><font size=\"5\">" + E.getNom() + "</b><br><i>" + E.getAdresse()
			+ "</i><br><b>Tel: </b><i>" + E.getTel()+"</i></font><br>");
		out.print("<br><br> <table id=\"datatables\" class=\"display\" >"); 
		out.print("<thead><tr><th> Nom du batiment </th><th> Adresse du batiment </th><th> Fiche batiment </th></tr>");
		out.print("</thead><tbody>");
		for (i=0; i< batiment.size();i++){
			out.print(" <tr><td> " + batiment.get(i).getNom()
					+ "</td><td <td>" + batiment.get(i).getAdresse()
					+ "</td><td> <form action=\"fichebatiment\" method=\"GET\" ><input type=\"hidden\" id=\"idfichebat\" name=\"numBatiment\" value="
					+ batiment.get(i).getNumero()
					+ "> <input type=\"submit\" name=\" Consulter la fiche \" value=\" Consulter la fiche \" /></form></td></tr>");
		}
		out.print("</tbody></table>");
	%>
	<%
	 }
	 }
	 else
	 	out.println("</header><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\">");
	%>

</body>
</html>