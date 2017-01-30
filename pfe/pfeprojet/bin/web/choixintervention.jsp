<html>

   <head>
    <title>Intervention -- Choix de l'intervention </title>
    <meta charset="UTF-8" />
    <link href="style.css" rel="stylesheet" type="text/css">
  </head>
<body>
 <header class="header">
    	        <a class="logo" href="http://www.desentec.fr/"><img src="http://www.desentec.fr/wp-content/uploads/2015/06/logo-site.png"> </a>
    	       <p class="head"><center><strong>Desentec - Protection incendie</strong></center></p>
 </header>
  <%!
  	String numBatiment;
  %>
  
  
  <%
  		numBatiment =request.getParameter("numBatiment");
  		session.setAttribute("num",numBatiment);
  %>
  
<center>Type de l'intervention
 <FORM action="intervention.jsp">
	<INPUT id="installation" type= "radio" name="choixinterv" value="installation"/> 
	<label for="installation">Installation</label>
	<INPUT id="verification" type= "radio" name="choixinterv" value="verification"/>
	<label for="verification">Vérification</label> 
	<INPUT id="maintenanceprev" type= "radio" name="choixinterv" value="maintenanceprev"/> 
	<label for="maintenanceprev">Maintenance Préventive</label> 
	<INPUT id="maintenancecorr" type= "radio" name="choixinterv" value="maintenancecorr"/> 
	<label for="maintenancecorr">Maintenance Corrective</label>

<br><br>Type de l'organe de sécurité 
	<br><br><INPUT id="extincteur" type= "radio" name="choixorg" value="extincteur">
	<label for="extincteur">Extincteur</label> 
	<INPUT id="eclairage" type= "radio" name="choixorg" value="eclairage"> 
	<label for="eclairage">Eclairage</label> 
	<INPUT id="pharmacie" type= "radio" name="choixorg" value="pharmacie"> 
	<label for="pharmacie">Pharmacie</label>
	<INPUT id="signaletique" type= "radio" name="choixorg" value="signaletique"> 
	<label for="signaletique">Signalétique</label> 
	
	<br><br><input type="submit" value="Valider">
	
</FORM>
</center>
 </body>
 </html>