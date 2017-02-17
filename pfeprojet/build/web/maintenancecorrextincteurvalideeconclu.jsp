<html>
<head>
<title> Maintenance Corrective : Extincteur </title>
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
		
		
<%! String numBat,observ,conclusion,empla,type,marque,annee,etat,type2,marque2;
	int numB,numT,numextincteur,anneeInt;
	List<Corrective> interv;
	Extincteur Extcourant;
	boolean Etat;
    TypeExtincteur Type;
    MarqueExtincteur Marque;
	List<Organe> organes;
	String ajout;
%>
<%
	Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
	pdf=null;
	
	organes=(List<Organe>)session.getAttribute("organes");
	if(organes!=null) organes.clear();
	ajout=String.valueOf(session.getAttribute("ajout"));
	if(ajout!=null) ajout=null;
	
	annee=request.getParameter("annee");
	empla=request.getParameter("emplacement");
	type=request.getParameter("typeextincteur");
	marque=request.getParameter("marqueextincteur");
	observ =request.getParameter("observations");
	etat=request.getParameter("etat");
	type2= request.getParameter("nomType");
	marque2= request.getParameter("nomMarque");
	
	
	if(etat.compareTo("oui")==0){
		Etat=true;
	}
	else
		Etat=false;
	
	numBat=String.valueOf(session.getAttribute("numBatiment"));
	numB=Integer.parseInt(numBat);
	anneeInt=Integer.parseInt(annee);
	numextincteur=(Integer)session.getAttribute("numextincteur");
	
	numT=(Integer)session.getAttribute("numPersonne");
	
	InitialContext ctx = new InitialContext();
	Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	String format = "yyyy-MM-dd";
	java.text.SimpleDateFormat formater = new java.text.SimpleDateFormat(format);
	java.util.Date date = new java.util.Date();
	
	if (type2.compareTo("") != 0){ 
		type=String.valueOf(type2);
		service.ajouttypeextincteur(type);
		Type=service.rechercheTypeExtincteurNom(type);
	}
	else {
		Type=service.rechercheTypeExtincteur(type);
	}
	
	if (marque2.compareTo("") != 0){ 
		marque=String.valueOf(marque2);
		service.ajoutmarqueextincteur(marque);
		Marque=service.rechercheMarqueExtincteurNom(marque);
	}
	else {
		Marque=service.rechercheMarqueExtincteur(marque);
	}
	
	Extcourant=service.rechercheExtincteur(numextincteur);
	Extcourant=service.remplacementextincteur(Extcourant, anneeInt, empla, observ, String.valueOf(Marque.getNumero()), String.valueOf(Type.getNumero()), Etat);
	
	
	conclusion=service.rechercheConclusionMaintenancecorrExtincteur(numB);
	interv = (List<Corrective>) session.getAttribute("interv");
	if (interv == null) {
		interv = new ArrayList<Corrective>();
	}
	
	
	
	
	interv.add(service.MaintenanceCorrectiveOrgane(observ, Date.valueOf(formater.format(date)), numT, Extcourant));

	session.setAttribute("interv", interv);
	
	out.println("<br><center> Maintenance Corrective effectuée avec succès </center>");

	out.println("<center><a href=\"maintenancecorrextincteur.jsp\">Effectuer une nouvelle maintenance corrective </a></center>");
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