<html>
<head>
<title>Verification d'un Extincteur</title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<header class="header">
		<a class="logo" href="http://www.desentec.fr/"><img
			src="http://www.desentec.fr/wp-content/uploads/2015/06/logo-site.png">
		</a>
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
	<%@ page import="java.net.URL"%>
	<%@ page import="java.net.URLConnection"%>
	<%@ page import="java.io.* "%>
	<%@ page import="ejb.sessions.*"%>
	<%@ page import="ejb.entites.* "%>
	<%@ page import="java.util.List"%>
	<%@ page import="java.util.ArrayList"%>
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.naming.NamingException"%>
	<%@ page import="java.sql.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>
	<%@ page import="java.text.DateFormat"%>

	<%!String numBat,etat, conclusion, observation;
	int num, i, numT;
	List<Extincteur> E;
	Extincteur Extcourant;
	Preventive MP;
	List<Intervention> Interventionajoutee = new ArrayList<Intervention>();
	List<Piece> listP;
	boolean Etat;
	%>

	<%
		session = request.getSession();
		Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
		pdf=null;
		InitialContext ctx = new InitialContext();
		Object obj = ctx.lookup(
				"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;

 		numBat = String.valueOf(session.getAttribute("numBatiment"));
		session.setAttribute("numBatiment", numBat);
		num = Integer.parseInt(numBat); 

		conclusion = request.getParameter("Conclusion");
		
		E=(List<Extincteur>)session.getAttribute("Extincteurs");
		listP=(List<Piece>)session.getAttribute("listP");
		
		String format = "yyyy-MM-dd";
		java.text.SimpleDateFormat formater = new java.text.SimpleDateFormat(format);
		java.util.Date date = new java.util.Date();
		numT=(Integer)session.getAttribute("numPersonne");
		for (i=0;i <E.size(); i++) {
				observation = request.getParameter(String.valueOf(i));
				etat = request.getParameter(String.valueOf(i+100));
				if(etat!=null){
					if(etat.compareTo("oui")==0)
						Etat=false;
				}
				else 
					Etat=true;
				MP=service.MaintenancePreventiveOrgane(E.get(i), observation, conclusion, numT, Date.valueOf(formater.format(date)),Etat);
 				for(int j=0;j<listP.size();j++){
					if(MP.getOrgane().getNumero()==listP.get(j).getOrgane().getNumero()){
						listP.get(j).setPreventive(MP);
						service.AjoutPieceBD(listP.get(j));
					}
				}
 				Interventionajoutee.add(MP);
		}
		pdf=service.ajoutpdf(Interventionajoutee);
		Interventionajoutee.clear();
		out.println("<center><br>Maintenance Préventive effectuée avec succès");
		session.setAttribute("pdf",pdf);
		out.println("<table><tr><td><input type=\"button\" name=\"Imprimerpdf\" value=\"Imprimer la fiche de l'intervention\"  onclick=\"self.location.href='interventionextincteurpdf.jsp'\"></button></td></tr>");
		out.println("<tr><td><input type=\"button\" name=\"Fichebatiment\" value=\"Retour a la fiche du batiment \" onclick=\"self.location.href='fichebatiment.jsp'\"></button></td></tr></table>");
		out.println("</center>");
		E.clear();
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