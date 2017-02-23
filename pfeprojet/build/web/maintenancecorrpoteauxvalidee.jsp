<html>
<head>
<title>Maintenance Corrective : Poteaux Incendie </title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<script language="JavaScript">
   function check(f){
	    var diametrevalide = new RegExp (/^[1-9][0-9]*$/);
	    var pressionstatvalide = new RegExp (/^[0-9][0-9]*$/);
	    var pression60valide = new RegExp (/^[0-9][0-9]*$/);
	    var pression1barvalide = new RegExp (/^[0-9][0-9]*$/);
	    
	    if(diametrevalide.test(f.diametre.value)){
	    	if(pressionstatvalide.test(f.pressionstat.value)){
		    	if(pression60valide.test(f.pression60.value)){
			    	if(pression1barvalide.test(f.pression1bar.value)){
			    		return true
			    	}
			    	else {
			    		alert('La valeur de la pression 1bar est non valide, Veuillez entrer un nombre');
			    		return false
			    	}
		    	}
		    	else {
		    		alert('La valeur de la pression 60 est non valide, Veuillez entrer un nombre');
		    		return false
		    	}
	    	}
    		alert('La valeur de la pression statique est non valide, Veuillez entrer un nombre');
    		return false
	    }
	    else {
    		alert('La valeur du diamètre est non valide, Veuillez entrer un nombre');
    		return false
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
			int num,numpoteaux;
			Poteaux P;%>
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
			
			numpoteaux = Integer.parseInt(request.getParameter("numpoteaux"));
			observation=service.rechercheObservationMaintenancecorr(numpoteaux);
			P = (Poteaux)service.rechercheOrganeNum(numpoteaux);
			session.setAttribute("numpoteaux",numpoteaux);
		%>
		<form action="maintenancecorrpoteauxvalideeconclu.jsp" method="post" onsubmit="return check(this);">
		 <fieldset>
		 <legend><b>Maintenance Corrective</b></legend>
		<br>
		<table>
		<tr></tr>
		<tr>
			<td> <label for="emplacement"><i>Emplacement du Poteau Incendie <font color="#ff0000">*</font></i></label></td>
			<td><textarea name="emplacement" rows="5" cols="47" required value="<%out.println(P.getEmplacement());%>"><%out.println(P.getEmplacement());%></textarea></td></tr>
	  <tr></tr>
	 <tr>
	  	<td>
        	<label for="diametre"><i> Diamètre  <font color="#ff0000">*</font></i></label>
      	</td>	  
	  	<td>
	  		<input type="text" name="diametre" required value="<%out.println(P.getDiametre());%>" size="40" class="taille_input_diametre"/>
	  	</td>
	  </tr>
	 <tr></tr>
	 	  <tr>
	  	<td>
        	<label for="pressionstat"><i> Pression Statique  <font color="#ff0000">*</font></i></label>
      	</td>	  
	  	<td>
	  		<input type="text" name="pressionstat" required value="<%out.println(P.getPressionstat());%>" size="40" class="taille_input_pressionstat"/>
	  	</td>
	  </tr>
      <tr></tr>
      	  <tr>
	  	<td>
        	<label for="pression60"><i> Pression 60  <font color="#ff0000">*</font></i></label>
      	</td>	  
	  	<td>
	  		<input type="text" name="pression60" required value="<%out.println(P.getPression60());%>" size="40" class="taille_input_pression60"/>
	  	</td>
	  </tr>
	  <tr></tr>
	  	  <tr>
	  	<td>
        	<label for="pression1bar"><i> Pression 1 bar  <font color="#ff0000">*</font></i></label>
      	</td>	  
	  	<td>
	  		<input type="text" name="pression1bar" required value="<%out.println(P.getPression1bar());%>" size="40" class="taille_input_pression1bar"/>
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