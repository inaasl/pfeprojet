<html>
<head>
<title>Fiche : Alarme Incendie </title>
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
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.naming.NamingException"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>
	<%@ page import="java.text.DateFormat"%>
	<%@ page import="java.util.List"%>

		<%!String numBat,observation,numintervention,conclusion,observinterv;
			int i,num,numalarme,intinterv;
			String obsoptique,obsionique,obsthermique,obsthermov,obsflamme,obsaspiration,obsreport,obsmanuel,obssonore,obslumineux;
			String testvolt,testamp,testchargeur,testvoltaes,testampaes,testchargeuraes;
			Alarme A;
			String[] result;%>
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
			
			numintervention=request.getParameter("numintervention");
			if(numintervention==null) {
			numalarme = Integer.parseInt(request.getParameter("numalarme"));
			A =(Alarme)service.rechercheOrganeNum(numalarme);
			observation=A.getObservation();
			conclusion=A.getConclusion();
			}
			else {
				intinterv=Integer.parseInt(numintervention);
				Intervention I = service.rechercheInterventionNum(intinterv);
				A=(Alarme)I.getOrgane();
				String obs;
				obs=I.getObservation();
				result=obs.split(";");
				observation=result[0];
				obsoptique=result[1];
				obsionique=result[2];
				obsthermique=result[3];
				obsthermov=result[4];
				obsflamme=result[5];
				obsaspiration=result[6];
				obsreport=result[7];
				obsmanuel=result[8];
				obssonore=result[9];
				obslumineux=result[10];
				testvolt=result[11];
				testamp=result[12];
				testchargeur=result[13];
				testvoltaes=result[14];
				testampaes=result[15];
				testchargeuraes=result[16];
				conclusion=I.getConclusion();
			}
		%>
		
		 <fieldset>
	 <legend><b>Fiche Alarme Incendie</b></legend>
	<br>
	<table>
	
	<tr><td><i>Emplacement de l'alarme incendie : </i></td>
	<td><%out.println(A.getEmplacement()); %></td></tr>
	
 	<tr><td><i>Marque de l'alarme incendie : </i></td>
 	<td><%out.println(A.getMarque().getNom()); %></td>
	</tr>
	
	<tr><td><i>Annee : </i></td>	  
	<td><%out.println(A.getAnnee()); %></td></tr>
	
	<tr><td><i>Type de l'alarme incendie : </i></td>
	<td><%out.println(A.getType().getNom()); %></td>
	</tr>
	<tr></tr>
	<tr><td><h5>Batterie</h5></td></tr>
	<tr><td><i>Nombre : </i></td>	  
	<td><%out.println(A.getNombreBatterie()); %></td></tr>
	<tr><td><i>x = </i></td>	  
	<td><%out.println(A.getXbatterie()); %></td></tr>
	<tr><td><i>y = </i></td>	  
	<td><%out.println(A.getYbatterie()); %></td></tr>
	<tr><td><i>h = </i></td>	  
	<td><%out.println(A.getHbatterie()); %></td></tr>
	<tr><td><i>Type de la batterie : </i></label>	 
	</td><td> <%out.println(A.getTypeBatterie().getNom()); %> </td></tr>
	<% if(numintervention==null) { %>
	<tr><td><i>Test Voltage lors de la dernière intervention : </i></label>
    </td>	  
	<td><% out.println(A.getTestVoltBatterie());%> Volts
	</td></tr>
	<%}else { %>
	<tr><td><i>Test Voltage : </i></label>
    </td>	  
	<td><% out.println(testvolt);%> Volts
	</td></tr>
	<% } %>
	<% if(numintervention==null) { %>
	<tr><td>
    <i>Test Ampèrage lors de la dernière intervention : </i>
    </td>	  
	<td><%out.println(A.getTestAmpereBatterie()); %> Ampères/h
	</td></tr>
	<%}else { %>
		<tr><td>
    <i>Test Ampèrage : </i>
    </td>	  
	<td><%out.println(testamp); %> Ampères/h
	</td></tr>
		<% } %>
	<% if(numintervention==null) { %>
	<tr><td>
    <i>Test Voltage du Chargeur lors de la dernière intervention : </i>
    </td>
	<td><%out.println(A.getTestVoltChargeur()); %> Volts
	 </td></tr>
	 	<%}else { %>
	 <tr><td>
    <i>Test Voltage du Chargeur : </i>
    </td>
	<td><%out.println(testchargeur); %> Volts
	</td></tr>
  	<tr></tr>
  	<% } %>
  	<tr><td><h5>DETECTION</h5></td></tr>	  
  	<tr><td><h6>Détecteur optique</h6></td></tr>
  	<tr><td><i>Nombre : </i></td>	  
	<td><%out.println(A.getNombreDetecteurOptique()); %></td></tr>
	<% if(numintervention==null) { %>
	<tr><td>
    <i>Observations de la dernière intervention: </i>
    </td>	  
	<td><%out.println(A.getObservationDetecteurOptique()); %>
  	</td></tr>
  	<%}else { %>
  	<tr><td>
    <i>Observations : </i>
    </td>	  
	<td><%out.println(obsoptique); %>
  	</td></tr>
  	<%} %>
  	<tr><td><h6>Détecteur ionique</h6></td></tr>
  	<tr><td><i>Nombre : </i></td>	  
	<td><%out.println(A.getNombreDetecteurIonique()); %></td></tr>
	<% if(numintervention==null) { %>
	<tr><td>
    <i>Observations lors de la dernière intervention : </i>
    </td>
	<td><%out.println(A.getObservationDetecteurIonique()); %>
  	</td></tr>
	<%}else { %>
	<tr><td>
    <i>Observations : </i>
    </td>
	<td><%out.println(obsionique); %>
  	</td></tr>	
	<%} %>
  	<tr><td><h6>Détecteur thermique</h6></td></tr>
  	<tr><td><i>Nombre : </i></td>	  
	<td><%out.println(A.getNombreDetecteurThermique()); %></td></tr>
	<% if(numintervention==null) { %>
	<tr><td>
    <i>Observations lors de la dernière intervention: </i>
    </td>	  
	<td><%out.println(A.getObservationDetecteurThermique()); %>
	</td></tr>
	<%}else { %>
	<tr><td>
    <i>Observations : </i>
    </td>	  
	<td><%out.println(obsthermique); %>
	</td></tr>
	<%} %>
	<tr><td><h6>Détecteur thermovélicimétrique</h6></td></tr>
	<tr><td><i>Nombre :</i></label>
    </td>	  
	<td><%out.println(A.getNombreDetecteurThermovelocimetrique()); %></td></tr>
	<% if(numintervention==null) { %>
	<tr><td>
    <i>Observations lors de la dernière intervention : </i>
    </td>	  
	<td><%out.println(A.getObservationDetecteurThermovelocimetrique()); %>
	</td></tr>
	<%}else { %>
	<tr><td>
	    <i>Observations : </i>
    </td>	  
	<td><%out.println(obsthermov); %>
	</td></tr>
	<%} %>
	<tr><td><h6>Détecteur de flammes </h6></td></tr>
	<tr><td><i>Nombre : </i></td>	  
	<td><%out.println(A.getNombreDetecteurFlammes()); %></td></tr>
	<% if(numintervention==null) { %>
	<tr><td>
    <i>Observations lors de la dernière intervention : </i>
    </td>	  
	<td><%out.println(A.getObservationDetecteurFlammes()); %>
	</td></tr>
	<%}else { %>
	<tr><td>
    <i>Observations : </i>
    </td>	  
	<td><%out.println(obsflamme); %>
	</td></tr>
	<%} %>
	<tr><td><h6> Détection par aspiration </h6></td></tr>
	<tr><td><i>Nombre : </i>
    </td>	  
	<td><%out.println(A.getNombreDetecteurAspiration()); %></td></tr>
	<% if(numintervention==null) { %>
	<tr><td>
    <i>Observations lors de la dernière intervention : </i>
    </td>	  
	<td><%out.println(A.getObservationDetecteurAspiration()); %>
	</td></tr>
	<%}else { %>
	<tr><td>
    <i>Observations : </i>
    </td>	  
	<td><%out.println(obsaspiration); %>
	</td></tr>
	<%} %>
	<tr><td><h6>Autre : report </h6></td></tr>
	<tr><td>Nombre : </i>
    </td>	  
	<td><%out.println(A.getNombreAutreReport()); %></td></tr>
	<% if(numintervention==null) { %>
	<tr><td>
    <i>Observations lors de la dernière intervention : </i>
    </td>	  
	<td><%out.println(A.getObservationAutreReport()); %>
	</td></tr>
	<%}else { %>
	<tr><td>
    <i>Observations : </i>
    </td>	  
	<td><%out.println(obsreport); %>
	</td></tr>
	<%} %>
	<tr><td><h6> Déclencheur manuel </h6></td></tr>
	<tr><td><i>Nombre : </i></td>	  
	<td><%out.println(A.getNombreDeclencheurManuel()); %></td></tr>
	<% if(numintervention==null) { %>
	<tr><td>
    <i>Observations lors de la dernière intervention : </i>
    </td>	  
	<td><%out.println(A.getObservationDeclencheurManuel()); %>
	</td></tr>
	 <%}else { %>
	<tr><td>
    <i>Observations : </i>
    </td>	  
	<td><%out.println(obsmanuel); %>
	</td></tr>
	<%} %>
	<tr><td><h6> Diffuseur Sonore </h6></td></tr>
	<tr><td>Nombre : </td>	  
	<td><%out.println(A.getNombreDiffusionSonore()); %></td></tr>
	<% if(numintervention==null) { %>
	<tr><td>
    <i>Observations lors de la dernière intervention : </i>
    </td>	  
	<td><%out.println(A.getObservationDiffusionSonore()); %>
	</td></tr>
	<%}else { %>
	<tr><td>
    <i>Observations : </i>
    </td>	  
	<td><%out.println(obssonore); %>
	</td></tr>
	<%} %>
	<tr><td><h6> Diffuseur Lumineux </h6></td></tr>
	<tr><td><i>Nombre : </i>
    </td>	  
	<td><%out.println(A.getNombreDiffusionSonoreFlash()); %></td></tr>
	<% if(numintervention==null) { %>
	<tr><td>
    Observations lors de la dernière intervention : </i>
    </td>	  
	<td><%out.println(A.getObservationDiffusionSonoreFlash()); %>
	</td></tr>
	<%}else { %>
	<tr><td>
    Observations : </i>
    </td>	  
	<td><%out.println(obslumineux); %>
	</td></tr>
	<%} %>
	<tr></tr>
	<tr><td><h5>AES</h5></td></tr>	  
	<tr><td><i>Nombre : </i></td>	  
	<td><%out.println(A.getNombreAES()); %></td></tr>
	<tr><td><i>Type AES : </i> 
	</td><td><%out.println(A.getTypeAES().getNom()); %></td>
	</tr>
	<tr><td><h6>Batterie AES</h6></td></tr>
	<tr><td><i>Nombre : </i></td>	  
	<td><%out.println(A.getNombreBatterieAES()); %></td></tr>
	<tr><td><i>x = </i></td>	  
	<td><%out.println(A.getXbatterie()); %></td></tr>
	<tr><td><i>y = </i></td>	  
	<td><%out.println(A.getYbatterie()); %></td></tr>
	<tr><td><i>h = </i></td>	  
	<td><%out.println(A.gethBatteriesAES()); %></td></tr>
	<tr><td><i>Type de la batterie AES </i></td>
	<td><%out.println(A.getTypeBatterieAES().getNom()); %></td>
	</tr>
	<% if(numintervention==null) { %>
	<tr><td>
    <i>Test Voltage lors de la dernière intervention : </i>
    </td>	  
	<td><%out.println(A.getTestVoltBatterieAES()); %> Volts
	</td></tr>
	<%}else{ %>
	<tr><td>
    <i>Test Voltage  : </i>
    </td>	  
	<td><%out.println(testvoltaes); %> Volts
	</td></tr>
	<%} %>
	<% if(numintervention==null) { %>
	<tr><td>
    <i>Test Ampèrage lors de la dernière intervention : </i>
    </td>	  
	<td><%out.println(A.getTestAmpereBatterieAES()); %> Ampères/h
	</td></tr>
	<%}else{ %>
	<tr><td>
    <i>Test Ampèrage : </i>
    </td>	  
	<td><%out.println(testampaes); %> Ampères/h
	</td></tr>
	<%} %>
	<% if(numintervention==null) { %>
	<tr><td>
    <i>Test Voltage du Chargeur lors de la dernière intervention : </i>
    </td>	  
	<td><%out.println(A.getTestVoltChargeurAES()); %> Volts
	</td></tr>
	<%}else{ %>
	<tr><td>
    <i>Test Voltage du Chargeur : </i>
    </td>	  
	<td><%out.println(testchargeuraes); %> Volts
	</td></tr>
	<%} %>
	<tr></tr>
	<% if(numintervention==null) { %>
	<tr><td><i>Observations lors de la dernière intervention : </i></td><td>
	<%out.println(observation);%>
	</td>
	</tr>
	<%}else{ %>
	<tr><td><i>Observations : </i></td><td>
	<%out.println(observation);%>
	</td>
	</tr>
	<%} %>
	<% if(numintervention!=null){ %>
	<tr><td><i>Conclusion : </i></td><td>
	<%out.println(conclusion);%>
	</td>
	</tr>
	<% } else { %>
	<tr><td><i>Conclusion de la dernière intervention: </i></td><td>
	<%out.println(conclusion);%>
	</td>
	</tr>
	<%} %>
	</table>
	<br>
	</fieldset>
	</div>
	<%
	 }
	 }
	 else
	 	out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
	%>
</body>
</html>