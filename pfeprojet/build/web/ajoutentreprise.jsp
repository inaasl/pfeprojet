<!DOCTYPE HTML>
<html>
<head>
<title>Ajout d'une entreprise</title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
   <script language="JavaScript">
   function check(f){
	    var numvalide = new RegExp (/^0(6|7)[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$/);
	    var mailvalide = new RegExp (/^[a-zA-Z0-9._-]+@[a-z0-9._-]{2,}\.[a-z]{2,4}$/);
	    
	    if(numvalide.test(f.telEntreprise.value)){
	    	if(mailvalide.test(f.adresseemailEntreprise.value)){
	    		return true;
	    	}
	    	else {
	    		alert('Adresse e-mail non valide !');
	    		return false;
	    	}
	    }
	    else {
	    		if(mailvalide.test(f.adresseemailEntreprise.value)){
	    			alert('Numéro de téléphone non valide !');
	    			return false;
	    		}
	    		else {
	    			alert('Numéro de téléphone non valide !');
	    			alert('Adresse e-mail non valide !');
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
	<div id="container">
		<center>
			<h1>Remplir les champs du formulaire</h1>
		<form action="ajoutentreprisevalide" method="post" onsubmit="return check(this);">
				<fieldset>
                <legend><b>Remplir les champs du formulaire</b></legend>
				<br />
		<table>	
		 <tr> <td>
                <label for="nomEntreprise"><i>Nom de l'entreprise <font color="#ff0000">*</font></i></label>
              </td> <td> 
                <input type="text" name="nomEntreprise" required placeholder="Nom..."  size="40" class="taille_input_annee"/>
              </td>
         </tr>  
          <tr></tr>
         <tr> <td>
				  <label for="adresse"><i>Adresse de l'entreprise <font color="#ff0000">*</font></i></label>
              </td> <td>
               
                 <textarea name="adresse" rows="5" cols="47" required placeholder="Adresse entreprise..."></textarea>
               </td>
          </tr>  
          <tr></tr>
          <tr><td>
                <label for="telEntreprise"><i>numéro de téléphone <font color="#ff0000">*</font></i></label>
               </td> <td>
                <input type="tel" name="telEntreprise" required placeholder="Telephone..." size="40" class="taille_input_annee"/>
              </td>
          </tr>  
          <tr></tr> 
            <tr><td>   
                 <label for="adresseemailEntreprise"><i> Adresse e-mail <font color="#ff0000">*</font></i></label>
                </td> <td>
                    <input type="text" name="adresseemailEntreprise" required placeholder="Adresse email..." size="40" class="taille_input_annee"/>
               </td>
          </tr>  
          <tr></tr> 
            <tr><td> 
               <label for="nomInterlocuteur"><i>  Nom de l'interlocuteur <font color="#ff0000">*</font></i></label>
                </td> <td> 
                   <input type="text" name="nomInterlocuteur" required placeholder="Nom interlocuteur..."size="40" class="taille_input_annee"/>
              </td>
          </tr>   
          </table>
        <br /><br />
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