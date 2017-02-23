<html>
<head>
<title> Maintenance Préventive : Poteaux Incendie </title>
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
	int testvoltbatterie,testamperebatterie,testvoltchargeurbatterie;
	String obsoptique,obsionique,obsthermique,obsthermov,obsflamme,obsaspiration,obsreport,obsmanuel,obssonore,obslumineux,observations;
	int testvoltbatterieaes,testamperebatterieaes,testvoltchargeurbatterieaes;
	int numB,numT,numalarme;
	List<Preventive> interv;
	Alarme Alarmecourant;
	List<Alarme> alarmes;
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

	etat=request.getParameter("etat");
	
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
	observations =request.getParameter("observations");
	
	testvoltbatterieaes=Integer.parseInt(request.getParameter("testvoltbatterieaes"));
	testamperebatterieaes=Integer.parseInt(request.getParameter("testamperebatterieaes"));
	testvoltchargeurbatterieaes=Integer.parseInt(request.getParameter("testvoltchargeurbatterieaes"));
	
	if(etat.compareTo("oui")==0){
		Etat=true;
	}
	else
		Etat=false;
	
	
	numBat=String.valueOf(session.getAttribute("numBatiment"));
	numB=Integer.parseInt(numBat);


	numalarme=(Integer)session.getAttribute("numalarme");
	numT=(Integer)session.getAttribute("numPersonne");
		
	InitialContext ctx = new InitialContext();
	Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	
	String format = "yyyy-MM-dd";
	java.text.SimpleDateFormat formater = new java.text.SimpleDateFormat(format);
	java.util.Date date = new java.util.Date();
	
	Alarmecourant=(Alarme)service.rechercheOrganeNum(numalarme);
	
	Alarmecourant=service.verificationAlarme(Alarmecourant,testvoltbatterie,testamperebatterie,testvoltchargeurbatterie,obsoptique,obsionique,
			obsthermique,obsthermov,obsflamme,obsaspiration,obsreport,obsmanuel,
			obssonore,obslumineux,testvoltbatterieaes,testamperebatterieaes,
			testvoltchargeurbatterieaes,observations);
	
	if(alarmes==null){
		alarmes=new ArrayList<Alarme>();
	}
	alarmes.add(Alarmecourant);
	
	conclusion=service.rechercheConclusionMaintenanceprevAlarme(numB);
	interv = (List<Preventive>)session.getAttribute("interv");
	if (interv == null) {
		interv = new ArrayList<Preventive>();
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
	
	
	interv.add(service.MaintenancePreventiveAlarme(Alarmecourant,result,"--",numT, Date.valueOf(formater.format(date)), Etat));

	session.setAttribute("interv", interv);
	session.setAttribute("alarmes",alarmes);
	
	out.println("<br><center> Vérification effectuée avec succès </center>");

	out.println("<center><a href=\"verificationalarme.jsp\">Effectuer une nouvelle vérification </a></center>");
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