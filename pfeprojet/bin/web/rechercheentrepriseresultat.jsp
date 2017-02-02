<html>

<head>
<title>Résultat de la recherche</title>
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
		<center>
			<strong>Desentec - Protection incendie</strong>
		</center>
		</p>
	</header>
	<%! int statut;
	%>
	<%
	 if(session.getAttribute("statut")!=null)
	 {
	 session = request.getSession();
	 statut=(Integer)session.getAttribute("statut");	 
	 if(statut==0 || statut==1)
	 {
	%>
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
	Entreprise Ent;
	int i;%>
	<%
		out.println("Résultat de la recherche : ");
		nomEntreprise = request.getParameter("nomEntreprise");
		InitialContext ctx = new InitialContext();
		Object obj = ctx.lookup(
				"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;

		out.print("<br> <br> <table id=\"datatables\" class=\"display\" >");
		out.print("<thead><tr><th> Client </th><th> Adresse </th><th> Télephone </th><th> Mail </th><th>Interlocuteur </th><th>Fiche du client</th></tr>");
		out.print("</thead><tbody>");
		for (i = 0; i < service.rechercheEntreprise(nomEntreprise).size(); i++) {
			out.print(" <tr><td > "
					+ service.rechercheEntreprise(nomEntreprise).get(i).getNom()
					+ "</td><td>"
					+ service.rechercheEntreprise(nomEntreprise).get(i).getAdresse()
					+ "</td><td>"
					+ service.rechercheEntreprise(nomEntreprise).get(i).getTel()
					+ "</td><td>"
					+ service.rechercheEntreprise(nomEntreprise).get(i).getAdressemail()
					+ "</td><td>"
					+ service.rechercheEntreprise(nomEntreprise).get(i).getNominterlocuteur()
					+ "</td><td> <form action=\"ficheentreprise\" method=\"GET\" ><input type=\"hidden\" id=\"thisField\" name=\"numEntreprise\" value="
					+ service.rechercheEntreprise(nomEntreprise).get(i).getNumero()
					+ "> <input type=\"submit\" name=\" Consulter la fiche \" value=\" Consulter la fiche \" /></form></td></tr>");
		}
		out.print("</tbody></table>");
	%>
	<%
	 }
	 }
	 else
	 	out.println("<center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\">");
	%>
</body>
</html>






