<html>
<head>
<title> Maintenance Corrective : Désenfumage </title>
    <meta charset="UTF-8" />
    <link href="style.css" rel="stylesheet" type="text/css" media="screen and (max-width: 2560px)">
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
		
		
<%! String numBat,conclusion,empla,etat,cartouches;
	int numB,numT,numdesenfumage;
	List<Corrective> interv;
	DesenfumageNaturel Descourant;
	String observationouvrant,nomouvrant,commandeouvrant;
	boolean Etat;
    
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
	etat=request.getParameter("etat");
	cartouches=request.getParameter("cartouches");
	
	
	if(etat.compareTo("oui")==0){
		Etat=true;
	}
	else
		Etat=false;
	
	numBat=String.valueOf(session.getAttribute("numBatiment"));
	numB=Integer.parseInt(numBat);
	
	numdesenfumage=(Integer)session.getAttribute("numdesenfumage");
	
	numT=(Integer)session.getAttribute("numPersonne");
	
	InitialContext ctx = new InitialContext();
	Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	String format = "yyyy-MM-dd";
	java.text.SimpleDateFormat formater = new java.text.SimpleDateFormat(format);
	java.util.Date date = new java.util.Date();
	
	Descourant=(DesenfumageNaturel)service.rechercheOrganeNum(numdesenfumage);
	
	String result = "";
	for(int i=0;i<Descourant.getOuvrants().size();i++){
		observationouvrant = request.getParameter(String.valueOf(i));
		nomouvrant=request.getParameter(String.valueOf(i+200));
		commandeouvrant=request.getParameter(String.valueOf(i+100));
		
		Descourant.getOuvrants().get(i).setCommande(commandeouvrant);
		Descourant.getOuvrants().get(i).setNom(nomouvrant);
		Descourant.getOuvrants().get(i).setObservation(observationouvrant);
		
		//service.MAJOuvrantBD(Descourant.getOuvrants().get(i));
		result=result+observationouvrant+";";
	}
	
	Descourant.setEmplacement(empla);
	Descourant.setCartouches(cartouches);
	Descourant.setMarche(Etat);
	
	conclusion=service.rechercheConclusionMaintenancecorrDesenfumageNaturel(numB);
	interv = (List<Corrective>) session.getAttribute("interv");
	if (interv == null) {
		interv = new ArrayList<Corrective>();
	}
	
	interv.add(service.MaintenanceCorrectiveOrgane(result, Date.valueOf(formater.format(date)), numT, Descourant));

	session.setAttribute("interv", interv);
	
	out.println("<br><center> Maintenance Corrective effectuée avec succès </center>");

	out.println("<center><a href=\"maintenancecorrdesenfumagenaturel.jsp\">Effectuer une nouvelle maintenance corrective </a></center>");
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