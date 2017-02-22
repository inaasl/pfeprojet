<html>
<head>
<title> Ajout d'un Eclairage</title>
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
		
		
<%! String numTech,numBat,observ,empla,type,marque,typetelecommande,type2,typetelecommande2,marque2,fonctionnement,presence,ajout;
	int numB,numT;
	List<Installation> interv;
	Eclairage Eclairagecourant;
    TypeEclairage Type;
    MarqueEclairage Marque;
    Typetelecommande Typetel;
    List<Eclairage> eclairages;
    boolean presencetelecommande,fonctionnementtelecommande;
%>
<%
	observ =request.getParameter("observations");
	empla=request.getParameter("emplacement");
	type=request.getParameter("typeeclairage");
	marque=request.getParameter("marqueeclairage");
	typetelecommande=request.getParameter("typetelecommande");
	
	type2= request.getParameter("nomTypeEclairage");
	marque2= request.getParameter("nomMarqueEclairage");
	typetelecommande2= request.getParameter("nomTypeTelecommande");
	
	
	Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
	pdf=null;
	
	numBat=String.valueOf(session.getAttribute("numBatiment"));
	if(numBat!=null)numB=Integer.parseInt(numBat);
	
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
	
	ajout=String.valueOf(session.getAttribute("ajout"));
	
	if(ajout.compareTo("0")!=0){
		eclairages=(List<Eclairage>)session.getAttribute("organes");
		if(eclairages==null){
			eclairages=new ArrayList<Eclairage>();
		}
	}
	
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

 	if(ajout.compareTo("0")==0){
		Eclairagecourant=service.ajoutEclairage(numB, empla, observ, Type, Marque,presencetelecommande,fonctionnementtelecommande,Typetel);
		interv = (List<Installation>) session.getAttribute("interv");
		if (interv == null) {
			interv = new ArrayList<Installation>();
		}  
		interv.add(service.InstallationOrgane(observ, Date.valueOf(formater.format(date)), numT, numB, Eclairagecourant));
		
		session.setAttribute("interv", interv);
	}
	else {
		observ="--";
		Eclairagecourant=service.ajoutEclairage(numB, empla, observ, Type, Marque,presencetelecommande,fonctionnementtelecommande,Typetel);
		eclairages.add(Eclairagecourant);
	}
	
	session.setAttribute("organes",eclairages);  
	
	out.println("<br><center> Installation effectuée avec succès </center>");

	out.println("<center><a href=\"installationeclairage.jsp\">Ajout d'un nouvel éclairage</a></center>");
	
	if(ajout.compareTo("0")==0){
	out.println(
			"<br><center><form action=\"interventionvalidee.jsp\"><table><tr>"+
	"<td> <p> Conclusion  </td> <td><textarea  name=\"conclusion\" rows=\"5\" cols=\"47\" required placeholder=\"Conclusion...\"/></textarea></p> <td></tr></table>"+
		"<input type=\"submit\" value=\"Valider\"></form></center>");
	}
	else {
		out.println("<br><center><form action=\"interventionvalidee.jsp\"> <input type=\"submit\" value=\"Valider\"></form></center>");
	}
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