<html>
<head>
<title> Ajout d'un Extincteur</title>
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
		<li><a href="deconnexion.jsp">D�connexion</a>
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
		
		
<%! String numBat, annee,observ,empla, type,marque,type2,marque2,ajout;
	int numB,numT,anneeInt;
	List<Installation> interv;
	Extincteur Extcourant;
    TypeExtincteur Type;
    MarqueExtincteur Marque;
    List<Extincteur> extincteurs;
%>
<%
	annee =request.getParameter("annee");
	observ =request.getParameter("observations");
	empla=request.getParameter("emplacement");
	type=request.getParameter("typeextincteur");
	marque=request.getParameter("marqueextincteur");
	type2= request.getParameter("nomType");
	marque2= request.getParameter("nomMarque");
	
	
	Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
	pdf=null;
	
	numBat=String.valueOf(session.getAttribute("numBatiment"));
	numB=Integer.parseInt(numBat);
	
	numT=(Integer)session.getAttribute("numPersonne");
	
	anneeInt=Integer.parseInt(annee);
	
	ajout=String.valueOf(session.getAttribute("ajout"));
	
	if(ajout.compareTo("0")!=0){
		extincteurs=(List<Extincteur>)session.getAttribute("organes");
		if(extincteurs==null){
			extincteurs=new ArrayList<Extincteur>();
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
	
	if(ajout.compareTo("0")==0){
		Extcourant=service.ajoutExtincteur(numB, anneeInt, empla, observ, String.valueOf(Marque.getNumero()), String.valueOf(Type.getNumero()));
		interv = (List<Installation>) session.getAttribute("interv");
		if (interv == null) {
			interv = new ArrayList<Installation>();
		} 
		interv.add(service.InstallationOrgane(observ, Date.valueOf(formater.format(date)), numT, numB, Extcourant));
		
		session.setAttribute("interv", interv);
	}
	else {
		observ="--";
		Extcourant=service.ajoutExtincteur(numB, anneeInt, empla, observ, String.valueOf(Marque.getNumero()), String.valueOf(Type.getNumero()));
		extincteurs.add(Extcourant);
	}
	
	session.setAttribute("organes",extincteurs);
	
	out.println("<br><center> Installation effectu�e avec succ�s </center>");

	out.println("<center><a href=\"installationextincteur.jsp\">Ajout d'un nouvel extincteur</a></center>");
	
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