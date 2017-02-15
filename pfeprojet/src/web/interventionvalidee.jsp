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
	String conclu,numBat;
	Pdfgenere pdf;
	int numB;
	%>
<%
	session = request.getSession();
	pdf=(Pdfgenere)session.getAttribute("pdf");
	pdf=null;
	InitialContext ctx = new InitialContext();
	Object obj = ctx.lookup(
	"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	
	numBat=String.valueOf(session.getAttribute("numBatiment"));
	numB=Integer.parseInt(numBat);
	
	conclu = request.getParameter("conclusion");
	Interv = (List<Intervention>)session.getAttribute("interv");
	
	for(int i=0;i<Interv.size();i++){
		Interventionajoutee.add(service.ajoutIntervention(numB,Interv.get(i),Interv.get(i).getOrgane(), conclu));
	}
	Interv.clear();
	pdf=service.ajoutpdf(Interventionajoutee);

	out.println("<center><br>Intervention effectuée avec succès");
	session.setAttribute("pdf",pdf);
	if(Interventionajoutee.get(0).getOrgane() instanceof Extincteur){
	out.println("<table><tr><td><input type=\"button\" name=\"Imprimerpdf\" value=\"Imprimer la fiche de l'intervention\"  onclick=\"self.location.href='interventionextincteurpdf.jsp'\"></button></td></tr>");
	}
	else {
		if(Interventionajoutee.get(0).getOrgane() instanceof Pharmacie){
			out.println("<table><tr><td><input type=\"button\" name=\"Imprimerpdf\" value=\"Imprimer la fiche de l'intervention\"  onclick=\"self.location.href='interventionpharmaciepdf.jsp'\"></button></td></tr>");
		}
		else {
			if(Interventionajoutee.get(0).getOrgane() instanceof Coupefeu){
				out.println("<table><tr><td><input type=\"button\" name=\"Imprimerpdf\" value=\"Imprimer la fiche de l'intervention\"  onclick=\"self.location.href='interventioncoupefeupdf.jsp'\"></button></td></tr>");
				}
			else {
				if(Interventionajoutee.get(0).getOrgane() instanceof Poteaux){
					out.println("<table><tr><td><input type=\"button\" name=\"Imprimerpdf\" value=\"Imprimer la fiche de l'intervention\"  onclick=\"self.location.href='interventionpoteauxpdf.jsp'\"></button></td></tr>");
				}
				else {
					if(Interventionajoutee.get(0).getOrgane() instanceof RIA){
						out.println("<table><tr><td><input type=\"button\" name=\"Imprimerpdf\" value=\"Imprimer la fiche de l'intervention\"  onclick=\"self.location.href='interventionriapdf.jsp'\"></button></td></tr>");
					}
					else {
						if(Interventionajoutee.get(0).getOrgane() instanceof Signaletique){
							out.println("<table><tr><td><input type=\"button\" name=\"Imprimerpdf\" value=\"Imprimer la fiche de l'intervention\"  onclick=\"self.location.href='interventionsignaletiquepdf.jsp'\"></button></td></tr>");
						}
						else {
							if(Interventionajoutee.get(0).getOrgane() instanceof Eclairage){
								out.println("<table><tr><td><input type=\"button\" name=\"Imprimerpdf\" value=\"Imprimer la fiche de l'intervention\"  onclick=\"self.location.href='interventioneclairagepdf.jsp'\"></button></td></tr>");
							}
						}
					}
				}
			}
		}
	}
	
	
	Interventionajoutee.clear();
	out.println("<tr><td><input type=\"button\" name=\"Fichebatiment\" value=\"Retour a la fiche du batiment \" onclick=\"self.location.href='fichebatiment.jsp'\"></button></td></tr></table>");
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