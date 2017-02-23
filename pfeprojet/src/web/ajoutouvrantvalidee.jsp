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
<title>Ajout d'ouvrants</title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="datatables.css" />
    <script type="text/javascript" src="jquery.dataTables.js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.12/datatables.min.css"/>
 
    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.12/datatables.min.js"></script>

    <script type="text/javascript" charset="utf-8">
     $(document).ready(function(){
     $('#datatables').dataTable();
    
     })
    </script>
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
	List<Ouvrant> ouvrants;
	Pdfgenere pdf;
	String ajout;
	int numdesenfumage;
	DesenfumageNaturel D;
	
	%>
<%
	session = request.getSession();
	InitialContext ctx = new InitialContext();
	Object obj = ctx.lookup(
	"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	
	pdf=(Pdfgenere)session.getAttribute("pdf");
	pdf=null;
	session.setAttribute("pdf",pdf);
	
	numdesenfumage=(Integer)session.getAttribute("numdesenfumage");
	DesenfumageNaturel D =(DesenfumageNaturel)service.rechercheOrganeNum(numdesenfumage);
	
	ouvrants=(List<Ouvrant>)session.getAttribute("ouvrants");
	
	for(int i=0;i<ouvrants.size();i++){
		ouvrants.get(i).setDesenfumagenaturel(D);
		out.println("<br> Nom :"+ouvrants.get(i).getNom());
 		service.MAJOuvrantBD(ouvrants.get(i)); 
	}
	
	ajout=String.valueOf(session.getAttribute("ajout"));
	if(ajout==null){
		ajout="0";
	}
	
	if(ajout.compareTo("18")==0) {
		out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationdesenfumagevalidee.jsp?numdesenfumage="+numdesenfumage+"\">");
	}
	else {
		if(ajout.compareTo("20")==0) {
			out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenanceprevdesenfumagenaturel.jsp?numdesenfumage="+numdesenfumage+"\">");
		}
		else {
			if(ajout.compareTo("19")==0) {
		out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrdesenfumagenaturel.jsp?numdesenfumage="+numdesenfumage+"\">");
			}
		}
	}
	ajout="0";
	session.setAttribute("ajout",ajout);
	
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