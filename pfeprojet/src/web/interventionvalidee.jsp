<html>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.io.* "%>
<%@ page import="ejb.sessions.*"%>
<%@ page import="ejb.entites.* "%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<head>
<title></title>
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
		<li><a href="#">Déconnexion</a>
		</li>
		</ul>
	</header>
  <div id="container">
	<%!
	List<Intervention> Interv;
	List<Intervention>Interventionajoutee=new ArrayList<Intervention>();
	String conclu,numBat,ajout;
	Pdfgenere pdf;
	int numB;
	List<Organe> organes;
	%>
<%
	session = request.getSession();

	pdf=(Pdfgenere)session.getAttribute("pdf");
	pdf=null;
	session.setAttribute("pdf",pdf);

	
	InitialContext ctx = new InitialContext();
	Object obj = ctx.lookup(
	"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	
	numBat=String.valueOf(session.getAttribute("numBatiment"));
	numB=Integer.parseInt(numBat);
	
	ajout=String.valueOf(session.getAttribute("ajout"));
	if(ajout==null){
		ajout="0";
	}
	if(ajout.compareTo("0")==0){
		conclu = request.getParameter("conclusion");
		Interv = (List<Intervention>)session.getAttribute("interv");
		
		for(int i=0;i<Interv.size();i++){
			Interventionajoutee.add(service.ajoutIntervention(numB,Interv.get(i),Interv.get(i).getOrgane(), conclu));
		}
		Interv.clear();
		session.setAttribute("Interv",Interv);
		pdf=service.ajoutpdf(Interventionajoutee);
		session.setAttribute("pdf",pdf);
		out.println("<center><br>Intervention effectuée avec succès");
		out.println("<table><tr><td><input type=\"button\" name=\"Imprimerpdf\" value=\"Imprimer la fiche de l'intervention\"  onclick=\"self.location.href='interventionpdf.jsp'\"></button></td></tr>");
		Interventionajoutee.clear();
		out.println("<tr><td><input type=\"button\" name=\"Fichebatiment\" value=\"Retour a la fiche du batiment \" onclick=\"self.location.href='fichebatiment.jsp'\"></button></td></tr></table>");
		out.println("</center>");
	}
	else {
		organes=(List<Organe>)session.getAttribute("organes");
		service.ajoutOrgane(organes);
		organes.clear();
		session.setAttribute("organes",organes);
		if(ajout.compareTo("1")==0){
			out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationextincteur.jsp\">");
		}
		else {
			if(ajout.compareTo("2")==0){
				out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrextincteur.jsp\">");
			}
			else{
				if (ajout.compareTo("3")==0) {
				out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenanceprevextincteur.jsp\">");
				}
				else {
					if(ajout.compareTo("4")==0) {
						out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationpharmacie.jsp\">");
					}
					else {
						if(ajout.compareTo("5")==0) {
							out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrpharmacie.jsp\">");
						}
						else {
							if(ajout.compareTo("10")==0) {
								out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationcoupefeu.jsp\">");
							}
							else {
								if(ajout.compareTo("11")==0) {
									out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrcoupefeu.jsp\">");
								}
								else {
									if(ajout.compareTo("12")==0) {
										out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenanceprevcoupefeu.jsp\">");
									}
									else {
										if(ajout.compareTo("16")==0) {
											out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationpoteaux.jsp\">");
										}
										else {
											if(ajout.compareTo("17")==0) {
												out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrpoteaux.jsp\">");
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
		ajout="0";
		session.setAttribute("ajout",ajout);
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