<html>
<head>
<title>Maintenance Corrective : Pharmacie </title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<script language="JavaScript">
   function check(f){
	    var anneevalide = new RegExp (/^(19|20)[0-9][0-9]$/);
	    var capacitevalide = new RegExp (/^[1-9][0-9]*$/)
	    if(anneevalide.test(f.annee.value)){
	    	if(capacitevalide.test(f.capacite.value)){
	    		return true;
	    	}
	    	else {
	    		alert('Valeur de la capacité non valide, Veuillez entrer un nombre !');
	    		return false;
	    	}
	    }
	    else {
	    	if(capacitevalide.test(f.capacite.value)){
	    		alert('Année non valide !');
	    		return false;
	    	}
	    	else {
	    		alert('Valeur de la capacité non valide, Veuillez entrer un nombre !');
	    		alert('Année non valide !');
	    		return false;
	    	}
	    }
	}
</script> 
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
			int num,numpharmacie;
			Pharmacie P;%>
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
			
			numpharmacie = Integer.parseInt(request.getParameter("numpharmacie"));
			observation=service.rechercheObservationMaintenancecorr(numpharmacie);
			P = (Pharmacie)service.rechercheOrganeNum(numpharmacie);
			session.setAttribute("numpharmacie",numpharmacie);
		%>
		<form action="maintenancecorrpharmacievalideeconclu.jsp" method="post" onsubmit="return check(this);">
		 <fieldset>
		 <legend><b>Maintenance Corrective</b></legend>
		<br>
		<table>
		 <tr>
			<td>
                <label for="annee"><i>Annee  <font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><input type="text"
					name="annee" required value="<%out.println(P.getAnnee());%>" size="40" class="taille_input_annee"/>
		  </td></tr>
		<tr></tr>
		<tr>
			<td> <label for="emplacement"><i>Emplacement de la pharmacie <font color="#ff0000">*</font></i></label></td>
			<td><textarea name="emplacement" rows="5" cols="47" required value="<%out.println(P.getEmplacement());%>"></textarea></td></tr>
	  <tr></tr>
	  <tr>
	  	<td>
        	<label for="capacite"><i> Capacité  <font color="#ff0000">*</font></i></label>
      	</td>	  
	  	<td>
	  		<input type="text" name="capacite" required value="<%out.println(P.getCapacite());%>" size="40" class="taille_input_capacite"/>
	  	</td>
	  </tr>
	  	<tr><td><label for="observations"><i>Observations <font color="#ff0000">*</font></i></label></td><td>
			<%
				out.println("<textarea name=\"observations\" rows=\"5\" cols=\"47\" >"+observation+"</textarea>");
				%>			
		</td></tr>
	 	<tr></tr>
	 	<tr><td> Est-ce que l'organe fonctionne correctement ? </td><td>
		<INPUT id="oui" type= "radio" name="etat" value="oui">
	    <label for="oui">OUI</label> &nbsp;&nbsp;&nbsp;
		<INPUT id="non" type= "radio" name="etat" value="non"> 
		<label for="non">NON</label> &nbsp;&nbsp;&nbsp;
		</td></tr>
	 	<tr></tr>

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