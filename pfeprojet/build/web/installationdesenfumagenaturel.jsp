<html>
<head>
<title>Ajout d'un désenfumage naturel</title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" media="screen and (max-width: 2560px)">
</head>
<body>


<script language="JavaScript">
   function check(f){
	    var quantitevalide = new RegExp (/^[0-9][0-9]*$/);
	    var commandevalide = new RegExp (/^[0-9][0-9]*$/);
	    var ouvrantvalide = new RegExp (/^[0-9][0-9]*$/);
	    
	    
	    if(quantitevalide.test(f.quantite.value)){
	    	if(commandevalide.test(f.commandes.value)){
		    	if(ouvrantvalide.test(f.ouvrants.value)){
			    	
			    		return true
			    }
		    	else {
		    		alert('Valeur de louvrant non valide, Veuillez entrer un nombre !');
		    		return false
		    	}
	    	}
	    	else {
	    		alert('Valeur de la commande non valide, Veuillez entrer un nombre !');
	    		return false
	    	
	            }
	    }
	    else {
    		alert('La valeur de la quantite est non valide, Veuillez entrer un nombre');
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
		if(ajout!=null)
			session.setAttribute("ajout",ajout);
		else {
			ajout=String.valueOf(session.getAttribute("ajout"));
		}

	
	%>
<form action="installationdesenfumagenaturelvalidee" method="post" onsubmit="return check(this);">
		 <fieldset>
		 <legend><b>Installation Désenfumage Naturel</b></legend>
		<br>
		<table>
		 <tr>
			<td>
                <label for="ouvrant"><i>Ouvrant <font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><textarea name="ouvrant" rows="3" cols="47" required placeholder="ouvrant..."></textarea>
		  </td></tr>
		<tr></tr>
		<tr>
			<td>
                <label for="commande"><i>Commande <font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><textarea name="commande" rows="3" cols="47" required placeholder="commande..."></textarea>
		  </td></tr>
		<tr></tr>
		<tr>
			<td> <label for="emplacement"><i>Emplacement <font color="#ff0000">*</font></i></label></td>
			<td><textarea name="emplacement" rows="5" cols="47" required placeholder="emplacement..."></textarea></td></tr>
	  <tr></tr>
	  <% if(ajout.compareTo("0")==0) { %>
	  <tr><td><label for="observations"><i>Observations <font color="#ff0000">*</font></i></label></td><td>
					<textarea name="observations" rows="5" cols="47" required placeholder="observations......"></textarea> 
			</td>
	 </tr>
	 <% } %>
	 <tr></tr>
	 <tr>
			<td>
                <label for="cartouches"><i>Cartouches <font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><textarea name="cartouches" rows="3" cols="47" required placeholder="cartouches..."></textarea>
		  </td></tr>
		<tr></tr>
	 <tr>
			<td>
                <label for="quantite"><i>Quantite <font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><input type="text"
					name="quantite" required placeholder="Quantite..." size="40" class="taille_input_annee"/>
		  </td></tr>
		<tr></tr>
		<tr>
			<td>
                <label for="commandes"><i>Commandes <font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><input type="text"
					name="commandes" required placeholder="Commandes..." size="40" class="taille_input_annee"/>
		  </td></tr>
		<tr></tr>
		<tr>
			<td>
                <label for="ouvrants"><i>Ouvrants <font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><input type="text"
					name="ouvrants" required placeholder="Ouvrants..." size="40" class="taille_input_annee"/>
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