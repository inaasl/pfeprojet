
<html>
<head>
<title>Liste de tous les clients </title>
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
	List<Intervention> interv;
	%>
	<%
	 if(session.getAttribute("statut")!=null)
	 {
	 	session = request.getSession();
	 	statut=(Integer)session.getAttribute("statut");	 
	 	if(statut==1 || statut==0)
	 	{
	 		if(statut==0)
	 		{
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
	<li><a href="#">Déconnexion</a>
	</li>
	</ul>
	<%
	 		}if(statut==1)
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
	<% 		
	interv=(List<Intervention>)session.getAttribute("interv");
	if(interv!=null) interv.clear();
	session.setAttribute("Interv",interv);
	Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
	pdf=null;
	session.setAttribute("pdf",pdf);
	List<Organe >organes=(List<Organe>)session.getAttribute("organes");
	if(organes!=null) organes.clear();
	session.setAttribute("organes",organes);
	String ajout=String.valueOf(session.getAttribute("ajout"));
	if(ajout!=null) ajout="0";
	session.setAttribute("ajout",ajout);
	}
	%>
	</header>
  <div id="container">
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
	<%@ page import="java.util.List"%>


	<%!String nomEntreprise;
	List<Entreprise> E;
	int i;
	%>
	<%
		out.println("<h3><center>Liste de tous les clients </center></h3> <br> ");

		InitialContext ctx = new InitialContext();
		Object obj = ctx.lookup(
				"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
		session = request.getSession();
	
		out.print("<br> <table id=\"datatables\" class=\"display\" >");
		out.print("<thead><tr><th> Client </th><th> Adresse </th><th> Télephone </th><th> Mail </th><th>Interlocuteur </th><th>Fiche du client</th></tr>");
		out.print("</thead><tbody>");
		for(i=0;i<service.getlisteEntreprises().size();i++){
			out.print(" <tr><td > "+service.getlisteEntreprises().get(i).getNom()+"</td><td>"+service.getlisteEntreprises().get(i).getAdresse()+"</td><td>"+service.getlisteEntreprises().get(i).getTel()+
					"<td>"+service.getlisteEntreprises().get(i).getAdressemail()+"</td> "+"<td>"+service.getlisteEntreprises().get(i).getNominterlocuteur()+"</td> "+"</td><td> <form action=\"ficheentreprise\" method=\"POST\" ><input type=\"hidden\" id=\"thisField\" name=\"numEntreprise\" value="+service.getlisteEntreprises().get(i).getNumero()+"> <input type=\"submit\" name=\" Consulter la fiche \" value=\" Consulter la fiche \" /></form></td></tr>");
		}
		out.print("</tbody></table>");
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

