<html>
<head>
<title>Maintenance Corrective : Eclairage </title>
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
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.naming.NamingException"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>
	<%@ page import="java.text.DateFormat"%>
	<%@ page import="java.util.List"%>

		<%!String numBat,observation;
			int i,num,numeclairage;%>
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
			
			numeclairage = Integer.parseInt(request.getParameter("numeclairage"));
			observation=service.rechercheObservationMaintenancecorr(numeclairage);
			Eclairage E =(Eclairage)service.rechercheOrganeNum(numeclairage);
			session.setAttribute("numeclairage",numeclairage);
		%>
<form action="maintenancecorreclairagevalideeconclu.jsp" method="post">
		 <fieldset>
		 <legend><b>Maintenance Corrective Eclairage</b></legend>
		<br>
		<table>
		<tr>
			<td> <label for="emplacement"><i>Emplacement de l'éclairage <font color="#ff0000">*</font></i></label></td>
			<td><textarea name="emplacement" rows="5" cols="47" required placeholder="emplacement extincteur..."><%out.println(E.getEmplacement()); %></textarea></td></tr>
	  <tr></tr>
	 <tr></tr>
	 <tr><td> <label for="typeeclairage"><i>Type de l'éclairage <font color="#ff0000">*</font></i></label>	 
			</td> 
			<td> <select name="typeeclairage" class="class_select">

					<%
						
						for (i = 0; i < service.touslesTypeEclairage().size(); i++)
							out.println("<option value=" + service.touslesTypeEclairage().get(i).getNumero() + ">"
									+ service.touslesTypeEclairage().get(i).getNom() + "</option>");
					%>
				</select>
			</td>
			<td><label for="nomTypeEclairage"><i>Ajout d'un nouveau Type </i></label></td><td> <input type="text"
					name="nomTypeEclairage"  placeholder="nom du type ..." size="20" class="taille_input_typeeclairage"/>
		  
		 	 </td>
		</tr>
      <tr></tr>
	  <tr> <td> <label for="marqueeclairage"><i>Marque de l'éclairage <font color="#ff0000">*</font></i></label>
			</td><td><select name="marqueeclairage" class="class_select">
					<%
						for (i = 0; i < service.touteslesMarqueEclairage().size(); i++)
							out.println("<option value=" + service.touteslesMarqueEclairage().get(i).getNumero() + ">"
									+ service.touteslesMarqueEclairage().get(i).getNom() + "</option>");
					%>
			</select></td>
			<td><label for="nomMarqueEclairage"><i>Ajout d'une nouvelle Marque </i></label></td><td><input type="text"
					name="nomMarqueEclairage"  placeholder="nom de la marque..." size="20" class="taille_input_typeeclairage"/>
		 	 </td>
			</tr>
			<tr></tr>
			<tr>
			<td> Télécommande </td>
			<td></td>
			</tr>
			<tr><td> Est-ce que la télécommande est présente ? </td><td>
			<INPUT id="oui" type= "radio" name="presencetelecommande" value="oui">
		    <label for="oui">OUI</label> &nbsp;&nbsp;&nbsp;
			<INPUT id="non" type= "radio" name="presencetelecommande" value="non"> 
			<label for="non">NON</label> &nbsp;&nbsp;&nbsp;
			</td></tr>
			<tr></tr>
			<tr><td> La télécommande fonctionne-t-elle correctement ? </td><td>
			<INPUT id="oui" type= "radio" name="fonctionnementtelecommande" value="oui">
		    <label for="oui">OUI</label> &nbsp;&nbsp;&nbsp;
			<INPUT id="non" type= "radio" name="fonctionnementtelecommande" value="non"> 
			<label for="non">NON</label> &nbsp;&nbsp;&nbsp;
			</td></tr>
			<tr></tr>
			<tr><td> <label for="typetelecommande"><i>Type de la télécommande <font color="#ff0000">*</font></i></label>	 
			</td><td> <select name="typetelecommande" class="class_select">

					<%
						
						for (i = 0; i < service.touslesTypetelecommande().size(); i++)
							out.println("<option value=" + service.touslesTypetelecommande().get(i).getNumero() + ">"
									+ service.touslesTypetelecommande().get(i).getNom() + "</option>");
					%>
				</select>
			</td>
			<td><label for="nomTypeTelecommande"><i>Ajout d'un nouveau Type </i></label></td><td><input type="text"
					name="nomTypeTelecommande"  placeholder="nom du type ..." size="20" class="taille_input_typetelecommande"/>
		  
		 	 </td>
			</tr>
      		<tr></tr>
	  		<tr><td><label for="observations"><i>Observations <font color="#ff0000">*</font></i></label></td><td>
					<textarea name="observations" rows="5" cols="47" required placeholder="observations......"></textarea> 
			</td>
	 		</tr>
	 		<tr></tr>
	 		<tr><td> Est-ce que l'organe fonctionne correctement ? </td><td>
			<INPUT id="oui" type= "radio" name="etat" value="oui">
	    	<label for="oui">OUI</label> &nbsp;&nbsp;&nbsp;
			<INPUT id="non" type= "radio" name="etat" value="non"> 
			<label for="non">NON</label> &nbsp;&nbsp;&nbsp;
			</td></tr>
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