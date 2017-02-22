<html>
<head>
<title>Maintenance Préventive : Alarme Incendie </title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
 <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
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

	<%!String numBat, conclusion;
	int num, i, numT;
	List<Intervention> Interventionajoutee = new ArrayList<Intervention>();
	List<Piece> listP;
	List<Preventive> interv;
	boolean Etat;
	%>

	<%
		session = request.getSession();

		InitialContext ctx = new InitialContext();
		Object obj = ctx.lookup(
				"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
		
		List<Organe> organes=(List<Organe>)session.getAttribute("organes");
		if(organes!=null) organes.clear();
		session.setAttribute("organes",organes);
		
		String ajout=String.valueOf(session.getAttribute("ajout"));
		if(ajout!=null) ajout="0";
		session.setAttribute("ajout",ajout);
		
		List<Preventive> interv=(List<Preventive>)session.getAttribute("interv");

		Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
		pdf=null;
		session.setAttribute("pdf",pdf);
		

 		numBat = String.valueOf(session.getAttribute("numBatiment"));
		session.setAttribute("numBatiment", numBat);
		num = Integer.parseInt(numBat); 
		conclusion = String.valueOf(session.getAttribute("conclusion"));
		//conclusion = request.getParameter("Conclusion");
		
		
		if (interv == null) {
			interv = new ArrayList<Preventive>();
		}
		
		listP=(List<Piece>)session.getAttribute("listP");
		
		String format = "yyyy-MM-dd";
		java.text.SimpleDateFormat formater = new java.text.SimpleDateFormat(format);
		java.util.Date date = new java.util.Date();
		numT=(Integer)session.getAttribute("numPersonne");
		
		for(i=0;i<interv.size();i++){
			Interventionajoutee.add(service.ajoutIntervention(num,interv.get(i),interv.get(i).getOrgane(), conclusion));
			for(int j=0;j<listP.size();j++){
				if(interv.get(i).getOrgane().getNumero()==listP.get(j).getOrgane().getNumero()){
					listP.get(j).setPreventive((Preventive)Interventionajoutee.get(i));
					service.AjoutPieceBD(listP.get(j));
				}
			}
		}
		
		interv.clear();
		session.setAttribute("interv",interv);
		
		pdf=service.ajoutpdf(Interventionajoutee);
		Interventionajoutee.clear();
		out.println("<center><br>Maintenance Préventive effectuée avec succès");
		session.setAttribute("pdf",pdf);
		out.println("<br><table><tr><td><input type=\"button\" name=\"Imprimerpdf\" value=\"Imprimer la fiche de l'intervention\"  onclick=\"self.location.href='interventionpdf.jsp'\"></button></td></tr>");
		out.println("<tr>  </tr><tr><td><input type=\"button\" name=\"Fichebatiment\" value=\"Retour a la fiche du batiment \" onclick=\"self.location.href='fichebatiment.jsp'\"></button></td></tr></table>");
		out.println("</center>");
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