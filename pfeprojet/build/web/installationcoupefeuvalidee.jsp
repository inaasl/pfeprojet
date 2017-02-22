<html>
<head>
<title> Ajout d'une Porte Coupe-feu</title>
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
		
		
<%! String numBat,observ,empla, type,type2,ajout;
	int numB,numT;
	List<Installation> interv;
	Coupefeu Coupefeucourant;
    List<Coupefeu> coupesfeu;
    TypeCoupefeu Type;
%>
<%
	observ =request.getParameter("observations");
	empla=request.getParameter("emplacement");
	type=request.getParameter("typecoupefeu");
	type2= request.getParameter("nomType");


	
	Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
	pdf=null;
	
	numBat=String.valueOf(session.getAttribute("numBatiment"));
	numB=Integer.parseInt(numBat);
	
	numT=(Integer)session.getAttribute("numPersonne");

	
	ajout=String.valueOf(session.getAttribute("ajout"));
	
	if(ajout.compareTo("0")!=0){
		coupesfeu=(List<Coupefeu>)session.getAttribute("organes");
		if(coupesfeu==null){
			coupesfeu=new ArrayList<Coupefeu>();
		}
	}
	
	InitialContext ctx = new InitialContext();
	Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	
	if (type2.compareTo("") != 0){ 
		type=String.valueOf(type2);
		service.ajouttypecoupefeu(type);
		Type=service.rechercheTypeCoupefeuNom(type);
	}
	else {
		Type=service.rechercheTypeCoupefeu(type);
	}
	
 	String format = "yyyy-MM-dd"; 
	java.text.SimpleDateFormat formater = new java.text.SimpleDateFormat(format);
	java.util.Date date = new java.util.Date();
	
	if(ajout.compareTo("0")==0){
		Coupefeucourant=service.ajoutCoupefeu(numB, empla, observ,Type);
		interv = (List<Installation>) session.getAttribute("interv");
		if (interv == null) {
			interv = new ArrayList<Installation>();
		} 
		interv.add(service.InstallationOrgane(observ, Date.valueOf(formater.format(date)), numT, numB, Coupefeucourant));
		
		session.setAttribute("interv", interv);
	}
	else {
		observ="--";
		Coupefeucourant=service.ajoutCoupefeu(numB, empla, observ,Type);
		coupesfeu.add(Coupefeucourant);
	}
	
	session.setAttribute("organes",coupesfeu);
	
	out.println("<br><center> Installation effectuée avec succès </center>");

	out.println("<center><a href=\"installationcoupefeu.jsp\">Ajout d'une nouvelle porte coupe-feu</a></center>");
	
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