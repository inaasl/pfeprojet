<html>
<head>
<title>Vérification : Alarme Incendie </title>
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

		<%!String numBat,observation;
			int i,num,numalarme;%>
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
			
			numalarme = Integer.parseInt(request.getParameter("numalarme"));
			observation=service.rechercheObservationVerification(numalarme);
			Alarme A =(Alarme)service.rechercheOrganeNum(numalarme);
			session.setAttribute("numalarme",numalarme);
		%>
		
<form action="verificationalarmevalideeconclu.jsp" method="post">
		 <fieldset>
	 <legend><b>Vérification Alarme Incendie</b></legend>
	<br>
	<table>
	<tr></tr>
	<tr><i>Emplacement de l'alarme incendie : </i></td>
	<td><%out.println(A.getEmplacement()); %><tr></tr>
 	<tr><td><i>Marque de l'alarme incendie : </i></td>
 	<td> <%out.println(A.getMarque().getNom()); %></td>
	</tr>
	<tr><i>Annee : </i></td>	  
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
	<tr><td><label for="testvoltbatterie"><i>Test Voltage : <font color="#ff0000">*</font></i></label>
    </td>	  
	<td><input type="text" name="testvoltbatterie" required value="<%out.println(A.getTestVoltBatterie());%>" size="40" class="taille_input_testvoltbatterie"/> Volts
	</td></tr>
	<tr><td>
    <label for="testamperebatterie"><i>Test Ampèrage : <font color="#ff0000">*</font></i></label>
    </td>	  
	<td><input type="text" name="testamperebatterie" required value="<%out.println(A.getTestAmpereBatterie()); %>" size="40" class="taille_input_testvoltbatterie"/> Ampères/h
	</td></tr>
	<tr><td>
    <label for="testvoltchargeurbatterie"><i>Test Voltage du Chargeur : <font color="#ff0000">*</font></i></label>
    </td>	  
	<td><input type="text" name="testvoltchargeurbatterie" required value="<%out.println(A.getTestVoltChargeur()); %>" size="40" class="taille_input_testvoltchargeurbatterie"/> Volts
	 </td></tr>
  	<tr></tr>
  	<tr><td><h5>DETECTION</h5></td></tr>	  
  	<tr><td><h6>Détecteur optique</h6></td></tr>
  	<tr><td><i>Nombre : </i></td>	  
	<td><%out.println(A.getNombreDetecteurOptique()); %></td></tr>
	<tr><td>
    <label for="obsoptique"><i>Observations : <font color="#ff0000">*</font></i></label>
    </td>	  
	<td><textarea name="obsoptique" rows="5" cols="47" required value="<%out.println(A.getObservationDetecteurOptique()); %>"><%out.println(A.getObservationDetecteurOptique()); %></textarea>
  	</td></tr>
  
  	<tr><td><h6>Détecteur ionique</h6></td></tr>
  	<tr><td><i>Nombre : </i></td>	  
	<td><%out.println(A.getNombreDetecteurIonique()); %></td></tr>
	<tr><td>
    <label for="obsionique"><i>Observations : <font color="#ff0000">*</font></i></label>
    </td>
	<td><textarea name="obsionique" rows="5" cols="47" required value="<%out.println(A.getObservationDetecteurIonique()); %>"><%out.println(A.getObservationDetecteurIonique()); %></textarea>
  	</td></tr>


  	<tr><td><h6>Détecteur thermique</h6></td></tr>
  	<tr><td><i>Nombre : </i></td>	  
	<td><%out.println(A.getNombreDetecteurThermique()); %></td></tr>
	<tr><td>
    <label for="obsthermique"><i>Observations : <font color="#ff0000">*</font></i></label>
    </td>	  
	<td><textarea name="obsthermique" rows="5" cols="47" required value="<%out.println(A.getObservationDetecteurThermique()); %>"><%out.println(A.getObservationDetecteurThermique()); %></textarea>
	</td></tr>
	  
	<tr><td><h6>Détecteur thermovélicimétrique</h6></td></tr>
	<tr><td><i>Nombre :</i></label>
    </td>	  
	<td><%out.println(A.getNombreDetecteurThermovelocimetrique()); %></td></tr>
	<tr><td>
    <label for="obsthermov"><i>Observations : <font color="#ff0000">*</font></i></label>
    </td>	  
	<td><textarea name="obsthermov" rows="5" cols="47" required value="<%out.println(A.getObservationDetecteurThermovelocimetrique()); %>"><%out.println(A.getObservationDetecteurThermovelocimetrique()); %></textarea>
	</td></tr>
	  
	<tr><td><h6>Détecteur de flammes </h6></td></tr>
	<tr><td><i>Nombre : </i></td>	  
	<td><%out.println(A.getNombreDetecteurFlammes()); %></td></tr>
	<tr><td>
    <label for="obsflamme"><i>Observations : <font color="#ff0000">*</font></i></label>
    </td>	  
	<td><textarea name="obsflamme" rows="5" cols="47" required value="<%out.println(A.getObservationDetecteurFlammes()); %>"><%out.println(A.getObservationDetecteurFlammes()); %></textarea>
	</td></tr>
	    
	<tr><td><h6> Détection par aspiration </h6></td></tr>
	<tr><td><i>Nombre : </i>
    </td>	  
	<td><%out.println(A.getNombreDetecteurAspiration()); %></td></tr>
	<tr><td>
    <label for="obsaspiration"><i>Observations : <font color="#ff0000">*</font></i></label>
    </td>	  
	<td><textarea name="obsaspiration" rows="5" cols="47" required value="<%out.println(A.getObservationDetecteurAspiration()); %>"><%out.println(A.getObservationDetecteurAspiration()); %></textarea>
	</td></tr>
	  
	<tr><td><h6>Autre : report </h6></td></tr>
	<tr><td>Nombre : </i>
    </td>	  
	<td><%out.println(A.getNombreAutreReport()); %></td></tr>
	<tr><td>
    <label for="obsreport"><i>Observations : <font color="#ff0000">*</font></i></label>
    </td>	  
	<td><textarea name="obsreport" rows="5" cols="47" required value="<%out.println(A.getObservationAutreReport()); %>"><%out.println(A.getObservationAutreReport()); %></textarea>
	</td></tr>
	  
	<tr><td><h6> Déclencheur manuel </h6></td></tr>
	<tr><td><i>Nombre : </i></td>	  
	<td><%out.println(A.getNombreDeclencheurManuel()); %></td></tr>
	<tr><td>
    <label for="obsmanuel"><i>Observations : </i>
    </td>	  
	<td><textarea name="obsmanuel" rows="5" cols="47" required value="<%out.println(A.getObservationDeclencheurManuel()); %>"><%out.println(A.getObservationDeclencheurManuel()); %></textarea>
	</td></tr>
	 
	<tr><td><h6> Diffuseur Sonore </h6></td></tr>
	<tr><td>Nombre : </td>	  
	<td><%out.println(A.getNombreDiffusionSonore()); %></td></tr>
	<tr><td>
    <label for="obssonore"><i>Observations : <font color="#ff0000">*</font></i></label>
    </td>	  
	<td><textarea name="obssonore" rows="5" cols="47" required value="<%out.println(A.getObservationDiffusionSonore()); %>"><%out.println(A.getObservationDiffusionSonore()); %></textarea>
	</td></tr>
	 
	<tr><td><h6> Diffuseur Lumineux </h6></td></tr>
	<tr><td><i>Nombre : </i>
    </td>	  
	<td><%out.println(A.getNombreDiffusionSonoreFlash()); %></td></tr>
	<tr><td>
    <label for="obslumineux"><i>Observations : <font color="#ff0000">*</font></i></label>
    </td>	  
	<td><textarea name="obslumineux" rows="5" cols="47" required value="<%out.println(A.getObservationDiffusionSonoreFlash()); %>"><%out.println(A.getObservationDiffusionSonoreFlash()); %></textarea>
	</td></tr>
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
	<tr><td>
    <label for="testvoltbatterieaes"><i>Test Voltage : <font color="#ff0000">*</font></i></label>
    </td>	  
	<td><input type="text" name="testvoltbatterieaes" required value="<%out.println(A.getTestVoltBatterieAES()); %>" size="40" class="taille_input_testvoltbatterie"/> Volts
	</td></tr>
	<tr><td>
    <label for="testamperebatterieaes"><i>Test Ampèrage : <font color="#ff0000">*</font></i></label>
    </td>	  
	<td><input type="text" name="testamperebatterieaes" required value="<%out.println(A.getTestAmpereBatterieAES()); %>" size="40" class="taille_input_testvoltbatterie"/> Ampères/h
	</td></tr>
	<tr><td>
    <label for="testvoltchargeurbatterieaes"><i>Test Voltage du Chargeur : <font color="#ff0000">*</font></i></label>
    </td>	  
	<td><input type="text" name="testvoltchargeurbatterieaes" required value="<%out.println(A.getTestVoltChargeurAES()); %>" size="40" class="taille_input_testvoltchargeurbatterie"/> Volts
	</td></tr>
	<tr></tr>
	<tr><td><label for="observations"><i>Observations <font color="#ff0000">*</font></i></label></td><td>
	<textarea name="observations" rows="5" cols="47" required placeholder="observations......"><%out.println(observation);%></textarea> 
	</td>
	</tr>
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