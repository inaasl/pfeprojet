<html>
<head>
<title> Installation d'un Extincteur</title>
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
<%! String numBat;
	int num;

%>
<%
	InitialContext ctx = new InitialContext();
	Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	numBat=String.valueOf(session.getAttribute("num"));
	session.setAttribute("num",numBat);
%>
<center>
<form action="installationextincteurvalidee">
<p> Annee de fabrication de l'extincteur : <input type="text" name="annee" required placeholder="Annee..." /></p>
<p> Emplacement de l'extincteur : <input type="text" name="emplacement" required placeholder="emplacement..." /></p>
<p> Observations : <input type="text" name="observations" required placeholder="observations..." /></p>
<p> Numero du Technicien : <input type="text" name="technicien" required placeholder="numero du technicien..." /></p>
<p> Conclusion : <input type="text" name="conclusion" required placeholder="Conclusion..."> </p>
<input type="submit" value="Valider">


</form>
</center>

</body>
</html>