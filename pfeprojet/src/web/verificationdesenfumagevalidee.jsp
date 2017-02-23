<html>
<head>
<title>Vérification : Désenfumage Naturel </title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" media="screen and (max-width: 2560px)">
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
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.naming.NamingException"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>
	<%@ page import="java.text.DateFormat"%>
	<%@ page import="java.util.List"%>

		<%!String numBat,observation,observationouvrant;
			int i,num,numdesenfumage;
			String[] result;
			%>
		<%
			session = request.getSession();

			List<Organe> organes=(List<Organe>)session.getAttribute("organes");
			if(organes!=null) organes.clear();
			session.setAttribute("organes",organes);
		
			String ajout=String.valueOf(session.getAttribute("ajout"));
			if(ajout!=null) ajout="0";
			session.setAttribute("ajout",ajout);
		
			Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
			pdf=null;
			session.setAttribute("pdf",pdf);
			
			InitialContext ctx = new InitialContext();
			Object obj = ctx.lookup(
				"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
			ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
			
			numBat = String.valueOf(session.getAttribute("num"));
			session.setAttribute("num", numBat);
			
			numdesenfumage = Integer.parseInt(request.getParameter("numdesenfumage"));
			observation=service.rechercheObservationVerification(numdesenfumage);
			DesenfumageNaturel D =(DesenfumageNaturel)service.rechercheOrganeNum(numdesenfumage);
			session.setAttribute("numdesenfumage",numdesenfumage);
		
			out.println("<center><input type=\"button\" name=\"AjoutOuv\" value=\"Ajout ouvrants\"  onclick=\"self.location.href='ajoutouvrant.jsp?ajout=18'\"></button></center>");

			%>
		
<form action="verificationdesenfumagevalideeconclu.jsp" method="post">
		 <fieldset>
	 <legend><b>Vérification Désenfumage Naturel</b></legend>
	<br>
	<table id="datatables" class="display" >
	<thead><tr><th> N° </th><th> Commande </th><th> Ouvrant </th><th>Observation</th></tr>
	</thead><tbody>
	<%
		List<Ouvrant> ouvrants =  service.RechercheOuvrantDesenfumage(numdesenfumage);
	
		for(int i=0;i<D.getOuvrants().size();i++){
			observation=service.rechercheObservationVerification(D.getNumero());
			if(observation!=null){
				if(observation.compareTo("--")!=0){
					result=observation.split(";");
					observationouvrant=result[i];
					if(observationouvrant==null){
						observationouvrant="--";
					}
				}
				else 
					observationouvrant="--";
			}
			else {
				observationouvrant="--";
			}
			out.println("<tr><td>" + D.getOuvrants().get(i).getNumero()+
				"</td><td>" + D.getOuvrants().get(i).getCommande()+
				"</td><td >" + D.getOuvrants().get(i).getNom()+
				"</td><td> <input type=\"text\" name="+i+" value="+observationouvrant+
				"></td></tr>"
				);
		}
	%>
	</tbody>
	</table>
	<table>
		<tr><td> Est-ce que l'organe fonctionne correctement ? </td><td>
		<INPUT id="oui" type= "radio" name="etat" value="oui">
	    <label for="oui">OUI</label> &nbsp;&nbsp;&nbsp;
		<INPUT id="non" type= "radio" name="etat" value="non"> 
		<label for="non">NON</label> &nbsp;&nbsp;&nbsp;
		</td></tr>
	</table>
	<br><center><input type="submit" value="Valider"> </center>
	</fieldset>
	</form>
	</div>
	<%
	 }
	 }
	 else
	 	out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
	%>
</body>
</html>