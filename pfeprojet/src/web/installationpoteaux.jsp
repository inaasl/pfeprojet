<html>
<head>
<title>Ajout d'une Poteau Incendie </title>
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
	<%@ page import="java.util.Collection"%>
	<%@ page import="java.util.Set"%>
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.naming.NamingException"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>
	<%@ page import="java.text.DateFormat"%>
	<%@ page import="java.util.HashSet"%>
	
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
		if(ajout!=null){
			session.setAttribute("ajout",ajout);
		}
		else {
			ajout=String.valueOf(session.getAttribute("ajout"));
		}
	
	%>
<form action="installationpoteauxvalidee.jsp" method="post" onsubmit="return check(this);">
		 <fieldset>
		 <legend><b>Installation Poteau Incendie</b></legend>
		<br>
		<table>
		<tr></tr>
		<tr>
			<td> <label for="emplacement"><i>Emplacement du poteau incendie <font color="#ff0000">*</font></i></label></td>
			<td><textarea name="emplacement" rows="5" cols="47" required placeholder="emplacement Poteau Incendie..."></textarea></td></tr>
	  <tr></tr>
	 <tr></tr>
	 <tr>
	  	<td>
        	<label for="diametre"><i> Diamètre  <font color="#ff0000">*</font></i></label>
      	</td>	  
	  	<td>
	  		<input type="text" name="diametre" required placeholder="Diamètre..." size="40" class="taille_input_diametre"/>
	  	</td>
	  </tr>
	 <tr></tr>
	 	  <tr>
	  	<td>
        	<label for="pressionstat"><i> Pression Statique  <font color="#ff0000">*</font></i></label>
      	</td>	  
	  	<td>
	  		<input type="text" name="pressionstat" required placeholder="Pression Statique..." size="40" class="taille_input_pressionstat"/>
	  	</td>
	  </tr>
      <tr></tr>
      	  <tr>
	  	<td>
        	<label for="pression60"><i> Pression 60  <font color="#ff0000">*</font></i></label>
      	</td>	  
	  	<td>
	  		<input type="text" name="pression60" required placeholder="Pression 60..." size="40" class="taille_input_pression60"/>
	  	</td>
	  </tr>
	  <tr></tr>
	  	  <tr>
	  	<td>
        	<label for="pression1bar"><i> Pression 1 bar  <font color="#ff0000">*</font></i></label>
      	</td>	  
	  	<td>
	  		<input type="text" name="pression1bar" required placeholder="Pression 1 bar..." size="40" class="taille_input_pression1bar"/>
	  	</td>
	  </tr>
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