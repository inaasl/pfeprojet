<html>
<head>
<title> Maintenance Corrective : Eclairage </title>
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
		
		
<%! String numBat,observ,conclusion,empla,etat,type,marque,typetelecommande,type2,typetelecommande2,marque2,fonctionnement,presence;
	int numB,numT,numeclairage;
	List<Corrective> interv;
	Eclairage Eclairagecourant;
	boolean Etat;
    TypeEclairage Type;
    MarqueEclairage Marque;
    Typetelecommande Typetel;
    boolean presencetelecommande,fonctionnementtelecommande;
%>
<%
	List<Organe> organes=(List<Organe>)session.getAttribute("organes");
	if(organes!=null) organes.clear();
	session.setAttribute("organes",organes);
	
	String ajout=String.valueOf(session.getAttribute("ajout"));
	if(ajout!=null) ajout="0";
	session.setAttribute("ajout",ajout);
	
	Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
	pdf=null;
	session.setAttribute("pdf",pdf);

	
	empla=request.getParameter("emplacement");
	observ =request.getParameter("observations");
	etat=request.getParameter("etat");
	type=request.getParameter("typeeclairage");
	marque=request.getParameter("marqueeclairage");
	typetelecommande=request.getParameter("typetelecommande");
	
	type2= request.getParameter("nomTypeEclairage");
	marque2= request.getParameter("nomMarqueEclairage");
	typetelecommande2= request.getParameter("nomTypeTelecommande");
	
	
	if(etat.compareTo("oui")==0){
		Etat=true;
	}
	else
		Etat=false;
	
	numBat=String.valueOf(session.getAttribute("numBatiment"));
	numB=Integer.parseInt(numBat);
	numeclairage=(Integer)session.getAttribute("numeclairage");
	
	numT=(Integer)session.getAttribute("numPersonne");
	
	fonctionnement=request.getParameter("fonctionnementtelecommande");
	if(fonctionnement.compareTo("oui")==0)
		fonctionnementtelecommande=true;
	else
		fonctionnementtelecommande=false;
	
	presence=request.getParameter("presencetelecommande");
	
	if(presence.compareTo("oui")==0)
		presencetelecommande=true;
	else
		presencetelecommande=false;
	
	InitialContext ctx = new InitialContext();
	Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	String format = "yyyy-MM-dd";
	java.text.SimpleDateFormat formater = new java.text.SimpleDateFormat(format);
	java.util.Date date = new java.util.Date();
	
	if (type2.compareTo("") != 0){ 
		type=String.valueOf(type2);
		service.ajouttypeeclairage(type);
		Type=service.rechercheTypeEclairageNom(type);
	}
	else {
		Type=service.rechercheTypeEclairage(type);
	}
	
 	if (marque2.compareTo("") != 0){ 
		marque=String.valueOf(marque2);
		service.ajoutmarqueeclairage(marque);
		Marque=service.rechercheMarqueEclairageNom(marque);
	}
	else {
		Marque=service.rechercheMarqueEclairage(marque);
	}
	
 	if (typetelecommande2.compareTo("") != 0){ 
		typetelecommande=String.valueOf(typetelecommande2);
		service.ajouttypetelecommande(typetelecommande);
		Typetel=service.rechercheTypeTelecommandeNom(typetelecommande);
	}
	else {
		Typetel=service.rechercheTypeTelecommande(typetelecommande);
	}  
	
	
	Eclairagecourant=(Eclairage)service.rechercheOrganeNum(numeclairage);
	Eclairagecourant=service.remplacementeclairage(Eclairagecourant, empla, observ, Type, Marque, presencetelecommande,fonctionnementtelecommande,Typetel, Etat);
	
	
	conclusion=service.rechercheConclusionMaintenancecorrEclairage(numB);
	interv = (List<Corrective>) session.getAttribute("interv");
	if (interv == null) {
		interv = new ArrayList<Corrective>();
	}
	
	interv.add(service.MaintenanceCorrectiveOrgane(observ, Date.valueOf(formater.format(date)), numT, Eclairagecourant));

	session.setAttribute("interv", interv);
	
	out.println("<br><center> Maintenance Corrective effectuée avec succès </center>");

	out.println("<center><a href=\"maintenancecorreclairage.jsp\">Effectuer une nouvelle maintenance corrective </a></center>");
	out.println(
			"<br><center><form action=\"interventionvalidee.jsp\"><table><tr>"+
	"<td> <p> Conclusion  </td> <td><textarea  name=\"conclusion\" rows=\"5\" cols=\"47\" />"+conclusion+"</textarea></p> <td></tr></table>"+
		"<input type=\"submit\" value=\"Valider\"> </center>");
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