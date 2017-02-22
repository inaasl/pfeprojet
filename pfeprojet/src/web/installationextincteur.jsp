<html>
<head>
<title>Ajout d'un Extincteur</title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<script language="JavaScript">
   function check(f){
	    var anneevalide = new RegExp (/^(19|20)[0-9][0-9]$/);
	    
	    if(anneevalide.test(f.annee.value)){
	    	return true;
	    }
	    else {
    		alert('Année non valide !');
    		return false;
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
<form action="installationextincteurvalidee" method="post" onsubmit="return check(this);">
		 <fieldset>
		 <legend><b>Installation extincteur</b></legend>
		<br>
		<table>
		 <tr>
			<td>
                <label for="annee"><i>Annee de fabrication de l'extincteur <font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><input type="text"
					name="annee" required placeholder="Annee..." size="40" class="taille_input_annee"/>
		  </td></tr>
		<tr></tr>
		<tr>
			<td> <label for="emplacement"><i>Emplacement de l'extincteur <font color="#ff0000">*</font></i></label></td>
			<td><textarea name="emplacement" rows="5" cols="47" required placeholder="emplacement extincteur..."></textarea></td></tr>
	  <tr></tr>
	  <% if(ajout.compareTo("0")==0) { %>
	  <tr><td><label for="observations"><i>Observations <font color="#ff0000">*</font></i></label></td><td>
					<textarea name="observations" rows="5" cols="47" required placeholder="observations......"></textarea> 
			</td>
	 </tr>
	 <% } %>
	 <tr></tr>
	 <tr></tr>
	 <tr><td> <label for="typeextincteur"><i>Type de l'extincteur <font color="#ff0000">*</font></i></label>	 
			</td> <td> <select name="typeextincteur" class="class_select">

					<%
						
						for (i = 0; i < service.touslesTypeExtincteur().size(); i++)
							out.println("<option value=" + service.touslesTypeExtincteur().get(i).getNumero() + ">"
									+ service.touslesTypeExtincteur().get(i).getNom() + "</option>");
					%>
				</select>
			</td>
			<td><label for="nomType"><i>Ajout d'un nouveau Type </i></label> <input type="text"
					name="nomType"  placeholder="nom du type..." size="20" class="taille_input_type"/>
		  
		 	 </td>
		</tr>
      <tr></tr>
	  <tr> <td> <label for="marqueextincteur"><i>Marque de l'extincteur <font color="#ff0000">*</font></i></label>
			</td><td><select name="marqueextincteur" class="class_select">
					<%
						for (i = 0; i < service.touteslesMarqueExtincteur().size(); i++)
							out.println("<option value=" + service.touteslesMarqueExtincteur().get(i).getNumero() + ">"
									+ service.touteslesMarqueExtincteur().get(i).getNom() + "</option>");
					%>
			</select></td>
			<td><label for="nomMarque"><i>Ajout d'une nouvelle Marque </i></label> <input type="text"
					name="nomMarque"  placeholder="nom de la marque..." size="20" class="taille_input_marque"/>
		  
		 	 </td>
			</tr></table>
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