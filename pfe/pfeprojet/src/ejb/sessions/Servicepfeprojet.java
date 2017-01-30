package ejb.sessions;

import java.io.IOException;
import java.util.List;

import ejb.entites.Batiment;
import ejb.entites.Entreprise;
import ejb.entites.Installation;
import ejb.entites.Intervention;
import ejb.entites.MarqueExtincteur;
import ejb.entites.Organe;
import ejb.entites.Technicien;
import ejb.entites.TypeExtincteur;
import ejb.entites.Verification;

public interface Servicepfeprojet {
	public void ajouterEntreprise(String nom, String adresse, String tel);
	public void ajouterTechnicien(String nom,String prenom, String adresse, String tel);
	public void ajouterBatiment(String nomentreprise, String nom, String adresse) throws EntrepriseInconnueException;


	public void InstallationExtincteur(int Annee, String Emp, String Obs, java.sql.Date date, int numtechnicien, int numbatiment,String nomtype,String nommarque) throws TechnicienInconnuException, BatimentInconnuException, EntrepriseInconnueException;
	public void MaintenancePreventiveExtincteur(int numeroextincteur ,String Obs, String Obsraj, int numerotechnicien, java.sql.Date date/*, List<Piece> piecessupprimees,List<Piece> piecesajoutees*/) throws OrganeInconnuException,TechnicienInconnuException;
	
	public void Verification(int numero,String Obs, String conclusion, int numerotechnicien, java.sql.Date date) throws OrganeInconnuException,TechnicienInconnuException;
	public void MaintenanceCorrectiveExtincteur(int numeroExtincteur,String Obs, String Obsraj, int numerotechnicien, java.sql.Date date/*,List<Piece> piecesajoutees,List<Piece> piecessupprimees*/ ) throws OrganeInconnuException,TechnicienInconnuException;
	

	public void listeIntervention(List<Intervention> interv,String conclu);
	public List<Installation> getlisteInstallation();
	
	public List<Verification> getVerification(Organe o);
	
	public List<Entreprise> getlisteEntreprises();
	public void affichagelisteEntreprise();
	public void affichagelisteBatiments(String NomEntreprise) throws EntrepriseInconnueException;
	public List<Technicien> getlisteTechniciens();
	public void affichagelisteTechnicien();
	
	public List<Entreprise> rechercheEntreprise(String Nom) throws EntrepriseInconnueException;
	public Batiment recherchebatiment(String nomentreprise, String Nom) throws BatimentInconnuException, EntrepriseInconnueException;
	public void affichageBatiment(int numerobatiment) throws BatimentInconnuException;
	public Entreprise rechercheEntreprisenum(int Num) throws EntrepriseInconnueException;
	public Batiment rechercheBatimentnum(int Num) throws BatimentInconnuException;
	public Technicien rechercheTechniciennum(int Num) throws TechnicienInconnuException;
	public List<Technicien> rechercheTechnicien(String Nom) throws TechnicienInconnuException;
	
	public void ajouttypeextincteur(String nom);
	public List<TypeExtincteur> touslesTypeExtincteur();
	public void ajoutmarqueextincteur(String nom);
	public List<MarqueExtincteur> touteslesMarqueExtincteur();
	public TypeExtincteur rechercheTypeExtincteur(String Nom);
	public MarqueExtincteur rechercheMarqueExtincteur(String Nom);

}
