<html>
<head>
<title>Ajout d'une Alarme Incendie</title>
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
	<%@ page import="java.util.Collection"%>
	<%@ page import="java.util.Set"%>
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.naming.NamingException"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>
	<%@ page import="java.text.DateFormat"%>
	<%@ page import="java.util.HashSet"%>
	
	<%!String numBat,ajout;
	int num, i;%>
	
	<%
		session = request.getSession();
		
		Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
		pdf=null;
		
		InitialContext ctx = new InitialContext();
		Object obj = ctx.lookup(
				"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
			
		numBat = String.valueOf(session.getAttribute("num"));
		
		
		session.setAttribute("num", numBat);
		
		ajout=request.getParameter("ajout");
		if(ajout!=null){
			session.setAttribute("ajout",ajout);
		}
		else {
			ajout=String.valueOf(session.getAttribute("ajout"));
		}

	
	%>
<form action="installationalarmevalidee.jsp" method="post" >
	 <fieldset>
	 <legend><b>Installation Alarme Incendie</b></legend>
	<br>
	<table>
	<tr></tr>
	<tr>
		<td> <label for="emplacement"><i>Emplacement de l'alarme incendie <font color="#ff0000">*</font></i></label></td>
		<td><textarea name="emplacement" rows="5" cols="47" required placeholder="emplacement Alarme Incendie..."></textarea></td></tr>
  <tr></tr>
 <tr><td> <label for="marquealarme"><i>Marque de l'alarme incendie <font color="#ff0000">*</font></i></label>	 
		</td> <td> <select name="marquealarme" class="class_select">

				<%
					
					for (i = 0; i < service.touteslesMarqueAlarme().size(); i++)
						out.println("<option value=" + service.touteslesMarqueAlarme().get(i).getNumero() + ">"
								+ service.touteslesMarqueAlarme().get(i).getNom() + "</option>");
				%>
			</select>
		</td>
		<td><label for="nomMarquealarme"><i>Ajout d'une Marque </i></label> <input type="text"
				name="nomMarquealarme"  placeholder="nom de la marque..." size="20" class="taille_input_type"/>
	  
	 	 </td>
	</tr>
	<tr>
		<td>
               <label for="annee"><i>Annee <font color="#ff0000">*</font></i></label>
               </td>	  
	   <td><input type="text"
				name="annee" required placeholder="Annee..." size="40" class="taille_input_annee"/>
	  </td></tr>
	<tr><td> <label for="typealarme"><i>Type de l'alarme incendie <font color="#ff0000">*</font></i></label>	 
		</td> <td> <select name="typealarme" class="class_select">

				<%
					
					for (i = 0; i < service.touslesTypeAlarme().size(); i++)
						out.println("<option value=" + service.touslesTypeAlarme().get(i).getNumero() + ">"
								+ service.touslesTypeAlarme().get(i).getNom() + "</option>");
				%>
			</select>
		</td>
		<td><label for="nomTypealarme"><i>Ajout d'un Type </i></label> <input type="text"
				name="nomTypealarme"  placeholder="nom du type..." size="20" class="taille_input_type"/>
	 </td></tr>
	 <tr></tr>
	 <tr><td><h5>Batterie</h5></td></tr>
	 	<tr><td>
               <label for="nombrebatterie"><i>Nombre<font color="#ff0000">*</font></i></label>
               </td>	  
	   <td><input type="text"
				name="nombrebatterie" required placeholder="Nombre..." size="40" class="taille_input_nombre"/>
	  </td></tr>
	  <tr><td>
               <label for="xbatterie"><i>x = <font color="#ff0000">*</font></i></label>
               </td>	  
	   <td><input type="text" name="xbatterie" required placeholder="x ..." size="40" class="taille_input_xbatterie"/>
	  </td></tr>
	  <tr><td>
               <label for="ybatterie"><i>y = <font color="#ff0000">*</font></i></label>
               </td>	  
	   <td><input type="text" name="ybatterie" required placeholder="y ..." size="40" class="taille_input_ybatterie"/>
	  </td></tr>
	  <tr><td>
               <label for="hbatterie"><i>h = <font color="#ff0000">*</font></i></label>
               </td>	  
	   <td><input type="text" name="hbatterie" required placeholder="h ..." size="40" class="taille_input_hbatterie"/>
	  </td></tr>
	  <tr><td><label for="typebatterie"><i>Type de la batterie <font color="#ff0000">*</font></i></label>	 
		</td><td> <select name="typebatterie" class="class_select">
				<%
					
					for (i = 0; i < service.touslesTypeBatterie().size(); i++)
						out.println("<option value=" + service.touslesTypeBatterie().get(i).getNumero() + ">"
								+ service.touslesTypeBatterie().get(i).getNom() + "</option>");
				%>
			</select>
		</td>
		<td><label for="nomTypebatterie"><i>Ajout d'un Type </i></label> <input type="text"
				name="nomTypebatterie"  placeholder="nom du type..." size="20" class="taille_input_type"/>
	 </td></tr>
	 <tr><td>
               <label for="testvoltbatterie"><i>Test Voltage : <font color="#ff0000">*</font></i></label>
               </td>	  
	   <td><input type="text" name="testvoltbatterie" required placeholder="Volts ..." size="40" class="taille_input_testvoltbatterie"/> Volts
	 </td></tr>
	 <tr><td>
               <label for="testamperebatterie"><i>Test Ampèrage : <font color="#ff0000">*</font></i></label>
               </td>	  
	   <td><input type="text" name="testamperebatterie" required placeholder="Ampères/h ..." size="40" class="taille_input_testvoltbatterie"/> Ampères/h
	 </td></tr>
	 <tr><td>
               <label for="testvoltchargeurbatterie"><i>Test Voltage du Chargeur : <font color="#ff0000">*</font></i></label>
               </td>	  
	   <td><input type="text" name="testvoltchargeurbatterie" required placeholder="Volts ..." size="40" class="taille_input_testvoltchargeurbatterie"/> Volts
	 </td></tr>
  <tr></tr>
  <tr><td><h5>DETECTION</h5></td></tr>	  
  <tr><td><h6>Détecteur optique</h6></td></tr>
  <tr><td>
       <label for="nombreoptique"><i>Nombre : <font color="#ff0000">*</font></i></label>
       </td>	  
	<td><input type="text" name="nombreoptique" required placeholder="Nombre ..." size="40" class="taille_input_nombreoptique"/>
	</td></tr>
	<tr><td>
       <label for="obsoptique"><i>Observations : <font color="#ff0000">*</font></i></label>
       </td>	  
	<td><textarea name="obsoptique" rows="5" cols="47" required placeholder="observations......"></textarea>
  </td></tr>
  
  <tr><td><h6>Détecteur ionique</h6></td></tr>
  <tr><td>
       <label for="nombreionique"><i>Nombre : <font color="#ff0000">*</font></i></label>
       </td>	  
	<td><input type="text" name="nombreionique" required placeholder="Nombre ..." size="40" class="taille_input_nombreionique"/>
	</td></tr>
	<tr><td>
       <label for="obsionique"><i>Observations : <font color="#ff0000">*</font></i></label>
       </td>	  
	<td><textarea name="obsionique" rows="5" cols="47" required placeholder="observations......"></textarea>
  </td></tr>


  <tr><td><h6>Détecteur thermique</h6></td></tr>
  <tr><td>
        <label for="nombrethermique"><i>Nombre : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><input type="text" name="nombrethermique" required placeholder="Nombre ..." size="40" class="taille_input_nombrethermique"/>
		</td></tr>
		<tr><td>
        <label for="obsthermique"><i>Observations : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><textarea name="obsthermique" rows="5" cols="47" required placeholder="observations......"></textarea>
	  </td></tr>
	  
	  <tr><td><h6>Détecteur thermovélicimétrique</h6></td></tr>
	  <tr><td>
        <label for="nombrethermov"><i>Nombre : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><input type="text" name="nombrethermov" required placeholder="Nombre ..." size="40" class="taille_input_nombrethermov"/>
		</td></tr>
		<tr><td>
        <label for="obsthermov"><i>Observations : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><textarea name="obsthermov" rows="5" cols="47" required placeholder="observations......"></textarea>
	  </td></tr>
	  
	  <tr><td><h6>Détecteur de flammes </h6></td></tr>
	  <tr><td>
        <label for="nombreflamme"><i>Nombre : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><input type="text" name="nombreflamme" required placeholder="Nombre ..." size="40" class="taille_input_nombreflamme"/>
		</td></tr>
		<tr><td>
        <label for="obsflamme"><i>Observations : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><textarea name="obsflamme" rows="5" cols="47" required placeholder="observations......"></textarea>
	  </td></tr>
	    
	  <tr><td><h6> Détection par aspiration </h6></td></tr>
	  <tr><td>
        <label for="nombreaspiration"><i>Nombre : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><input type="text" name="nombreaspiration" required placeholder="Nombre ..." size="40" class="taille_input_nombreaspiration"/>
		</td></tr>
		<tr><td>
        <label for="obsaspiration"><i>Observations : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><textarea name="obsaspiration" rows="5" cols="47" required placeholder="observations......"></textarea>
	  </td></tr>
	  
	  <tr><td><h6>Autre : report </h6></td></tr>
	  <tr><td>
        <label for="nombrereport"><i>Nombre : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><input type="text" name="nombrereport" required placeholder="Nombre ..." size="40" class="taille_input_nombrereport"/>
		</td></tr>
		<tr><td>
        <label for="obsreport"><i>Observations : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><textarea name="obsreport" rows="5" cols="47" required placeholder="observations......"></textarea>
	  </td></tr>
	  
	  <tr><td><h6> Déclencheur manuel </h6></td></tr>
	  <tr><td>
        <label for="nombremanuel"><i>Nombre : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><input type="text" name="nombremanuel" required placeholder="Nombre ..." size="40" class="taille_input_nombremanuel"/>
		</td></tr>
		<tr><td>
        <label for="obsmanuel"><i>Observations : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><textarea name="obsmanuel" rows="5" cols="47" required placeholder="observations......"></textarea>
	  </td></tr>
	  
	  <tr><td><h6> Diffuseur Sonore </h6></td></tr>
	  <tr><td>
        <label for="nombresonore"><i>Nombre : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><input type="text" name="nombresonore" required placeholder="Nombre ..." size="40" class="taille_input_nombresonore"/>
		</td></tr>
		<tr><td>
        <label for="obssonore"><i>Observations : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><textarea name="obssonore" rows="5" cols="47" required placeholder="observations......"></textarea>
	  </td></tr>
	  
	  <tr><td><h6> Diffuseur Lumineux </h6></td></tr>
	  <tr><td>
        <label for="nombrelumineux"><i>Nombre : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><input type="text" name="nombrelumineux" required placeholder="Nombre ..." size="40" class="taille_input_nombrelumineux"/>
		</td></tr>
		<tr><td>
        <label for="obslumineux"><i>Observations : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><textarea name="obslumineux" rows="5" cols="47" required placeholder="observations......"></textarea>
	  </td></tr>
	  <tr></tr>
	  <tr><td><h5>AES</h5></td></tr>	  
	  <tr><td>
        <label for="nombreaes"><i>Nombre : <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><input type="text" name="nombreaes" required placeholder="Nombre ..." size="40" class="taille_input_nombreaes"/>
	  </td></tr>
	  <tr><td> <label for="typeaes"><i>Type AES <font color="#ff0000">*</font></i></label>	 
			</td> <td> <select name="typeaes" class="class_select">
					<%
						
						for (i = 0; i < service.touslesTypeAES().size(); i++)
							out.println("<option value=" + service.touslesTypeAES().get(i).getNumero() + ">"
									+ service.touslesTypeAES().get(i).getNom() + "</option>");
					%>
				</select>
			</td>
			<td><label for="nomTypeaes"><i>Ajout d'un Type </i></label> <input type="text"
					name="nomTypeaes"  placeholder="nom du type..." size="20" class="taille_input_type"/>
	  </td></tr>
	  <tr><td><h6>Batterie AES</h6></td></tr>
	  <tr><td>
                <label for="nombrebatterieaes"><i>Nombre<font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><input type="text"
					name="nombrebatterieaes" required placeholder="Nombre..." size="40" class="taille_input_nombre"/>
		  </td></tr>
		  <tr><td>
                <label for="xbatterieaes"><i>x = <font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><input type="text" name="xbatterieaes" required placeholder="x ..." size="40" class="taille_input_xbatterie"/>
		  </td></tr>
		  <tr><td>
                <label for="ybatterieaes"><i>y = <font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><input type="text" name="ybatterieaes" required placeholder="y ..." size="40" class="taille_input_ybatterie"/>
		  </td></tr>
		  <tr><td>
                <label for="hbatterieaes"><i>h = <font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><input type="text" name="hbatterieaes" required placeholder="h ..." size="40" class="taille_input_hbatterie"/>
		  </td></tr>
		  <tr><td> <label for="typebatterieaes"><i>Type de la batterie AES <font color="#ff0000">*</font></i></label>	 
			</td> <td> <select name="typebatterieaes" class="class_select">
					<%
						
						for (i = 0; i < service.touslesTypeBatterieAES().size(); i++)
							out.println("<option value=" + service.touslesTypeBatterieAES().get(i).getNumero() + ">"
									+ service.touslesTypeBatterieAES().get(i).getNom() + "</option>");
					%>
				</select>
			</td>
			<td><label for="nomTypebatterieaes"><i>Ajout d'un Type </i></label> <input type="text"
					name="nomTypebatterieaes"  placeholder="nom du type..." size="20" class="taille_input_type"/>
		 </td></tr>
		 <tr><td>
                <label for="testvoltbatterieaes"><i>Test Voltage : <font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><input type="text" name="testvoltbatterieaes" required placeholder="Volts ..." size="40" class="taille_input_testvoltbatterie"/> Volts
		 </td></tr>
		 <tr><td>
                <label for="testamperebatterieaes"><i>Test Ampèrage : <font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><input type="text" name="testamperebatterieaes" required placeholder="Ampères/h ..." size="40" class="taille_input_testvoltbatterie"/> Ampères/h
		 </td></tr>
		 <tr><td>
                <label for="testvoltchargeurbatterieaes"><i>Test Voltage du Chargeur : <font color="#ff0000">*</font></i></label>
                </td>	  
		   <td><input type="text" name="testvoltchargeurbatterieaes" required placeholder="Volts ..." size="40" class="taille_input_testvoltchargeurbatterie"/> Volts
		 </td></tr>
	  <tr></tr>
	  <% if(ajout.compareTo("0")==0) { %>
	  <tr><td><label for="observations"><i>Observations <font color="#ff0000">*</font></i></label></td><td>
					<textarea name="observations" rows="5" cols="47" required placeholder="observations......"></textarea> 
			</td>
	 </tr>
	 <% } %>
	 <tr></tr>
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