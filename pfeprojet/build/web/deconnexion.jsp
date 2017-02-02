<!DOCTYPE HTML>
 <html>
  <head>
    <title>Deconnexion</title>
    <meta charset="UTF-8" />
    <link href="style.css" rel="stylesheet" type="text/css">
  </head>
<body>	
  <div id="bloc_page">
    <!-- HEADER -->
    <header>
    	        <a href="http://www.desentec.fr/"><img src="http://www.desentec.fr/wp-content/uploads/2015/06/logo-site.png"> </a>
    	       	<center><strong>Desentec - Protection incendie</strong></center>
   </header>
  	<%! int statut;
	%>
	<%
		session=request.getSession(false);
		if(session!=null)
			session.invalidate();
		out.println("<meta http-equiv=\"refresh\" content=\"1; URL=index.jsp\"");
	%>
   </div>
   </body>
   </html>