<html>
<head>
<title>Ajout d'une pharmacie </title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<script language="JavaScript">
   function check(f){
	    var anneevalide = new RegExp (/^(19|20)[0-9][0-9]$/);
	    var capacitevalide = new RegExp (/^[1-9][0-9]*$/);
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
	
	<%!String numBat,ajout;
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
		
		ajout=request.getParameter("ajout");
		if(ajout!=null)
				session.setAttribute("ajout",ajout);
		else {
			ajout=String.valueOf(session.getAttribute("ajout"));
		}
	
	%>
<form action="installationpharmacievalidee.jsp" method="post" onsubmit="return check(this);">
		 <fieldset>
		 <legend><b>Installation Pharmacie</b></legend>
		<br>
		<table>
		 <tr>
			<td>
                <label for="annee"><i>Annee  <font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><input type="text"
					name="annee" required placeholder="Annee..." size="40" class="taille_input_annee"/>
		  </td></tr>
		<tr></tr>
		<tr>
			<td> <label for="emplacement"><i>Emplacement de la pharmacie <font color="#ff0000">*</font></i></label></td>
			<td><textarea name="emplacement" rows="5" cols="47" required placeholder="emplacement extincteur..."></textarea></td></tr>
	  <tr></tr>
	  <tr>
	  	<td>
        	<label for="capacite"><i> Capacité  <font color="#ff0000">*</font></i></label>
      	</td>	  
	  	<td>
	  		<input type="text" name="capacite" required placeholder="Capacité..." size="40" class="taille_input_capacite"/>
	  	</td>
	  </tr>
	  <% if(ajout.compareTo("0")==0) { %>
	  <tr><td><label for="observations"><i>Observations <font color="#ff0000">*</font></i></label></td><td>
					<textarea name="observations" rows="5" cols="47" required placeholder="observations......"></textarea> 
			</td>
	 </tr>
	 <% } %>
	 <tr></tr>
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