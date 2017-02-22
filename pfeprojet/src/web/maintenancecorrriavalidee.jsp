<html>
<head>
<title>Maintenance Corrective : RIA </title>
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
			int i,num,numria;%>
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
			
			numria = Integer.parseInt(request.getParameter("numria"));
			observation=service.rechercheObservationMaintenancecorr(numria);
			RIA R =(RIA)service.rechercheOrganeNum(numria);
			session.setAttribute("numria",numria);
		%>
<form action="maintenancecorrriavalideeconclu.jsp" method="post">
		<fieldset>
		 <legend><b>Maintenance Corrective</b></legend>
		<br>
		<table>
		<tr></tr>
		<tr>
			<td> <label for="emplacement"><i>Emplacement <font color="#ff0000">*</font></i></label></td>
			<td><textarea name="emplacement" rows="5" cols="47" required placeholder="emplacement Poteau Incendie..."><%out.println(R.getEmplacement()); %></textarea></td></tr>
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
	  		<input type="text" name="pressionstat" required value="<%out.println(R.getPressionStatique());%>" size="40" class="taille_input_pressionstat"/>
	  	</td>
	  </tr>
	 <tr></tr>
	 	 	  <tr>
	  	<td>
        	<label for="pressiondynam"><i> Pression Statique  <font color="#ff0000">*</font></i></label>
      	</td>	  
	  	<td>
	  		<input type="text" name="pressiondynam" required value="<%out.println(R.getPressionDynamique());%>" size="40" class="taille_input_pressiondynam"/>
	  	</td>
	  </tr>
	 <tr></tr>
	 	 	  <tr>
	  	<td>
        	<label for="portee"><i> Portee  <font color="#ff0000">*</font></i></label>
      	</td>	  
	  	<td>
	  		<input type="text" name="portee" required value="<%out.println(R.getPortee());%>" size="40" class="taille_input_portee"/>
	  	</td>
	  </tr>
	  	  <tr></tr>
	  <tr><td><label for="observations"><i>Observations <font color="#ff0000">*</font></i></label></td><td>
			<textarea name="observations" rows="5" cols="47" required placeholder="observations......"><%out.println(observation);%></textarea> 
	  </td></tr>
	  <tr></tr>
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