<html>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.io.* "%>
<%@ page import="ejb.sessions.*"%>
<%@ page import="ejb.entites.* "%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.NamingException"%>
	<%@ page import= "java.util.List"%>
<head>
<title></title>
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
	
<%!String typeinterv, typeorg, numeroB;
List<Intervention> interv;
List<Organe> organes;
String ajout;
%>
<%
	interv=(List<Intervention>)session.getAttribute("interv");
	if(interv!=null) interv.clear();
	Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
	pdf=null;
	organes=(List<Organe>)session.getAttribute("organes");
	if(organes!=null) organes.clear();
	ajout=String.valueOf(session.getAttribute("ajout"));
	if(ajout!=null) ajout=null;
	typeinterv = request.getParameter("choixinterv");

	typeorg = request.getParameter("choixorg");
	
	if(typeinterv.compareTo("installation") == 0){
		if(typeorg.compareTo("extincteur") == 0){
			out.println("<meta http-equiv=\"refresh\" content=\"1; URL=installationextincteur.jsp?ajout=0\">");
		}
		else {
			if(typeorg.compareTo("eclairage") == 0){
				out.println("<meta http-equiv=\"refresh\" content=\"1; URL=installationeclairage.jsp\">");
			}
			else {
				if(typeorg.compareTo("pharmacie") == 0){
					out.println("<meta http-equiv=\"refresh\" content=\"1; URL=installationpharmacie.jsp?ajout=0\">");
				}
				else {
					if(typeorg.compareTo("signaletique") == 0){
						out.println("<meta http-equiv=\"refresh\" content=\"1; URL=installationsignaletique.jsp\">");
					}
					else {
						if(typeorg.compareTo("coupefeu") == 0){
							out.println("<meta http-equiv=\"refresh\" content=\"1; URL=installationcoupefeu.jsp\">");
						}
					}
				}
			}
		}
	}
	else {
		if (typeinterv.compareTo("verification") == 0){
			if(typeorg.compareTo("extincteur") == 0){
				out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationextincteur.jsp\">");
			}
			else {
				if(typeorg.compareTo("eclairage") == 0){
					out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationeclairage.jsp\">");
				}
				else {
					if(typeorg.compareTo("pharmacie") == 0){
						out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationpharmacie.jsp\">");
					}
					else {
						if(typeorg.compareTo("ria") == 0){
							out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationria.jsp\">");
						}
						else {
							if(typeorg.compareTo("poteaux") == 0){
								out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationpoteaux.jsp\">");
							}
							else {
								if(typeorg.compareTo("coupefeu") == 0){
									out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationcoupefeu.jsp\">");
								}
							}
						}
					}
				}
			}
		}
		else {
			if (typeinterv.compareTo("maintenancecorr") == 0) {
				if(typeorg.compareTo("extincteur") == 0){
					out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrextincteur.jsp\">");
				}
				else {
					if(typeorg.compareTo("eclairage") == 0){
						out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorreclairage.jsp\">");
					}
					else {
						if(typeorg.compareTo("pharmacie") == 0){
							out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrpharmacie.jsp\">");
						}
						else {
							if(typeorg.compareTo("ria") == 0){
								out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrria.jsp\">");
							}
							else {
								if(typeorg.compareTo("poteaux") == 0){
									out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrpoteaux.jsp\">");
								}
								else {
									if(typeorg.compareTo("coupefeu") == 0){
										out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrcoupefeu.jsp\">");
									}
								}
							}
						}
					}
				}
			}
			else {
				if (typeinterv.compareTo("maintenanceprev") == 0){
					if(typeorg.compareTo("extincteur") == 0){
						out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenanceprevextincteur.jsp\">");
					}
					else {
						if(typeorg.compareTo("ria") == 0){
							out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenanceprevria.jsp\">");
						}
						else {
							if(typeorg.compareTo("poteaux") == 0){
								out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenanceprevpoteaux.jsp\">");
							}
							else {
								if(typeorg.compareTo("coupefeu") == 0){
									out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenanceprevcoupefeu.jsp\">");
								}
							}
						}
					}
				}
			}
		}
	}
 }
}
	 else
	 	out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
%>
</body>
</html>