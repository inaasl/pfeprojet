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
  <br><br><br><br><br><br><br>
  <%!
  	String numBatiment;
  %>
  
  
  <%
  		numBatiment =request.getParameter("numBatiment");
  		session.setAttribute("num",numBatiment);
  %>
  
<center>Type de l'intervention
 <FORM action="intervention.jsp">
	<br><INPUT id="installation" type= "radio" name="choixinterv" value="installation"/> 
	<label for="installation">Installation</label>
	<br><INPUT id="verification" type= "radio" name="choixinterv" value="verification"/>
	<label for="verification">Vérification</label> 
	<br><INPUT id="maintenanceprev" type= "radio" name="choixinterv" value="maintenanceprev"/> 
	<label for="maintenanceprev">Maintenance Préventive</label> 
	<br><INPUT id="maintenancecorr" type= "radio" name="choixinterv" value="maintenancecorr"/> 
	<label for="maintenancecorr">Maintenance Corrective</label>

<br><br>Type de l'organe de sécurité 
	<br><br><INPUT id="extincteur" type= "radio" name="choixorg" value="extincteur">
	<label for="extincteur">Extincteur</label> 
	<br><INPUT id="eclairage" type= "radio" name="choixorg" value="eclairage"> 
	<label for="eclairage">Eclairage</label> 
	<br><INPUT id="pharmacie" type= "radio" name="choixorg" value="pharmacie"> 
	<label for="pharmacie">Pharmacie</label>
	<br><INPUT id="signaletique" type= "radio" name="choixorg" value="signaletique"> 
	<label for="signaletique">Signalétique</label> 
	
	<br><br><input type="submit" value="Valider">
	
</FORM>
</center>
 </body>
 </html>