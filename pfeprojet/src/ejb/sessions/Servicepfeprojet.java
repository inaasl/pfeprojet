package ejb.sessions;

import java.util.List;

import ejb.entites.Batiment;
import ejb.entites.Compte;
import ejb.entites.Corrective;
import ejb.entites.Entreprise;
import ejb.entites.Extincteur;
import ejb.entites.Installation;
import ejb.entites.Intervention;
import ejb.entites.MarqueExtincteur;
import ejb.entites.Organe;
import ejb.entites.Pdfgenere;
import ejb.entites.Pharmacie;
import ejb.entites.Piece;
import ejb.entites.Preventive;
import ejb.entites.Technicien;
import ejb.entites.TypeExtincteur;
import ejb.entites.Verification;

public interface Servicepfeprojet {
	
	public void checkbatiment(int numerobatiment) throws BatimentInconnuException;
	public List<Organe> rechercheOrganeDefectBatiment(int numerobatiment);
	
	public Compte ajouterEntreprise(String nom, String adresse,String email, String tel, String interlocuteur);
	public Compte ajouterTechnicien(String nom, String prenom, String adresse, String tel, String email);
	public void ajouterBatiment(String nomentreprise, String nom, String adresse) throws EntrepriseInconnueException;

	public Installation InstallationOrgane(String Obs, java.sql.Date date, int numtechnicien,int numbatiment,Organe O) throws TechnicienInconnuException, BatimentInconnuException, EntrepriseInconnueException;	
	
	public Extincteur ajoutExtincteur(int numbatiment, int Annee, String Emp, String Obs, String nommarque, String nomtype) throws BatimentInconnuException;
	public Pharmacie ajoutPharmacie(int numbatiment, int Annee, String Emp,String Obs, int capacite)throws BatimentInconnuException;
	
	
	public Intervention ajoutIntervention(int numbatiment, Intervention Interv, Organe O, String conclusion) throws BatimentInconnuException;
	public void ajoutOrgane(List<Organe> organes);
	public Pdfgenere ajoutpdf(List<Intervention> interventions);
	
	public Preventive MaintenancePreventiveOrgane(Organe O, String Obs, String Obsraj, int numerotechnicien, java.sql.Date date,boolean marche) throws OrganeInconnuException, TechnicienInconnuException;	
	public Preventive rechercheMaintenancePreventive(int numeroMaintenance);
	
	public Verification Verification(int numero,String Obs, String conclusion, int numerotechnicien, java.sql.Date date,boolean marche) throws OrganeInconnuException,TechnicienInconnuException,BatimentInconnuException;
	
	public Corrective MaintenanceCorrectiveOrgane(String Obs,java.sql.Date date,  int numerotechnicien, Organe O) throws TechnicienInconnuException;	
	public Extincteur remplacementextincteur(Extincteur E, int Annee, String Emp, String Obs, String nommarque, String nomtype,boolean marche);
	public Pharmacie remplacementpharmacie(Pharmacie P, int Annee, String Emp, String Obs, int capacite,boolean marche);
	public String rechercheObservationMaintenancecorr(int numeroOrgane);
	
	public String rechercheConclusionMaintenancecorrExtincteur(int numeroBatiment);
	public String rechercheConclusionMaintenancecorrPharmacie(int numeroBatiment);
	
	public List<Installation> getlisteInstallation();
	public List<Verification> getVerificationOrgane(Organe o);
	public List<Verification> getVerificationBatiment(int numeroBatiment);
	public List<Entreprise> getlisteEntreprises();
	public List<Technicien> getlisteTechniciens();
	public List<Pdfgenere> getlistePdfgenere();

	public List<Entreprise> rechercheEntreprise(String Nom) throws EntrepriseInconnueException;
	public Entreprise rechercheEntreprisenum(int Num) throws EntrepriseInconnueException;
	public Entreprise rechercheEntrepriseemail(String email) throws EntrepriseInconnueException;
	
	public List<Technicien> rechercheTechnicien(String Nom) throws TechnicienInconnuException;
	public Technicien rechercheTechniciennum(int Num) throws TechnicienInconnuException;
	public Technicien rechercheTechnicienemail(String email) throws TechnicienInconnuException;
	
	public Batiment recherchebatiment(String nomentreprise, String Nom) throws BatimentInconnuException, EntrepriseInconnueException;
	public List<Batiment> rechercheBatimentEntreprise(int numE);
	public Batiment rechercheBatimentnum(int Num) throws BatimentInconnuException;

	public Organe rechercheOrgane(int numero) throws OrganeInconnuException;
	public List<Organe> rechercheOrganeBatiment(int numeroBatiment);
	
	public Extincteur rechercheExtincteur(int numeroExtincteur);
	public List<Extincteur> rechercheExtincteurNum(int num);
	public List<Extincteur> rechercheExtincteurBatiment(int numeroBatiment);

	public List<Pharmacie> recherchePharmacieBatiment(int numeroBatiment);
	public Pharmacie recherchePharmacie(int numeroPharmacie);
	public List<Pharmacie> recherchePharmacieNum(int num);
	
	public List<Pdfgenere> recherchePdfgenereBatiment(int numeroBatiment);
	public Pdfgenere recherchePdfgenereNum(int numeroPdf);
	
	public List<Piece> recherchePieceIntervention(int numeroIntervention);
	
	public List<Intervention> rechercheInterventionPdf(int numeroPdf);
	public List<Intervention> rechercheInterventionOrgane(int numeroOrgane);
	
	public void ajouttypeextincteur(String nom);
	public List<TypeExtincteur> touslesTypeExtincteur();
	public TypeExtincteur rechercheTypeExtincteur(String Nom);
	public TypeExtincteur rechercheTypeExtincteurNom(String nom);
	
	public void ajoutmarqueextincteur(String nom);
	public List<MarqueExtincteur> touteslesMarqueExtincteur();
	public MarqueExtincteur rechercheMarqueExtincteur(String Nom);
	public MarqueExtincteur rechercheMarqueExtincteurNom(String nom);
	
	public String rechercheObservationVerification(int numeroOrgane);
	public String rechercheConclusionVerificationExtincteur(int numeroBatiment);
	public String rechercheConclusionVerificationPharmacie(int numeroBatiment);
	
	public String rechercheObservationMaintenanceprev(int numeroOrgane);
	public String rechercheConclusionMaintenanceprev(int numeroBatiment);
	
	public List<Integer> verificationCompte(String login, String pwd) throws CompteInconnuException;
	public void creercompteAdmin( String login, int admin,int statut);
	public String password();
	public void modifPassWord(int numero,String password);
	
	public Piece AjoutPiece(String nom,int numero) throws OrganeInconnuException;
	public void AjoutPieceBD(Piece P);
}
