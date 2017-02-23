<html>
<head>
<title> Maintenance Préventive : Désenfumage Naturel </title>
    <meta charset="UTF-8" />
    <link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<header class="header">
    	        <a class="logo" href="http://www.desentec.fr/"><img src="http://www.desentec.fr/wp-content/uploads/2015/06/logo-site.png"> </a>
	<%! int statut;
	 List<Organe> organes;
	 String ajout;
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
		
		
<%! String numBat,conclusion,etat;
	String observationouvrant;
	int numB,numT,numdesenfumage;
	List<Preventive> interv;
	DesenfumageNaturel Desenfumagecourant;
	boolean Etat;
	List<Piece> listP = new ArrayList<Piece>();
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

	etat=request.getParameter("etat");
	
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
	
	Desenfumagecourant=(DesenfumageNaturel)service.rechercheOrganeNum(numdesenfumage);
	
	
	/****-AJOUT OUVRANTS-****/
	String result = "";
	for(int i=0;i<Desenfumagecourant.getOuvrants().size();i++){
		observationouvrant = request.getParameter(String.valueOf(i));
		Desenfumagecourant.getOuvrants().get(i).setObservation(observationouvrant);
	//	service.MAJOuvrantBD(Desenfumagecourant.getOuvrants().get(i));
		result=result+observationouvrant+";";
	}
	/****-FIN AJOUT OUVRANTS-****/
	
	
	/****-AJOUT PIECES-****/ 
	listP=(List<Piece>)session.getAttribute("listP");	
	for(int i=0;i<listP.size();i++){
		listP.get(i).setOrgane(Desenfumagecourant);
	}
	Desenfumagecourant.setPieces(listP);
	listP.clear();
    session.setAttribute("listP",listP);
	/****-FIN AJOUT PIECES-****/
	
	conclusion=service.rechercheConclusionMaintenanceprevdesenfumagenaturel(numB);
	interv = (List<Preventive>)session.getAttribute("interv");
	if (interv == null) {
		interv = new ArrayList<Preventive>();
	}

	
	interv.add(service.MaintenancePreventiveOrgane(Desenfumagecourant, result, "--", numT, Date.valueOf(formater.format(date)), Etat));

	session.setAttribute("interv", interv);
	
	out.println("<br><center> Maintenance Préventive effectuée avec succès </center>");

	out.println("<center><a href=\"maintenanceprevdesenfumagenaturel.jsp\">Effectuer une nouvelle vérification </a></center>");
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