<html>
<head>
<title> Ajout RIA </title>
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
		
		
<%! String numBat,observ,empla,ajout,type,type2,pressionstat,pressiondynam,portee;
	int numB,numT,pressionstatInt,pressiondynamInt,porteeInt;
	
	List<Installation> interv;
	TypeRia Type;
	RIA Riacourant;

    List<RIA> ria;
%>
<%
	observ =request.getParameter("observations");
	empla=request.getParameter("emplacement");
	type=request.getParameter("typeria");
	type2= request.getParameter("nomType");

	pressionstat=request.getParameter("pressionstat");
	pressiondynam=request.getParameter("pressiondynam");
	portee= request.getParameter("portee");
	
	if(ria==null){
		ria=new ArrayList<RIA>();
	}
	
	pressionstatInt=Integer.parseInt(pressionstat);
	pressiondynamInt=Integer.parseInt(pressiondynam);
	porteeInt=Integer.parseInt(portee);
	
	Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
	if(pdf!=null) pdf=null;
	
	numBat=String.valueOf(session.getAttribute("numBatiment"));
	numB=Integer.parseInt(numBat);
	
	numT=(Integer)session.getAttribute("numPersonne");
	

	InitialContext ctx = new InitialContext();
	Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	
	if (type2.compareTo("") != 0){ 
		type=String.valueOf(type2);
		service.ajouttyperia(type);
		Type=service.rechercheTypeRiaNom(type);
	}
	else {
		Type=service.rechercheTypeRia(type);
	}
	
 	String format = "yyyy-MM-dd"; 
	java.text.SimpleDateFormat formater = new java.text.SimpleDateFormat(format);
	java.util.Date date = new java.util.Date();
	
	observ="--";
	Riacourant=service.ajoutRia(numB, empla, observ, Type, pressionstatInt,pressiondynamInt,porteeInt);
	ria.add(Riacourant);
	
	session.setAttribute("organes",ria);
	
	out.println("<br><center> Installation effectuée avec succès </center>");

	out.println("<center><a href=\"installationria.jsp\">Ajout d'un nouveau RIA </a></center>");
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