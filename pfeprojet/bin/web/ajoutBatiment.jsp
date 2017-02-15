<!DOCTYPE HTML>
<html>
<head>
<title>Ajout d'une entreprise</title>
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
	 	if(statut==0)
	 	{
	%>
	<ul id="menu">
	<li><a href="accueiladministrateur.jsp">Accueil</a>
	</li>
	<li><a href="#">Gestion des Clients</a>
		<ul>
			<li><a href="affichertoutesentreprises.jsp">Afficher tous les clients</a></li>
			<li><a href="ajoutentreprise.jsp">Ajout d'un client</a></li>
		</ul>
	</li>
	<li><a href="#">Gestion des Techniciens</a>
		<ul>
			<li><a href="affichertouslestechniciens.jsp">Afficher tous les techniciens</a></li>
			<li><a href="ajouttechnicien.jsp">Ajout d'un technicien</a></li>
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
	<br><br><br><br><br>
	<div id="container">
		<center>
		<%!String numEntreprise;
	
	     %>
	     <%
	       numEntreprise = request.getParameter("numEntreprise");
	     %>
	     
		<form action="ajoutbatimentvalide" method="post">
				<fieldset>
                <legend><b>Remplir les champs du formulaire</b></legend>
				<br />
		<table>	
		
		 <tr> <td>
                <label for="nomBatiment"><i>Nom du batiment <font color="#ff0000">*</font></i></label>
              </td> <td> 
                <input type="text" name="nomBatiment" required placeholder="Nom..."  size="40" class="taille_input_annee"/>
              </td>
         </tr>  
          <tr></tr>
         <tr> <td>
				  <label for="adresse"><i>Adresse du batiment <font color="#ff0000">*</font></i></label>
              </td> <td>
               
                 <textarea name="adresse" rows="5" cols="47" required placeholder="Adresse ..."></textarea>
               </td>
          </tr>  
          <tr></tr>
          <tr><td>
                <label for="nomresponsable"><i>nom du responsable <font color="#ff0000">*</font></i></label>
               </td> <td>
                <input type="text" name="nomresponsable" required placeholder=Nom..." size="40" class="taille_input_annee"/>
              </td>
          </tr>  
          <tr></tr> 
            <tr><td>   
                 <label for="prenomresponsable"><i> Prenom du responsable <font color="#ff0000">*</font></i></label>
                </td> <td>
                    <input type="text" name="prenomresponsable" required placeholder="Prenom..." size="40" class="taille_input_annee"/>
               </td>
          </tr>  
          
          </table>
        <br /><br />
        <% 
          out.print("<input type=\"hidden\" id=\"idfichebat\" name=\"numEntreprise\" value="+numEntreprise+">");
        %>
          <center>      <input  type="submit" value="Valider"> </center>
   </fieldset>  
			</form>
			<hr />
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