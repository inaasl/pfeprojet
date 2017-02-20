<!DOCTYPE HTML>
<html>
   <head>
    <title></title>
    <meta charset="UTF-8" />
    <link href="style.css" rel="stylesheet" type="text/css">
  </head>

<body>
 <header class="header">
    	        <a class="logo" href="http://www.desentec.fr/"><img src="http://www.desentec.fr/wp-content/uploads/2015/06/logo-site.png"> </a>
    	       <p class="head"><center>Desentec - Protection incendie</center></p>
 </header>
  	<%! int statut;
	%>
	<%
	 if(session.getAttribute("statut")!=null)
	 {
	%>
	  <div id="container">
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
        <%@ page import= "java.util.List"%>
		
		
        <%! String login,password;
        %>
        <%
           		login =request.getParameter("login");
           		password=request.getParameter("password");
           		
      			session = request.getSession();
      			
      			List<Organe> organes=(List<Organe>)session.getAttribute("organes");
      			if(organes!=null) organes.clear();
      			session.setAttribute("organes",organes);
      		
      			String ajout=String.valueOf(session.getAttribute("ajout"));
      			if(ajout!=null) ajout="0";
      			session.setAttribute("ajout",ajout);
      			
      			List<Intervention> interv=(List<Intervention>)session.getAttribute("interv");
      			if(interv!=null) interv.clear();
      			session.setAttribute("Interv",interv);
      		
      			Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
      			pdf=null;
      			session.setAttribute("pdf",pdf);

           		
           		InitialContext ctx = new InitialContext();
    			Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
    			ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
    			session.setAttribute("login",login);
    			
    			try{
    			 List<Integer> liste = service.verificationCompte(login, password);
    			 session.setAttribute("numCompte",liste.get(2));
         		 if(liste.get(1) == 2){ 
         		    session.setAttribute("numPersonne",liste.get(0));
         		    session.setAttribute("statut",liste.get(1));
         			out.println("<meta http-equiv=\"refresh\" content=\"1; URL=accueilclient.jsp\"");
         		 }else if (liste.get(1) == 1){  
         			 session.setAttribute("numPersonne",liste.get(0));
         			 session.setAttribute("statut",liste.get(1));
         			 out.println("<meta http-equiv=\"refresh\" content=\"1; URL=accueiltechnicien.jsp\"");
         		 }else{
         			session.setAttribute("statut",liste.get(1));
         			out.println("<meta http-equiv=\"refresh\" content=\"1; URL=accueiladministrateur.jsp\"");
         		 }
    			}catch(CompteInconnuException e){
    				out.println("<meta http-equiv=\"refresh\" content=\"1; URL=index.jsp?result=compte inexistant\"");
    			}
        %>
        </div>
        	<%
	 }
	 else
	 	out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
	%>
</body>
</html>