<html>
<head>
<title> Ajout d'un désenfumage naturel </title>
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
		
		
<%! String numBat,observ,empla,ajout,cartouches,observations;
	int numB,numT;
	List<Installation> interv;
	DesenfumageNaturel Descourant;
    
    List<DesenfumageNaturel> desenfumagenaturel;
    
    List<Ouvrant> ouvrants;
%>
<%
	
	empla=request.getParameter("emplacement");
	cartouches=request.getParameter("cartouches");
	
	Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
	pdf=null;
	
	numBat=String.valueOf(session.getAttribute("numBatiment"));
	numB=Integer.parseInt(numBat);
	
	numT=(Integer)session.getAttribute("numPersonne");
	
	ajout=String.valueOf(session.getAttribute("ajout"));
	
	ouvrants=(List<Ouvrant>)session.getAttribute("ouvrants");
	if(ouvrants==null){
		ouvrants=new ArrayList<Ouvrant>();
	}
	
	
	if(ajout.compareTo("0")!=0){
		desenfumagenaturel=(List<DesenfumageNaturel>)session.getAttribute("organes");
		if(desenfumagenaturel==null){
			desenfumagenaturel=new ArrayList<DesenfumageNaturel>();
		}
	}
	
	InitialContext ctx = new InitialContext();
	Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	
 	String format = "yyyy-MM-dd"; 
	java.text.SimpleDateFormat formater = new java.text.SimpleDateFormat(format);
	java.util.Date date = new java.util.Date();
	observations="";
	for(int i=0;i<ouvrants.size();i++){
		observations=observations+ouvrants.get(i).getObservation()+";";
		out.println("<br> Nom : "+ouvrants.get(i).getNom());
	}
	
	if(ajout.compareTo("0")==0){
		Descourant=service.ajoutDesenfumage(numB, empla, observ, cartouches, ouvrants);
		interv = (List<Installation>) session.getAttribute("interv");
		if (interv == null) {
			interv = new ArrayList<Installation>();
		} 
		interv.add(service.InstallationOrgane(observations, Date.valueOf(formater.format(date)), numT, numB, Descourant));
		session.setAttribute("interv", interv);
	}
	else {
		observ="--";
		Descourant=service.ajoutDesenfumage(numB, empla, observ, cartouches, ouvrants);
		desenfumagenaturel.add(Descourant);
	}
	ouvrants.clear();
	session.setAttribute("ouvrants",ouvrants);
	
	session.setAttribute("organes",desenfumagenaturel);
	
	out.println("<br><center> Installation effectuée avec succès </center>");

	out.println("<center><a href=\"installationdesenfumagenaturel.jsp\">Ajout d'un désenfumage naturel</a></center>");
	
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