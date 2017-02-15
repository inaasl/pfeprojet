<html>
<head>
<title>Installation d'une Pharmacie </title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
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
	<%@ page import="java.util.Collection"%>
	<%@ page import="java.util.Set"%>
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.naming.NamingException"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>
	<%@ page import="java.text.DateFormat"%>
	<%@ page import="java.util.HashSet"%>


<form action="installationphamacievalidee">
		 <fieldset>
		 <legend><b>Installation pharmacie</b></legend>
		<br>
		<table>
		 <tr>
			<td>
                <label for="annee"><i>Annee de fabrication  <font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><input type="text"
					name="annee" required placeholder="Annee..." size="40" class="taille_input_annee"/>
		  </td></tr>
		<tr></tr>
		<tr>
			<td> <label for="emplacement"><i>Emplacement <font color="#ff0000">*</font></i></label></td>
			<td><textarea name="emplacement" rows="5" cols="47" required placeholder="emplacement ..."></textarea></td></tr>
	  <tr></tr>
	  <tr>
	  <td><label for="capacite"><i>Capacite  <font color="#ff0000">*</font></i></label>
      </td>	
	  <td><input type="text" name="capacite" required placeholder="Capacite..." size="40" class="taille_input_capacite"/></td></tr>
	 <tr></tr>
	 <tr><td><label for="observations"><i>Observations <font color="#ff0000">*</font></i></label></td><td>
					<textarea name="observations" rows="5" cols="47" required placeholder="observations......"></textarea> 
			</td>
	 </tr>
	 <tr></tr>
					<%!String numBat;
					int num, i;%>
					<%
						session = request.getSession();
						Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
						pdf=null;
						InitialContext ctx = new InitialContext();
						Object obj = ctx.lookup(
								"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
						ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
						numBat = String.valueOf(session.getAttribute("num"));
						session.setAttribute("num", numBat);
						
					%>
	  </table>
			<br><center><input type="submit" value="Valider"> </center>
			</fieldset>
		</form>
		</div>
	<%
	 }
	 }
	 else
	 	out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
	%>
</body>
</html>