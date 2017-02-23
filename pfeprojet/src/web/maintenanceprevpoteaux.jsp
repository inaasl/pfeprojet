<html>
<head>
<title>Maintenance Préventive : Poteaux Incendie </title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="datatables.css" />
    <script type="text/javascript" src="jquery.dataTables.js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.12/datatables.min.css"/>
 
    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.12/datatables.min.js"></script>

    <script type="text/javascript" charset="utf-8">
     $(document).ready(function(){
     $('#datatables').dataTable();
    
     })
    </script>
    
    
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
	<%@ page import="java.util.List"%>
	<%@ page import="java.util.ArrayList"%>
	<%@ page import="javax.naming.InitialContext"%>
	<%@ page import="javax.naming.NamingException"%>

	<%!String numBat,conclusion, observation, nomPiece;
	int num,i,numPoteaux;
	List<Poteaux> P = new ArrayList<Poteaux>();
	List<Piece> listP = new ArrayList<Piece>() ;
	Piece piececourante;
	List<Organe> organes;
	String ajout;
	%>
	<%
	
		session = request.getSession();
		InitialContext ctx = new InitialContext();
		Object obj = ctx.lookup(
				"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
		numBat = String.valueOf(session.getAttribute("numBatiment"));
		session.setAttribute("numBatiment", numBat);
 		num=Integer.parseInt(numBat);
		P.clear();

		List<Organe> organes=(List<Organe>)session.getAttribute("organes");
		if(organes!=null) organes.clear();
		session.setAttribute("organes",organes);
		
		String ajout=String.valueOf(session.getAttribute("ajout"));
		if(ajout!=null) ajout="0";
		session.setAttribute("ajout",ajout);
		
		Pdfgenere pdf=(Pdfgenere)session.getAttribute("pdf");
		pdf=null;
		session.setAttribute("pdf",pdf);

		
		P=service.recherchePoteauxBatiment(num);
		out.println("<br><center><h3>Maintenance préventive des Poteaux Incendie</h3></center><br>");
		out.println("<center><input type=\"button\" name=\"AjoutPoteaux\" value=\"Ajouter un poteau incendie\"  onclick=\"self.location.href='installationpoteaux.jsp?ajout=18'\"></button></center>");
		out.println("<br><center><h4> Liste des Poteaux Incendie </h4></center>");
		// Tableau
		out.println("<br><form action=\"maintenanceprevvalidee.jsp\">");
		out.print("<br> <table id=\"datatables\" class=\"display\" >");
		out.print("<thead><tr><th> N° Poteau Incendie </th><th> Emplacement </th><th> Diamètre </th><th>  Pression Statique </th><th> Pression 60 </th><th> Pression 1 bar </th><th>Observation</th> <th> Etat défecteux </th></tr>");
		out.print("</thead><tbody>");
	      
		for(i=0;i<P.size();i++){
					observation=service.rechercheObservationMaintenanceprev(P.get(i).getNumero());
					out.println(" <tr><td > " + P.get(i).getNumero()+
						"</td> <td>" + P.get(i).getEmplacement()+
						"</td> <td >" + P.get(i).getDiametre()+
						"</td> <td >" + P.get(i).getPressionstat()+
						"</td> <td >" + P.get(i).getPression60()+
						"</td> <td >" + P.get(i).getPression1bar()+
						"</td> <td> <input type=\"text\" name="+i+" value="+observation+
						"></td><td><INPUT id=\"oui\" type= \"radio\" name="+(i+100)+" value=\"oui\"><label for=\"oui\">OUI</label>&nbsp;&nbsp;&nbsp;<INPUT id=\"non\" type= \"radio\" name="+(i+100)+" value=\"non\"><label for=\"non\">NON</label></td></tr>"
						);
		}
		conclusion=service.rechercheConclusionMaintenanceprevPoteaux(num);
		out.println("</tbody></table><br><br>"); 
		%>
		<div class="panel panel-primary">
        <div class="panel-heading">Pieces</div>        
        <table class="table table-bordered table-striped">
          <thead>
            <tr>
             <th class="col-sm-4">Nom de la pièce</th>
             <th class="col-sm-4">Numéro Poteau Incendie</th>
             <th class="col-sm-2"></th>
            </tr>
          </thead>
		 <tbody>
            <tr v-for="piece in pieces">
              <td>{{ piece.nom }}</td>
              <td>{{ piece.poteaux }}</td> 
              <td><button type="button" class="btn btn-warning btn-block" v-on:click="suppression($index)">Supprimer</button></td>
            </tr>  
            <tr>
              <td><input name="nomPiece" type="text" class="form-control" v-model="inputNom" v-el:modif placeholder="Nom"></td>
              <td><select name="numPoteaux" id="liste" class="class_select" v-model="inputPoteaux">
              <%
              for(i=0;i<P.size();i++){
            	  out.println("<option value=" + P.get(i).getNumero() + ">"
							+ P.get(i).getNumero() + "</option>");
              }
              %>
            </select></td>
              <td colspan="2"><button type="button" class="btn btn-primary btn-block" v-on:click="ajouter()">Ajouter</button></td>
            </tr>
          </tbody>
          </table>
           <div class="panel-footer">
          &nbsp
          <button type="button" class="button btn btn-xs btn-warning" v-on:click="toutSupprimer">Tout supprimer</button>
        </div>
      </div>
      

		
		<%
		out.println("<center><table><tr><td>Conclusion</td> <td></td> <td><textarea name=\"Conclusion\" rows=\"5\" cols=\"47\" required>"+conclusion+"</textarea></td></tr></table>");
		out.println("<br><input type=\"submit\" value=\"Valider\"></center></form>");
		session.setAttribute("organeslist",P);
	%>
	</div>
	 <script src="http://cdn.jsdelivr.net/vue/1.0.10/vue.min.js"></script>
     <script type="text/javascript">
    new Vue({
        el: '#container',
        data: {
          pieces: [],
          supprimer: [],
          inputNom: '',
        },
        methods: {
          suppression: function(index) {
            this.supprimer.push(this.pieces[index]);
            this.pieces.splice(index, 1);
          },
          toutSupprimer: function() {
            this.supprimer = this.supprimer.concat(this.pieces);
            this.pieces = [];
          },
          ajouter: function() {
            this.pieces.push({nom: this.inputNom, poteaux: this.inputPoteaux});
            $.ajax({
                url: "maintenanceprevpoteaux.jsp",
                data: {
                	nomPiece: this.inputNom,
                	numPoteaux: this.inputPoteaux,
                	etatajout: 'oui'
                },
                });
            <% 
               ajout=request.getParameter("etatajout");
         	   if(ajout!=null){
                   nomPiece=request.getParameter("nomPiece");
                   numPoteaux=Integer.parseInt(request.getParameter("numPoteaux"));
                   piececourante=service.AjoutPiece(nomPiece,numPoteaux);
				   listP.add(piececourante);
         	   }
			%>
			this.inputNom = '';
          },
        }
      });
    </script>
	<%
     session.setAttribute("listP",listP);
	 }
	 }
	 else
	 	out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
	%>
</body>
</html>