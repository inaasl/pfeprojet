<html>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.URLConnection"%>
<%@ page import="java.io.* "%>
<%@ page import="ejb.sessions.*"%>
<%@ page import="ejb.entites.* "%>
<%@ page import="javax.naming.InitialContext"%>
<%@ page import="javax.naming.NamingException"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<head>
<title>Intervention</title>
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
		<li><a href="#">Déconnexion</a>
		</li>
		</ul>
	</header>
  <div id="container">
	<%!
	List<Intervention> Interv;
	List<Intervention>Interventionajoutee=new ArrayList<Intervention>();
	String conclu,numBat,ajout,nomPiece,nomAlarme;
	Pdfgenere pdf;
	int numB,i,numAlarme;
	List<Piece> listP = new ArrayList<Piece>() ;
	Piece piececourante;
	List<Organe> organes;
	List<Alarme> A=new ArrayList<Alarme>();
	%>
<%
	session = request.getSession();

	pdf=(Pdfgenere)session.getAttribute("pdf");
	pdf=null;
	session.setAttribute("pdf",pdf);

	
	InitialContext ctx = new InitialContext();
	Object obj = ctx.lookup(
	"ejb:pfeprojet/pfeprojetSessions/" + "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
	ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
	
	numBat=String.valueOf(session.getAttribute("numBatiment"));
	numB=Integer.parseInt(numBat);
	
	ajout=String.valueOf(session.getAttribute("ajout"));
	if(ajout==null){
		ajout="0";
	}
	if(ajout.compareTo("0")==0){
		conclu = request.getParameter("conclusion");
		Interv = (List<Intervention>)session.getAttribute("interv");
		if(Interv.get(0) instanceof Preventive && Interv.get(0).getOrgane() instanceof Alarme){
		A=service.rechercheAlarmeBatiment(numB);
		%>
		<div class="panel panel-primary">
        <div class="panel-heading">Pieces</div>        
        <table class="table table-bordered table-striped">
          <thead>
            <tr>
             <th class="col-sm-4">Nom de la pièce</th>
             <th class="col-sm-4">Numéro Alarme </th>
             <th class="col-sm-2"></th>
            </tr>
          </thead>
		 <tbody>
            <tr v-for="piece in pieces">
              <td>{{ piece.nom }}</td>
              <td>{{ piece.alarme }}</td> 
              <td><button type="button" class="btn btn-warning btn-block" v-on:click="suppression($index)">Supprimer</button></td>
            </tr>  
            <tr>
              <td><input name="nomPiece" type="text" class="form-control" v-model="inputNom" v-el:modif placeholder="Nom"></td>
              <td><select name="numAlarme" id="liste" class="class_select" v-model="inputAlarme">
              <%
              for(i=0;i<A.size();i++){
            	  out.println("<option value=" + A.get(i).getNumero() + ">"
							+ A.get(i).getNumero() + "</option>");
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
           this.pieces.push({nom: this.inputNom, alarme: this.inputAlarme});
            $.ajax({
                url: "interventionvalidee.jsp",
                data: {
                	nomPiece: this.inputNom,
                	numAlarme: this.inputAlarme,
                	etatajout: 'oui'
                },
                });
            <% 
               ajout=request.getParameter("etatajout");
         	   if(ajout!=null){
                   nomPiece=request.getParameter("nomPiece");
                   numAlarme=Integer.parseInt(request.getParameter("numAlarme"));
                   piececourante=service.AjoutPiece(nomPiece,numAlarme);
				   listP.add(piececourante);
         	   }
			%>
			this.inputNom = '';
          },
        }
      });
    </script>
			
			<%
		session.setAttribute("conclusion",conclu);
		out.println("<center><br>Intervention effectuée avec succès");
		out.println("<center><form action =\"maintenanceprevalarmeajout.jsp\"><input type=\"submit\" value=\"Ajouter les pièces\"></center></form> ");
		session.setAttribute("listP",listP);
		}
		
		else {
			for(int i=0;i<Interv.size();i++){
				Interventionajoutee.add(service.ajoutIntervention(numB,Interv.get(i),Interv.get(i).getOrgane(), conclu));
			}
			Interv.clear();
			session.setAttribute("interv",Interv);
			pdf=service.ajoutpdf(Interventionajoutee);
			session.setAttribute("pdf",pdf);
			
			out.println("<center><br>Intervention effectuée avec succès");
			out.println("<table><tr><td><input type=\"button\" name=\"Imprimerpdf\" value=\"Imprimer la fiche de l'intervention\"  onclick=\"self.location.href='interventionpdf.jsp'\"></button></td></tr>");
			Interventionajoutee.clear();
			out.println("<tr><td><input type=\"button\" name=\"Fichebatiment\" value=\"Retour a la fiche du batiment \" onclick=\"self.location.href='fichebatiment.jsp'\"></button></td></tr></table>");
			out.println("</center>");
		}
	}
	else {
		organes=(List<Organe>)session.getAttribute("organes");
		service.ajoutOrgane(organes);
		organes.clear();
		session.setAttribute("organes",organes);
		if(ajout.compareTo("1")==0){
			out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationextincteur.jsp\">");
		}
		else {
			if(ajout.compareTo("2")==0){
				out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrextincteur.jsp\">");
			}
			else{
				if (ajout.compareTo("3")==0) {
				out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenanceprevextincteur.jsp\">");
				}
				else {
					if(ajout.compareTo("4")==0) {
						out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationpharmacie.jsp\">");
					}
					else {
						if(ajout.compareTo("5")==0) {
							out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrpharmacie.jsp\">");
						}
						else {
							if(ajout.compareTo("10")==0) {
								out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationcoupefeu.jsp\">");
							}
							else {
								if(ajout.compareTo("11")==0) {
									out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrcoupefeu.jsp\">");
								}
								else {
									if(ajout.compareTo("12")==0) {
										out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenanceprevcoupefeu.jsp\">");
									}
									else {
										if(ajout.compareTo("16")==0) {
											out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationpoteaux.jsp\">");
										}
										else {
											if(ajout.compareTo("17")==0) {
												out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrpoteaux.jsp\">");
											}
											else {
												if(ajout.compareTo("7")==0){
													out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationeclairage.jsp\">");
												}
												else {
													if(ajout.compareTo("8")==0){
														out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorreclairage.jsp\">");
													}
													else {
														if(ajout.compareTo("9")==0){
															out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancepreveclairage.jsp\">");
														}
														else {
															if(ajout.compareTo("13")==0){
																out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationria.jsp\">");
															}
															else {
																if(ajout.compareTo("14")==0){
																	out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrria.jsp\">");
																}
																else {
																	if(ajout.compareTo("15")==0){
																		out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenanceprevria.jsp\">");
																	}
																	else {
																		if(ajout.compareTo("21")==0){
																			out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationalarme.jsp\">");
																		}							
																		else{
																			if(ajout.compareTo("23")==0){
																				out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenanceprevalarme.jsp\">");
																			}
																			else {
																				if(ajout.compareTo("22")==0){
																					out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorralarme.jsp\">");
																				}
																				else {
																					if(ajout.compareTo("18")==0) {
																						out.println("<meta http-equiv=\"refresh\" content=\"1; URL=verificationdesenfumagenaturel.jsp\">");
																					}
																					else {
																						if(ajout.compareTo("20")==0) {
																							out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenanceprevdesenfumagenaturel.jsp\">");
																						}
																						else {
																							if(ajout.compareTo("19")==0) {
																								out.println("<meta http-equiv=\"refresh\" content=\"1; URL=maintenancecorrdesenfumagenaturel.jsp\">");
																							}
																						}
																					}
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		ajout="0";
		session.setAttribute("ajout",ajout);
	}
%>
</div>
	<%
	 }
	 }
	 else
	 	out.println("</header><div id=\"container\"><center><br> VEUILLEZ VOUS RECONNECTER   </center> <meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\"></div>");
	%>
</body>
</html>