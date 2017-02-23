<html>
<head>
<title>Ajout d'un désenfumage naturel</title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" media="screen and (max-width: 2560px)">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
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
	<%@ page import="java.util.List"%>
	<%@ page import="java.util.ArrayList"%>
	
	<%!String numBat,ajout,commandeOuvrant,nomOuvrant,observationOuvrant;
	int num, i;
	Ouvrant Ouvrantcourant;
	List<Ouvrant> ouvrants;
	%>
	
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
		if(ajout!=null)
			session.setAttribute("ajout",ajout);
		else {
			ajout=String.valueOf(session.getAttribute("ajout"));
		}

	if(ajout.compareTo("0")==0){
	%>
<form action="installationdesenfumagenaturelvalidee.jsp" method="post">
		 <fieldset>
		 <legend><b>Installation Désenfumage Naturel</b></legend>
		<br>
		<table>
		<tr>
			<td> <label for="emplacement"><i>Emplacement <font color="#ff0000">*</font></i></label></td>
			<td><textarea name="emplacement" rows="5" cols="47" required placeholder="emplacement..."></textarea></td></tr>
	  <tr></tr>
	 <tr></tr>
	 <tr></tr>
	 <tr></tr>
	 <tr><td>
        <label for="cartouches"><i>Cartouches <font color="#ff0000">*</font></i></label>
        </td>	  
		<td><textarea name="cartouches" rows="3" cols="47" required placeholder="cartouches..."></textarea>
	 </td></tr>
     <tr></tr>
	 </table>
	 <div class="panel panel-primary">
        <div class="panel-heading">Ouvrants</div>        
        <table class="table table-bordered table-striped">
          <thead>
            <tr>
             <th class="col-sm-4">Commande</th>
             <th class="col-sm-4">Ouvrant</th>
             <th class="col-sm-4">Observation</th>
             <th class="col-sm-2"></th>
            </tr>
          </thead>
		 <tbody>
            <tr v-for="ouvrant in ouvrants">
              <td>{{ ouvrant.commande }}</td>
              <td>{{ ouvrant.nom }}</td> 
              <td>{{ ouvrant.observation }}</td> 
              <td><button type="button" class="btn btn-warning btn-block" v-on:click="suppression($index)">Supprimer</button></td>
            </tr>  
            <tr>
              <td><input name="commandeOuvrant" type="text" class="form-control" v-model="inputCommande" v-el:modif placeholder="Commande"></td>
              <td><input name="nomOuvant" type="text" class="form-control" v-model="inputNom" v-el:modif placeholder="Nom"></td>
              <td><input name="observationOuvrant" type="text" class="form-control" v-model="inputObservation" v-el:modif placeholder="Observation"></td>
              <td colspan="2"><button type="button" class="btn btn-primary btn-block" v-on:click="ajouter()">Ajouter</button></td>
            </tr>
          </tbody>
          </table>
           <div class="panel-footer">
          &nbsp
          <button type="button" class="button btn btn-xs btn-warning" v-on:click="toutSupprimer">Tout supprimer</button>
        </div>
      </div>
		<br><center><input type="submit" value="Valider"> </center>
		</fieldset>
		</form>
		</div>
	<script src="http://cdn.jsdelivr.net/vue/1.0.10/vue.min.js"></script>
     <script type="text/javascript">
    new Vue({
        el: '#container',
        data: {
          ouvrants: [],
          supprimer: [],
          inputCommande: '',
          inputNom: '',
          inputObservation: '',
        },
        methods: {
          suppression: function(index) {
            this.supprimer.push(this.ouvrants[index]);
            this.ouvrants.splice(index, 1);
          },
          toutSupprimer: function() {
            this.supprimer = this.supprimer.concat(this.ouvrants);
            this.ouvrants = [];
          },
          ajouter: function() {
            this.ouvrants.push({commande: this.inputCommande, nom: this.inputNom, observation: this.inputObservation});
            $.ajax({
                url: "installationdesenfumagenaturel.jsp",
                data: {
                	commandeOuvrant: this.inputCommande,
                	nomOuvrant: this.inputNom,
                	observationOuvrant: this.inputObservation,
                	etatajout: 'oui'
                },
                });
            <% 
               ajout=request.getParameter("etatajout");
         	   if(ajout!=null){
         		   commandeOuvrant=request.getParameter("commandeOuvrant");
         		   nomOuvrant=request.getParameter("nomOuvrant");
         		   observationOuvrant=request.getParameter("observationOuvrant");
         		   Ouvrantcourant=service.ajoutOuvrant(nomOuvrant,observationOuvrant,commandeOuvrant);
				   if(ouvrants==null){
					   ouvrants=new ArrayList<Ouvrant>();
				   }
				   ouvrants.add(Ouvrantcourant);
         	   }
			%>
			this.inputCommande = '';
			this.inputObservation ='';
			this.inputNom = '';
			
          },
        }
      });
    </script>
    		
	<%
	   session.setAttribute("ouvrants",ouvrants);
	 }
	else {%>
	<form action="installationdesenfumagenaturelvalidee.jsp" method="post">
	<fieldset>
	<legend><b>Installation Désenfumage Naturel</b></legend>
	<br>
	<table>
	<tr>
	<td><label for="emplacement"><i>Emplacement <font color="#ff0000">*</font></i></label></td>
	<td><textarea name="emplacement" rows="5" cols="47" required placeholder="emplacement..."></textarea></td></tr>
	<tr></tr>
	<tr></tr>
	<tr><td>
    <label for="cartouches"><i>Cartouches <font color="#ff0000">*</font></i></label>
    </td>	  
	<td><textarea name="cartouches" rows="3" cols="47" required placeholder="cartouches..."></textarea>
	 </td></tr>
     <tr></tr>
	 </table>
	<br><center><input type="submit" value="Valider"> </center>
	</fieldset>
	</form>
	<%}
	 }
	 }
	 else
	 	out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
	%>
</body>
</html>