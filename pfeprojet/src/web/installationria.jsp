<html>
<head>
<title>Ajout RIA </title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<script language="JavaScript">
   function check(f){
	    var pressionstatvalide = new RegExp (/^[1-9][0-9]*$/);
	    var pressiondynamvalide = new RegExp (/^[1-9][0-9]*$/);
	    var porteevalide = new RegExp (/^[1-9][0-9]*$/);
	    
	    if(pressionstatvalide.test(f.pressionstat.value)){
	    	if(pressiondynamvalide.test(f.pressiondynam.value)){
		    	if(porteevalide.test(f.portee.value)){
		    		return true;
		    	}
		    	else {
		    		alert('La valeur de la portee est non valide, Veuillez entrer un nombre');
		    		return false
		    	}
	    	}
	    	else {
    			alert('La valeur de la pression dynamique est non valide, Veuillez entrer un nombre');
    			return false
	    	}
	    }
	    else {
    		alert('La valeur de la pression statique est non valide, Veuillez entrer un nombre');
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
<form action="installationriavalidee.jsp" method="post"  onsubmit="return check(this);" >
		 <fieldset>
		 <legend><b>Installation RIA</b></legend>
		<br>
		<table>
		<tr></tr>
		<tr>
			<td> <label for="emplacement"><i>Emplacement <font color="#ff0000">*</font></i></label></td>
			<td><textarea name="emplacement" rows="5" cols="47" required placeholder="emplacement Poteau Incendie..."></textarea></td></tr>
	  <tr></tr>
	  <tr><td> <label for="typeria"><i>Type RIA <font color="#ff0000">*</font></i></label>	 
			</td> <td> <select name="typeria" class="class_select">

					<%
						for (i = 0; i < service.touslesTypeRIA().size(); i++)
							out.println("<option value=" + service.touslesTypeRIA().get(i).getNumero() + ">"
									+ service.touslesTypeRIA().get(i).getNom() + "</option>");
					%>
				</select>
			</td>
			<td><label for="nomType"><i>Ajout d'un nouveau Type </i></label> <input type="text"
					name="nomType"  placeholder="nom du type..." size="20" class="taille_input_type"/>
		  
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
        	<label for="pressiondynam"><i> Pression Statique  <font color="#ff0000">*</font></i></label>
      	</td>	  
	  	<td>
	  		<input type="text" name="pressiondynam" required placeholder="Pression Dynamique..." size="40" class="taille_input_pressiondynam"/>
	  	</td>
	  </tr>
	 <tr></tr>
	 	 	  <tr>
	  	<td>
        	<label for="portee"><i> Portee  <font color="#ff0000">*</font></i></label>
      	</td>	  
	  	<td>
	  		<input type="text" name="portee" required placeholder="Portee..." size="40" class="taille_input_portee"/>
	  	</td>
	  </tr>
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