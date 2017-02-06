<html>

   <head>
    <title>Ajout d'une Entreprise</title>
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
	<li><a href="deconnexion.jsp">D�connexion</a>
	</li>
	</ul>
 </header>
   <div id="container">
		<%@ page import="java.net.URL" %>
        <%@ page import="java.net.URLConnection" %>
        <%@ page import="java.io.* " %>
		<%@ page import= "ejb.sessions.*"%>
		<%@ page import= "ejb.entites.* "%>
		<%@ page import= "java.util.Collection"%>
		<%@ page import= "java.util.Set"%>
		<%@ page import= "javax.naming.InitialContext"%>
		<%@ page import= "javax.naming.NamingException"%>
		<%@ page import= "java.util.Date"%>
		<%@ page import= "java.text.SimpleDateFormat"%>
		<%@ page import= "java.text.DateFormat"%>
		<%@ page import= "java.util.HashSet"%>


		
        <%! String nomEntreprise,adresseEntreprise,telEntreprise, nomInterlocuteur, adresseemailEntreprise;
        Compte compteajoute;
        
        %>
  
        <%
           		nomEntreprise =request.getParameter("nomEntreprise");
           		adresseEntreprise=request.getParameter("adresse");
           		telEntreprise=request.getParameter("telEntreprise");
           		nomInterlocuteur=request.getParameter("nomInterlocuteur");
           		adresseemailEntreprise=request.getParameter("adresseemailEntreprise");
           		
           		
           		session = request.getSession();
           		InitialContext ctx = new InitialContext();
    			Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
    			ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
    			
    			compteajoute=service.ajouterEntreprise(nomEntreprise,adresseEntreprise,adresseemailEntreprise,telEntreprise,nomInterlocuteur);    			
    			
    			out.println("<center><h3>Ajout effectu� avec succ�s<h3><br>");
    			out.println("<table border=\"1\" cellpadding=\"10\" cellspacing=\"1\" >");
    			out.print("<thead><tr><th> Nom du Client </th><th> Login </th><th> Mot de Passe </th></tr>");
    			out.print("</thead><tbody>");
    			out.print("<tr><td>" + nomEntreprise + "</td><td>  " + compteajoute.getLogin()
    				+ "</td><td>" + compteajoute.getPassword()+"</td></tr></tbody></table>");
    			
    			out.println("</center>");
        %>
        </div>
      <%
	 	}
		 }
	 else
	 	out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
	%>
</body>
</html>