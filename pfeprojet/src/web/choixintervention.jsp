<html>

   <head>
    <title>Intervention -- Choix de l'intervention </title>
    <meta charset="UTF-8" />
    <link href="style.css" rel="stylesheet" type="text/css">
  </head>
<body>
 <header class="header">
    	        <a class="logo" href="http://www.desentec.fr/"><img src="http://www.desentec.fr/wp-content/uploads/2015/06/logo-site.png"> </a>
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
<center>Type de l'intervention
 <FORM action="intervention.jsp">
<fieldset>
    <legend><b>Type de l'intervention</b></legend> <br/>
	<INPUT id="installation" type= "radio" name="choixinterv" value="installation"/> 
	<label for="installation">Installation</label> &nbsp;&nbsp;&nbsp;
	<INPUT id="verification" type= "radio" name="choixinterv" value="verification"/>
	<label for="verification">Vérification</label> &nbsp;&nbsp;&nbsp;
	<INPUT id="maintenanceprev" type= "radio" name="choixinterv" value="maintenanceprev"/> 
	<label for="maintenanceprev">Maintenance Préventive</label> &nbsp;&nbsp;&nbsp;
	<INPUT id="maintenancecorr" type= "radio" name="choixinterv" value="maintenancecorr"/> 
	<label for="maintenancecorr">Maintenance Corrective</label> 
 </fieldset>
<br><br>
<fieldset>
    <legend><b>Type de l'organe de sécurité </b></legend> 
	<br><INPUT id="extincteur" type= "radio" name="choixorg" value="extincteur">
	<label for="extincteur">Extincteur</label> &nbsp;&nbsp;&nbsp;
	<INPUT id="eclairage" type= "radio" name="choixorg" value="eclairage"> 
	<label for="eclairage">Eclairage</label> &nbsp;&nbsp;&nbsp;
	<INPUT id="pharmacie" type= "radio" name="choixorg" value="pharmacie"> 
	<label for="pharmacie">Pharmacie</label> &nbsp;&nbsp;&nbsp;
	<INPUT id="signaletique" type= "radio" name="choixorg" value="signaletique"> 
	<label for="signaletique">Signalétique</label> 
</fieldset>	
	<br><br><center><input type="submit" value="Valider"></center>
</FORM>
</center>
</div>
	<%
	 }
	 }
	 else
	 	out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
	%>
 </body>
 </html>