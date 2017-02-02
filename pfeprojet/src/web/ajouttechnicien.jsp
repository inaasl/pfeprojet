<!DOCTYPE HTML>
<html>
<head>
<title>Ajout d'un technicien</title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
   <script language="JavaScript">
   function check(f){
	   
	    var numvalide = new RegExp (/^07[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$/);
	    var mailvalide = new RegExp (/^[a-zA-Z0-9._-]+@[a-z0-9._-]{2,}\.[a-z]{2,4}$/);
	    
	    if(numvalide.test(f.telTechnicien.value)){
	    	if(mailvalide.test(f.adresseemail.value)){
	    		return true;
	    	}
	    	else {
	    		alert('Adresse e-mail non valide !');
	    		return false;
	    	}
	    }
	    else {
	    		if(mailvalide.test(f.adresseemail.value)){
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
		<p class="head">
		<center></center>
		</p>
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
			<br>
	<ul id="menu">
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
	<li><a href="#">Déconnexion</a>
	</li>
	</ul>
	</header>
	<div id="bloc_page">
		<center>
			<h1>Remplir les champs du formulaire</h1>
			<form action="ajouttechnicienvalide" method="post" onsubmit="return check(this);" >
			<fieldset>
                <legend><b>Remplir les champs du formulaire</b></legend>
				<br />
			<table>	
		 <tr> <td>
                <label for="nomTechnicien"><i>Nom du technicien <font color="#ff0000">*</font></i></label>
                </td> <td> 
                <input type="text" name="nomTechnicien" required placeholder="Nom..." size="40" class="taille_input_annee"/>
             </td>
         </tr>  
          <tr></tr>
         <tr> <td>
                <label for="prenomTechnicien"><i>Prenom du technicien <font color="#ff0000">*</font></i></label>
                </td> <td> 
                <input type="text" name="prenomTechnicien" required placeholder="Prenom..." size="40" class="taille_input_annee"/>
               </td>
         </tr>  
          <tr></tr>
         <tr> <td>
				 <label for="adresse"><i>Adresse <font color="#ff0000">*</font></i></label>
			 </td> <td> 
               
                  <textarea name="adresse" rows="5" cols="47" required placeholder="Adresse Technicien..."></textarea> 
             
             </td>
         </tr>  
          <tr></tr>
         <tr> <td>
                <label for="telTechnicien"><i>numéro de téléphone <font color="#ff0000">*</font></i></label>
                <!-- <input type="text" name="telTechnicien" required placeholder="Telephone..." size="20" onblur="Numero_Valid(this)"/>
                
                 -->
               </td> <td> 
                 <input type="text" name="telTechnicien" required placeholder="Telephone..." size="40" class="taille_input_annee" />
               </td>
         </tr>  
          <tr></tr>
         <tr> <td>  
                 <label for="adresseemail"><i>Adresse e-mail <font color="#ff0000">*</font></i></label>
                </td> <td> 
                  <input type="text" name="adresseemail" required placeholder="Adresse e-mail ..." size="40" class="taille_input_annee"/> 
               </td>
         </tr>  
          <tr></tr>
          </table>
               <center> <input type="submit" value="Valider" > </center>
  			</fieldset>
			</form>
			<hr />
		</center>
	</div>
</body>
	<%
	 	}
	 }
	 else
	 	out.println("</header><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\">");
	%>
</html>