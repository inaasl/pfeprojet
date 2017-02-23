<html>
<head>
<title> Maintenance Corrective : Alarme Incendie </title>
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
		
		
<%! String numBat,etat,emplacement, marquealarme,nomMarquealarme,typealarme,nomTypealarme,ajout;
	int annee;
	String typebatterie,nomTypebatterie;
	int nombrebatterie,xbatterie,ybatterie,hbatterie,testvoltbatterie,testamperebatterie,testvoltchargeurbatterie;
	String obsoptique,obsionique,obsthermique,obsthermov,obsflamme,obsaspiration,obsreport,obsmanuel,obssonore,obslumineux;
	int nombreoptique,nombreionique,nombrethermique,nombrethermov,nombreflamme,nombreaspiration,nombrereport,nombremanuel,nombresonore,nombrelumineux;
	String typeaes,nomTypeaes,typebatterieaes,nomTypebatterieaes,observations;
	int nombreaes,nombrebatterieaes,xbatterieaes,ybatterieaes,hbatterieaes,testvoltbatterieaes,testamperebatterieaes,testvoltchargeurbatterieaes;
	int numB,numT,numalarme;
	List<Corrective> interv;
	Alarme Alarmecourant;
	boolean Etat;
	String conclusion;
   
	
	
	TypeAlarme Typealarme;
	MarqueAlarme Marquealarme;
	
	TypeBatterie Typebatterie;
	
	TypeBatterieAES Typebatterieaes;
	
	TypeAES Typeaes;

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
	
	InitialContext ctx = new InitialContext();
	Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	
	etat=request.getParameter("etat");

	if(etat.compareTo("oui")==0){
		Etat=true;
	}
	else
		Etat=false;

	emplacement =request.getParameter("emplacement");
	nomMarquealarme =request.getParameter("nomMarquealarme");
	marquealarme =request.getParameter("marquealarme");
	typealarme =request.getParameter("typealarme");
	nomTypealarme =request.getParameter("nomTypealarme");
	
	if (nomMarquealarme.compareTo("") != 0){ 
		marquealarme=String.valueOf(nomMarquealarme);
		service.ajoutmarquealarme(marquealarme);
		Marquealarme=service.rechercheMarqueAlarmeNom(marquealarme);
	}
	else {
		Marquealarme=service.rechercheMarqueAlarme(marquealarme);
	}
	
	if (nomTypealarme.compareTo("") != 0){ 
		typealarme=String.valueOf(nomTypealarme);
		service.ajouttypealarme(typealarme);
		Typealarme=service.rechercheTypeAlarmeNom(typealarme);
	}
	else {
		Typealarme=service.rechercheTypeAlarme(typealarme);
	}
	
	annee=Integer.parseInt(request.getParameter("annee"));
	
	typebatterie =request.getParameter("typebatterie");
	nomTypebatterie =request.getParameter("nomTypebatterie");

	if (nomTypebatterie.compareTo("") != 0){ 
		typebatterie=String.valueOf(nomTypebatterie);
		service.ajouttypebatterie(typebatterie);
		Typebatterie=service.rechercheTypeBatterieNom(typebatterie);
	}
	else {
		Typebatterie=service.rechercheTypeBatterie(typebatterie);
	}
	
	nombrebatterie=Integer.parseInt(request.getParameter("nombrebatterie"));
	xbatterie=Integer.parseInt(request.getParameter("xbatterie"));
	ybatterie=Integer.parseInt(request.getParameter("ybatterie"));
	hbatterie=Integer.parseInt(request.getParameter("hbatterie"));
	testvoltbatterie=Integer.parseInt(request.getParameter("testvoltbatterie"));
	testamperebatterie=Integer.parseInt(request.getParameter("testamperebatterie"));
	testvoltchargeurbatterie=Integer.parseInt(request.getParameter("testvoltchargeurbatterie"));
	
	obsoptique =request.getParameter("obsoptique");
	obsionique =request.getParameter("obsionique");
	obsthermique =request.getParameter("obsthermique");
	obsthermov =request.getParameter("obsthermov");
	obsflamme =request.getParameter("obsflamme");
	obsaspiration =request.getParameter("obsaspiration");
	obsreport =request.getParameter("obsreport");
	obsmanuel =request.getParameter("obsmanuel");
	obssonore =request.getParameter("obssonore");
	obslumineux =request.getParameter("obslumineux");
	
	nombreoptique=Integer.parseInt(request.getParameter("nombreoptique"));
	nombreionique=Integer.parseInt(request.getParameter("nombreionique"));
	nombrethermique=Integer.parseInt(request.getParameter("nombrethermique"));
	nombrethermov=Integer.parseInt(request.getParameter("nombrethermov"));
	nombreflamme=Integer.parseInt(request.getParameter("nombreflamme"));
	nombreaspiration=Integer.parseInt(request.getParameter("nombreaspiration"));
	nombrereport=Integer.parseInt(request.getParameter("nombrereport"));
	nombremanuel=Integer.parseInt(request.getParameter("nombremanuel"));
	nombresonore=Integer.parseInt(request.getParameter("nombresonore"));
	nombrelumineux=Integer.parseInt(request.getParameter("nombrelumineux"));
	
	typeaes =request.getParameter("typeaes");
	nomTypeaes=request.getParameter("nomTypeaes");
	
	if (nomTypeaes.compareTo("") != 0){ 
		typeaes=String.valueOf(nomTypeaes);
		service.ajouttypeaes(typeaes);
		Typeaes=service.rechercheTypeaesNom(typeaes);
	}
	else {
		Typeaes=service.rechercheTypeaes(typeaes);
	}
	
	observations =request.getParameter("observations");
	
	typebatterieaes =request.getParameter("typebatterieaes");
	nomTypebatterieaes =request.getParameter("nomTypebatterieaes");
	
	if (nomTypebatterieaes.compareTo("") != 0){ 
		typebatterieaes=String.valueOf(nomTypebatterieaes);
		service.ajouttypebatterieaes(typebatterieaes);
		Typebatterieaes=service.rechercheTypeBatterieaesNom(typebatterieaes);
	}
	else {
		Typebatterieaes=service.rechercheTypeBatterieaes(typebatterieaes);
	}
	
	nombreaes=Integer.parseInt(request.getParameter("nombreaes"));
	nombrebatterieaes=Integer.parseInt(request.getParameter("nombrebatterieaes"));
	xbatterieaes=Integer.parseInt(request.getParameter("xbatterieaes"));
	ybatterieaes=Integer.parseInt(request.getParameter("ybatterieaes"));
	hbatterieaes=Integer.parseInt(request.getParameter("hbatterieaes"));
	testvoltbatterieaes=Integer.parseInt(request.getParameter("testvoltbatterieaes"));
	testamperebatterieaes=Integer.parseInt(request.getParameter("testamperebatterieaes"));
	testvoltchargeurbatterieaes=Integer.parseInt(request.getParameter("testvoltchargeurbatterieaes"));
	
	
/* 	String observationgroupee=service.ObservationsAlarme(observations,obsoptique,obsionique,obsthermique, obsthermov,obsflamme,
			obsaspiration, obsreport, obsmanuel,obssonore,obslumineux);
	
	String Test = service.testAlarme(testvoltbatterie,testamperebatterie,testvoltchargeurbatterie,testvoltbatterieaes,
			testamperebatterieaes, testvoltchargeurbatterieaes);
	
	observationgroupee = observationgroupee + Test; */
	
	
	numBat=String.valueOf(session.getAttribute("numBatiment"));
	numB=Integer.parseInt(numBat);
	numalarme=(Integer)session.getAttribute("numalarme");
	
	numT=(Integer)session.getAttribute("numPersonne");
	
	String format = "yyyy-MM-dd";
	java.text.SimpleDateFormat formater = new java.text.SimpleDateFormat(format);
	java.util.Date date = new java.util.Date();
	
	Alarmecourant=(Alarme)service.rechercheOrganeNum(numalarme);
	
	Alarmecourant=service.remplacementalarme(Alarmecourant,emplacement,observations,Marquealarme,Typealarme,annee,nombrebatterie,xbatterie,ybatterie,
			hbatterie,Typebatterie,testvoltbatterie,testamperebatterie,testvoltchargeurbatterie,nombreoptique,
			obsoptique,nombreionique,obsionique,nombrethermique,obsthermique,nombrethermov,obsthermov,
			nombreflamme,obsflamme,nombreaspiration,obsaspiration,nombrereport,obsreport,nombremanuel,obsmanuel,
			nombresonore,obssonore,nombrelumineux,obslumineux,nombreaes,Typeaes, nombrebatterieaes, xbatterieaes,
			 ybatterieaes, hbatterieaes,Typebatterieaes , testvoltbatterieaes, testamperebatterieaes,  testvoltchargeurbatterieaes, Etat );
	
	
	conclusion=service.rechercheConclusionMaintenancecorrAlarme(numB);
	interv = (List<Corrective>) session.getAttribute("interv");
	if (interv == null) {
		interv = new ArrayList<Corrective>();
	}
	String result = "";
	result = result + observations+";";
	result = result + obsoptique +";";
	result = result + obsionique + ";";
	result = result + obsthermique + ";";
	result = result + obsthermov + ";";
	result = result + obsflamme + ";";
	result = result + obsaspiration + ";";
	result = result + obsreport + ";";
	result = result + obsmanuel + ";";
	result = result + obssonore + ";";
	result = result + obslumineux + ";"; 
	
	result = result + String.valueOf(testvoltbatterie) + ";"; 
	result = result + String.valueOf(testamperebatterie) + ";"; 
	result = result + String.valueOf(testvoltchargeurbatterie) + ";"; 
	result = result +  String.valueOf(testvoltbatterieaes) + ";"; 
	result = result + String.valueOf(testamperebatterieaes) + ";"; 
	result = result + String.valueOf(testvoltchargeurbatterieaes) + ";";
	
	interv.add(service.MaintenanceCorrectiveOrgane(result, Date.valueOf(formater.format(date)), numT, Alarmecourant));

	session.setAttribute("interv", interv);
	
	out.println("<br><center> Maintenance Corrective effectuée avec succès </center>");

	out.println("<center><a href=\"maintenancecorralarme.jsp\">Effectuer une nouvelle maintenance corrective </a></center>");
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