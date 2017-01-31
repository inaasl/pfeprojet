package client;

import java.io.IOException;
import java.sql.Date;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import ejb.sessions.BatimentInconnuException;
import ejb.sessions.EntrepriseDejaExistanteException;
import ejb.sessions.EntrepriseInconnueException;
import ejb.sessions.OrganeInconnuException;
import ejb.sessions.ServicepfeprojetRemote;
import ejb.sessions.TechnicienInconnuException;


public class Main {
	public static void main(String[] args) throws EntrepriseDejaExistanteException, EntrepriseInconnueException, BatimentInconnuException, TechnicienInconnuException, OrganeInconnuException, IOException{
		try {
			InitialContext ctx = new InitialContext();
			System.out.println("Acces au service Remote");
			Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
			ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;

			// Ajout Entreprises et Batiments
			
			service.ajouterEntreprise("Euratech","9,Lille","0612523645");
			service.ajouterEntreprise("TechMa", "7,Loos","0624587496");
			service.ajouterBatiment("Euratech", "BatimentA", "28, Lille");
			service.ajouterBatiment("Euratech", "BatimentB", "57, Lille");
			service.ajouterBatiment("TechMa", "BatimentA1", "7,Lille");
			
			
			// Ajout Types extincteurs
			service.ajouttypeextincteur("EPA 6L");
			service.ajouttypeextincteur("CO² 2KG");
			service.ajouttypeextincteur("P6 KG pp");
			
			// Ajout Marques extincteurs
			service.ajoutmarqueextincteur("Marque 1");
			service.ajoutmarqueextincteur("Marque 2");			
			service.ajoutmarqueextincteur("Marque 3");
			
			// Ajout Techniciens
			service.ajouterTechnicien("Dupont","Ronaldo", "1,Villeneuve d'ascq","0611223344");
			service.ajouterTechnicien("Dubois","CR7", "10, Villeneuve d'ascq", "0655667788");
			
			}
		catch (NamingException e) {
			System.out.println("erreur acces au serveur de noms");
		}
	}
}
