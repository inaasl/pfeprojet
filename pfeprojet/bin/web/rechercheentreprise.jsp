<!DOCTYPE HTML>
<html>
<head>
<title>Recherche d'une entreprise</title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<header class="header">
		<a class="logo" href="http://www.desentec.fr/"><img
			src="http://www.desentec.fr/wp-content/uploads/2015/06/logo-site.png">
		</a>
		<p class="head">
		<center>
			<strong>Desentec - Protection incendie</strong>
		</center>
		</p>
	</header>
		<%! int statut;
	%>
	<%
	 if(session.getAttribute("statut")!=null)
	 {
	 session = request.getSession();
	 statut=(Integer)session.getAttribute("statut");	 
	 if(statut==0 || statut==1)
	 {
	%>
	<center>
		<div id="bloc_page">
			<h3>Rechercher une entreprise par nom</h3>
			<form action="rechercheentrepriseresultat">
				<p>
					Nom entreprise: <input type="text" name="nomEntreprise" required
						placeholder="Nom..." />
				</p>
				<input type="submit" value="Valider">
			</form>
		</div>
	</center>
		<%
	 }
	 }
	 else
	 	out.println("<center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\">");
	%>
</body>
</html>