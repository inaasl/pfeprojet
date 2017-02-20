<html>
<head>
<title> Ajout d'un poteau incendie </title>
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
		<%@ page import="java.net.URL" %>
        <%@ page import="java.net.URLConnection" %>
        <%@ page import="java.io.* " %>
		<%@ page import= "ejb.sessions.*"%>
		<%@ page import= "ejb.entites.* "%>
		<%@ page import= "javax.naming.InitialContext"%>
		<%@ page import= "javax.naming.NamingException"%>
		<%@ page import= "java.sql.Date"%>
		<%@ page import= "java.text.SimpleDateFormat"%>
		<%@ page import= "java.text.DateFormat"%>
		<%@ page import= "java.util.List"%>
		<%@ page import= "java.util.ArrayList"%>
		
		
<%! String numBat,observ,empla,ajout,diametre,pressionstat,pression60,pression1bar;
	int numB,numT,diametreInt,pressionstatInt,pression60Int,pression1barInt;
	
	List<Installation> interv;
	
	Poteaux Poteauxcourant;

    List<Poteaux> poteaux;
%>
<%
	observ =request.getParameter("observations");
	empla=request.getParameter("emplacement");
	
	diametre=request.getParameter("diametre");
	pressionstat=request.getParameter("pressionstat");
	pression60=request.getParameter("pression60");
	pression1bar=request.getParameter("pression1bar");
	
	if(poteaux==null){
		poteaux=new ArrayList<Poteaux>();
	}
	
	Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
	if(pdf!=null) pdf=null;
	
	numBat=String.valueOf(session.getAttribute("numBatiment"));
	numB=Integer.parseInt(numBat);
	
	numT=(Integer)session.getAttribute("numPersonne");
	
	diametreInt=Integer.parseInt(diametre);
	pressionstatInt=Integer.parseInt(pressionstat);
	pression60Int=Integer.parseInt(pression60);
	pression1barInt=Integer.parseInt(pression1bar);

	InitialContext ctx = new InitialContext();
	Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	
 	String format = "yyyy-MM-dd"; 
	java.text.SimpleDateFormat formater = new java.text.SimpleDateFormat(format);
	java.util.Date date = new java.util.Date();
	
	observ="--";
	Poteauxcourant=service.ajoutPoteaux(numB, empla, observ, diametreInt,pressionstatInt,pression60Int,pression1barInt);
	poteaux.add(Poteauxcourant);
	
	session.setAttribute("organes",poteaux);
	
	out.println("<br><center> Installation effectuée avec succès </center>");

	out.println("<center><a href=\"installationpoteaux.jsp\">Ajout d'un nouveau poteau incendie </a></center>");
	out.println("<br><center><form action=\"interventionvalidee.jsp\"> <input type=\"submit\" value=\"Valider\"></form></center>");
	
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