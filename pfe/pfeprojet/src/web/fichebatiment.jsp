<html>

   <head>
    <title>Fiche : entreprise </title>
    <meta charset="UTF-8" />
    <link href="style.css" rel="stylesheet" type="text/css">
  </head>
<body>
 <header class="header">
    	        <a class="logo" href="http://www.desentec.fr/"><img src="http://www.desentec.fr/wp-content/uploads/2015/06/logo-site.png"> </a>
    	       <p class="head"><center><strong>Desentec - Protection incendie</strong></center></p>
 </header> 	
 <br><br><br><br><br><br><br>
	 
	 
		<%@ page import="java.net.URL" %>
        <%@ page import="java.net.URLConnection" %>
        <%@ page import="java.io.* " %>
		<%@ page import= "ejb.sessions.*"%>
		<%@ page import= "ejb.entites.* "%>
		<%@ page import= "java.util.Collection"%>
		<%@ page import= "java.util.Set"%>
		<%@ page import= "javax.naming.InitialContext"%>
		<%@ page import= "javax.naming.NamingException"%>
		<%@ page import= "java.util.Date"%>
		<%@ page import= "java.text.SimpleDateFormat"%>
		<%@ page import= "java.text.DateFormat"%>
		<%@ page import= "java.util.HashSet"%>

		
		
        <%! String numBatiment;
        	Batiment B;
        	int num,i;
        %>
        
  
        <%
           		numBatiment =request.getParameter("numBatiment");
           		num = Integer.parseInt(numBatiment);
           		InitialContext ctx = new InitialContext();
    			Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
    			ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
    			out.println("Fiche du batiment : <br> <br> ");
				B=service.rechercheBatimentnum(num);
				out.println("Nom du batiment : "+B.getNom()+"<br><br> Adresse du batiment : "+B.getAdresse()+"<br><br> Entreprise : "+B.getEntreprise().getNom());
				out.println("<br><br><table><tr><td><form action=\"choixintervention\" method=\"GET\" ><input type=\"hidden\" id=\"idintervention\" name=\"numBatiment\" value="+B.getNumero()+"> <input type=\"submit\" name=\" Effectuer une intervention \" value=\" Effectuer une intervention \" /></form></td><tr>");
				out.println("<tr><td><form action=\"listeorganes\" method=\"GET\" ><input type=\"hidden\" id=\"idlisteorganes\" name=\"numBatiment\" value="+B.getNumero()+"> <input type=\"submit\" name=\" Consulter la liste des organes de securite \" value=\" Consulter la liste des organes de securite \" /></form></td></tr>");
				out.println("</table>");				
/* 				out.print("<br><br> <table border=\"1\" cellpadding=\"10\" cellspacing=\"1\" width=\"100%\"> <tr><th width=\"20%\" align=\"center\"> Numero de l'organe </th><th width=\"20%\" align=\"center\"> Nom de l'organe </th> <th width=\"20%\" align=\"center\"> Nom de l'organe </th><th width=\"20%\" align=\"center\">  </th></tr>");
				for(i=0;i<B.getOrganes().size();i++){
					out.print(" <tr><td align=\"center\"> "+E.getBatiments().get(i).getNom() +"</td><td <td align=\"center\">"+E.getBatiments().get(i).getAdresse()+"</td><td align=\"center\"> <form action=\"fichebatiment\" method=\"GET\" ><input type=\"hidden\" id=\"idfichebat\" name=\"numBatiment\" value="+E.getBatiments().get(i).getNumero()+"> <input type=\"submit\" name=\" Consulter la fiche \" value=\" Consulter la fiche \" /></form></td></tr>");
    			}
				out.print("</table>"); */ 
        %>
 