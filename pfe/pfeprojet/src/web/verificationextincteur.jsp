<html>
<head>
<title>Verification d'un Extincteur</title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<header class="header">
		<a class="logo" href="http://www.desentec.fr/"><img
			src="http://www.desentec.fr/wp-content/uploads/2015/06/logo-site.png">
		</a>
		<p class="head">
		<center>
			<strong>Desentec - Protection incendie</strong>
		</center>
		</p>
	</header>
	<%@ page import="java.net.URL"%>
	<%@ page import="java.net.URLConnection"%>
	<%@ page import="java.io.* "%>
	<%@ page import="ejb.sessions.*"%>
	<%@ page import="ejb.entites.* "%>
	<%@ page import="java.util.List"%>
	<%@ page import="java.util.ArrayList"%>
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.naming.NamingException"%>

	<%!String numBat, observation;
	int num, i,j;
	List<Extincteur> E = new ArrayList<Extincteur>();
	%>
	<%
		session = request.getSession();
		InitialContext ctx = new InitialContext();
		Object obj = ctx.lookup(
				"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;

		numBat = String.valueOf(session.getAttribute("num"));
		session.setAttribute("num", numBat);
		num=Integer.parseInt(numBat);
		
		// Verification de la liste des organes
		out.println("<br>numero du batiment"+service.rechercheBatimentnum(num).getNumero());
		out.println("<br>liste des extincteurs du batiment : ");
		for(i=0;i<service.rechercheBatimentnum(num).getOrganes().size();i++){
			out.println("<br> Numero de l'extincteur"+service.rechercheBatimentnum(num).getOrganes().get(i).getNumero());
		}
		
		
		
		// Tableau
		out.println("<br><form action=\"verificationextincteurvalidee.jsp\"> <table border=\"1\" cellpadding=\"10\" cellspacing=\"1\" width=\"100%\"> <tr><th width=\"10%\" align=\"center\"> Numero de l'organe </th><th width=\"20%\" align=\"center\"> Emplacement </th> <th width=\"40%\" align=\"center\"> Observation </th></tr>");
		for(i=0;i<service.rechercheBatimentnum(num).getOrganes().size();i++){
			if(service.rechercheBatimentnum(num).getOrganes().get(i) instanceof Extincteur){
				if(service.getVerification(service.rechercheBatimentnum(num).getOrganes().get(i)).size()==0)
					observation="--";
				else
					observation=service.getVerification(service.rechercheBatimentnum(num).getOrganes().get(i)).get(service.getVerification(service.rechercheBatimentnum(num).getOrganes().get(i)).size()-1).getObservation();
				out.println(" <tr><td align=\"center\"> " + service.rechercheBatimentnum(num).getOrganes().get(i).getNumero()+
						"</td> <td align=\"center\">" + service.rechercheBatimentnum(num).getOrganes().get(i).getEmplacement()+
						"</td> <td align=\"center\"> <input type=\"text\" name="+i+" value="+observation+"><t/d></tr>"
						);
			}
		}
		out.println("</table>");
		out.println("<center>Conclusion <input type=\"text\" name=\"Conclusion\" value=\"Conclusion\">");
		out.println("<br><input type=\"submit\" value=\"Valider\"></center></form>");
	%>
</body>
</html>