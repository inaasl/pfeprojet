package ejb.sessions;

import java.util.List;

import ejb.entites.Batiment;
import ejb.entites.Entreprise;
import ejb.entites.MarqueExtincteur;
import ejb.entites.Technicien;
import ejb.entites.TypeExtincteur;

public interface Servicepfeprojet {
	public void ajouterEntreprise(String nom, String adresse, String tel);
	public void ajouterTechnicien(String nom,String prenom, String adresse, String tel);
	public void ajouterBatiment(String nomentreprise, String nom, String adresse) throws EntrepriseInconnueException;


	public void InstallationExtincteur(int Annee, String Emp, String Obs, String Obsraj, java.sql.Date date, int numtechnicien, int numbatiment) throws TechnicienInconnuException, BatimentInconnuException, EntrepriseInconnueException;
	public void VerificationExtincteur(int numero,String Obs, String Obsraj, int numerotechnicien, java.sql.Date date/*, List<Piece> piecesajoutees*/) throws OrganeInconnuException,TechnicienInconnuException;
	public void MaintenanceCorrectiveExtincteur(int numeroExtincteur,String Obs, String Obsraj, int numerotechnicien, java.sql.Date date/*,List<Piece> piecesajoutees,List<Piece> piecessupprimees*/ ) throws OrganeInconnuException,TechnicienInconnuException;
	public void MaintenancePreventiveExtincteur(int numeroextincteur ,String Obs, String Obsraj, int numerotechnicien, java.sql.Date date/*, List<Piece> piecessupprimees,List<Piece> piecesajoutees*/) throws OrganeInconnuException,TechnicienInconnuException;

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
}
