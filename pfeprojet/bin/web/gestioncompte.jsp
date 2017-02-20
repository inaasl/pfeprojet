<html>

<head>
<title>Compte</title>
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
	 if(statut==0 || statut==1 || statut==2)
	 {
		 if(statut==0){
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
	<% }
		 if(statut==1){
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
		<% }
			if(statut==2){
		%>
	<ul id="menu">
	<li><a href="accueilclient.jsp">Accueil</a>
	</li>
	<li><a href="#">Gestion des Batiments</a>
	<ul>
		<li><a href="ficheentreprise.jsp">Afficher tous les batiments</a></li>
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
	<%
	}%>
	</header>
	<br><br><br><br><br>
	  <div id="container">
	<%@ page import="java.net.URL"%>
	<%@ page import="java.net.URLConnection"%>
	<%@ page import="java.io.* "%>
	<%@ page import="ejb.sessions.*"%>
	<%@ page import="ejb.entites.* "%>
	<%@ page import="java.util.Collection"%>
	<%@ page import="java.util.Set"%>
	<%@ page import="java.util.List"%>
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.naming.NamingException"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>
	<%@ page import="java.text.DateFormat"%>
	<%!
	 String newpwd,oldpwd,confpwd;
	 List<Integer> liste;
	 String nomEntreprise;
	 List<Entreprise> E;
	 int i;
	 List<Organe> organes;
	 String ajout;
	%>
	<%
		
		InitialContext ctx = new InitialContext();
		Object obj = ctx.lookup(
				"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
		
		Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
		pdf=null;
		
		organes=(List<Organe>)session.getAttribute("organes");
		if(organes!=null) organes.clear();
		ajout=String.valueOf(session.getAttribute("ajout"));
		if(ajout!=null) ajout="0";
		session.setAttribute("ajout",ajout);
		
		newpwd=request.getParameter("nouveaupwd");
		oldpwd=request.getParameter("ancienpwd");
		confpwd=request.getParameter("confnouveaupwd");
	   if(newpwd!=null){
		if(newpwd.compareTo("")!=0){
			try{
			 liste= service.verificationCompte(String.valueOf(session.getAttribute("login")) , oldpwd);
			} catch(CompteInconnuException e){
				 %>
				  <SCRIPT language=javascript>
					   
					       alert("ancien mot de passe incorrect")
					  
					</SCRIPT>
			 <%}
		if(liste!=null){
			if(newpwd.compareTo(confpwd)==0){
				service.modifPassWord(Integer.parseInt(String.valueOf(session.getAttribute("numCompte"))), newpwd);
			 
				out.print("<center>mot de passe modifié</center>");
				if(statut==0){
				out.print("<meta  content=\"3; URL=\"affichertoutesentreprises.jsp>");
				} else if(statut==1){
					out.print("<meta  content=\"3; URL=\"affichertoutesentreprisesjsp>");
				}else
					out.print("<meta  content=\"3; URL=\"ficheentreprise.jsp>");
			}
			else
			{
			%>
				<SCRIPT language=javascript>
				   
				       alert("mot de passe non identique")
				  
				</SCRIPT>
				
		   <% 
	   		}
		 }
		//else{
			  %>
			<!--    <SCRIPT language=javascript>
				   
				       alert("ancien mot de passe incorrect")
				  
				</SCRIPT> -->
			  
		  <%  //}
		}
		else {
		%>
			<SCRIPT language=javascript>
			   
			       alert("veuillez remplir le champs")
			  
			</SCRIPT>
	   <% 
		}
	   }
		else{
			
		out.println("<center>");
		out.println("<br> ");
   %>
   
		
	 <form action="" method="post">
				<fieldset>
                <legend><b>Modifier mon mot de passe</b></legend>
				<br />
		<table>	
		
		 <tr> <td>
                <label for="ancienpwd"><i>Mon ancien mot de passe <font color="#ff0000">*</font></i></label>
              </td> <td> 
                <input type="text" name="ancienpwd" required size="40" class="taille_input_annee"/>
              </td>
         </tr>  
          <tr></tr>
         <tr> <td>
				  <label for="nouveaupwd"><i>Mon nouveau mot de passe <font color="#ff0000">*</font></i></label>
              </td> <td>
               
                 <input type="text" name="nouveaupwd" required size="40" class="taille_input_annee"/>
               </td>
          </tr>  
          <tr></tr>
          <tr><td>
                <label for="confnouveaupwd"><i>Confirmer le nouveau mot de passe <font color="#ff0000">*</font></i></label>
               </td> <td>
                <input type="text" name="confnouveaupwd" required  size="40" class="taille_input_annee"/>
              </td>
          </tr>  
          
          
          </table>
        <br /><br />
        
          <center> <input  type="submit" value="Valider"> </center>
      </fieldset>  
	</form>	
	<% } 
	
	}%>
	</div>
	<%
	 }
	 else
	 	out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
	%>
</body>
</html>