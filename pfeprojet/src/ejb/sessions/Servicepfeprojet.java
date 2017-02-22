package ejb.sessions;

import java.util.List;

import ejb.entites.Alarme;
import ejb.entites.Batiment;
import ejb.entites.Compte;
import ejb.entites.Corrective;
import ejb.entites.Coupefeu;
import ejb.entites.Eclairage;
import ejb.entites.Entreprise;
import ejb.entites.Extincteur;
import ejb.entites.Installation;
import ejb.entites.Intervention;
import ejb.entites.MarqueAlarme;
import ejb.entites.MarqueEclairage;
import ejb.entites.MarqueExtincteur;
import ejb.entites.Organe;
import ejb.entites.Pdfgenere;
import ejb.entites.Pharmacie;
import ejb.entites.Piece;
import ejb.entites.Poteaux;
import ejb.entites.Preventive;
import ejb.entites.RIA;
import ejb.entites.Signaletique;
import ejb.entites.Technicien;
import ejb.entites.TypeAES;
import ejb.entites.TypeAlarme;
import ejb.entites.TypeBatterie;
import ejb.entites.TypeBatterieAES;
import ejb.entites.TypeCoupefeu;
import ejb.entites.TypeEclairage;
import ejb.entites.TypeExtincteur;
import ejb.entites.TypeRia;
import ejb.entites.Typetelecommande;
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
	public Coupefeu ajoutCoupefeu(int numbatiment, String Emp,String Obs, TypeCoupefeu type)throws BatimentInconnuException;
	public Poteaux ajoutPoteaux(int numbatiment,String Emp,String Obs, int diametre, int pressionstat,int pression60,int pression1bar)throws BatimentInconnuException;
	public Eclairage ajoutEclairage(int numbatiment,String Emp,String Obs,TypeEclairage type, MarqueEclairage marque, boolean presence,boolean fonctionne,Typetelecommande typetel)throws BatimentInconnuException;
	public Signaletique ajoutSignaletique(int numbatiment,String Emp,String Obs)throws BatimentInconnuException;
	public RIA ajoutRia(int numbatiment,String Emp, String Obs, TypeRia type,int pressionstat,int pressiondynam,int portee)throws BatimentInconnuException;
	public Alarme ajoutAlarme(int numbatiment,String Emp,String Obs,MarqueAlarme marquealarme,TypeAlarme typealarme,int annee,int nombrebatterie,int xbatterie,int ybatterie,
			int hbatterie,TypeBatterie typebatterie,int testvoltbatterie,int testampbatterie,int testchargeurbatterie,int nboptique,
			String optique,int nbionique,String obsionique,int nbthermique,String thermique,int nbthermov,String thermov,
			int nbflamme,String flamme,int nbaspiration,String aspiration,int nbreport,String report,int nbmanuel,String manuel,
			int nbsonore,String sonore,int nblumineux,String lumineux,int nbAES,TypeAES typeaes, int nbbatterieaes, int xbatterieaes,
			int ybatterieaes,int hbatterieaes,TypeBatterieAES typebatterieaes, int testvoltaes,int testampaes, int testchargeuraes ) throws BatimentInconnuException;
	
	
	public String ObservationsAlarme(String observation,String optique,String ionique,String thermique, String thermov,String flamme,
			String aspiration, String report, String manuel,String sonore,String lumineux);
	
	
	public String testAlarme(int testvoltbatterie,int testampbatterie,int chargeur,int testvoltaes,
			int testampaes,int testchargeuraes);
	
	
	public Intervention ajoutIntervention(int numbatiment, Intervention Interv, Organe O, String conclusion) throws BatimentInconnuException;
	public void ajoutOrgane(List<Organe> organes);
	public Pdfgenere ajoutpdf(List<Intervention> interventions);
	public Pdfgenere ajoutnewpdf();
	
	public Preventive MaintenancePreventiveOrgane(Organe O, String Obs, String Obsraj, int numerotechnicien, java.sql.Date date,boolean marche) throws OrganeInconnuException, TechnicienInconnuException;	
	public Preventive MaintenancePreventiveAlarme(Organe O, String Obs, String Obsraj, int numerotechnicien, 
			java.sql.Date date, boolean marche) throws OrganeInconnuException, TechnicienInconnuException;
	public Preventive rechercheMaintenancePreventive(int numeroMaintenance);
	
	public Verification Verification(int numero,String Obs, String conclusion, int numerotechnicien, java.sql.Date date,boolean marche) throws OrganeInconnuException,TechnicienInconnuException,BatimentInconnuException;
	public Alarme verificationAlarme(Alarme A,int testvoltbatterie,int testampbatterie,int testchargeurbatterie,String optique,String obsionique,String thermique,String thermov,
			String flamme,String aspiration,String report,String manuel,String sonore,String lumineux,int testvoltaes,int testampaes, int testchargeuraes);
	
	
	public Corrective MaintenanceCorrectiveOrgane(String Obs,java.sql.Date date,  int numerotechnicien, Organe O) throws TechnicienInconnuException;	
	public Extincteur remplacementextincteur(Extincteur E, int Annee, String Emp, String Obs, String nommarque, String nomtype,boolean marche);
	public Pharmacie remplacementpharmacie(Pharmacie P, int Annee, String Emp, String Obs, int capacite,boolean marche);
	public Coupefeu remplacementcoupefeu(Coupefeu C, String Emp, String Obs,TypeCoupefeu type ,boolean marche);
	public Poteaux remplacementpoteaux(Poteaux P, String Emp,String Obs, int diametre,int pressionstat,int pression60,int pression1bar,boolean marche);
	public Eclairage remplacementeclairage(Eclairage E,String Emp,String Obs, TypeEclairage type, MarqueEclairage marque, boolean presence,boolean fonctionne,Typetelecommande typetel,boolean marche);
	public RIA remplacementria(RIA R,String Emp,String Obs,TypeRia type,int pressionstat,int pressiondynam,int portee, boolean marche);
	public Alarme remplacementalarme(Alarme A, String Emp,String Obs,MarqueAlarme marquealarme,TypeAlarme typealarme,int annee,int nombrebatterie,int xbatterie,int ybatterie,
			int hbatterie,TypeBatterie typebatterie,int testvoltbatterie,int testampbatterie,int testchargeurbatterie,int nboptique, 
			String optique,int nbionique,String obsionique,int nbthermique,String thermique,int nbthermov,String thermov,
			int nbflamme,String flamme,int nbaspiration,String aspiration,int nbreport,String report,int nbmanuel,String manuel,
			int nbsonore,String sonore,int nblumineux,String lumineux,int nbAES,TypeAES typeaes, int nbbatterieaes, int xbatterieaes,
			int ybatterieaes,int hbatterieaes,TypeBatterieAES typebatterieaes, int testvoltaes,int testampaes, int testchargeuraes,boolean marche );
	
	
	
	public String rechercheObservationMaintenancecorr(int numeroOrgane);
	
	public String rechercheConclusionMaintenancecorrExtincteur(int numeroBatiment);
	public String rechercheConclusionMaintenancecorrPharmacie(int numeroBatiment);
	public String rechercheConclusionMaintenancecorrCoupefeu(int numeroBatiment);
	public String rechercheConclusionMaintenancecorrPoteaux(int numeroBatiment);
	public String rechercheConclusionMaintenancecorrEclairage(int numeroBatiment);
	public String rechercheConclusionMaintenancecorrRia(int numeroBatiment);
	public String rechercheConclusionMaintenancecorrAlarme(int numeroBatiment);
	
	
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
	public Organe rechercheOrganeNum(int numeroOrgane);

	public List<Extincteur> rechercheExtincteurBatiment(int numeroBatiment);
	public List<Pharmacie> recherchePharmacieBatiment(int numeroBatiment);
	public List<Coupefeu> rechercheCoupefeuBatiment(int numeroBatiment);
	public List<Poteaux> recherchePoteauxBatiment(int numeroBatiment);
	public List<Eclairage> rechercheEclairageBatiment(int numeroBatiment);
	public List<RIA> rechercheRiaBatiment(int numeroBatiment);
	public List<Alarme> rechercheAlarmeBatiment(int numeroBatiment);
	
	public List<Pdfgenere> recherchePdfgenereBatiment(int numeroBatiment);
	public Pdfgenere recherchePdfgenereNum(int numeroPdf);
	
	public List<Piece> recherchePieceIntervention(int numeroIntervention);
	
	public List<Intervention> rechercheInterventionPdf(int numeroPdf);
	public List<Intervention> rechercheInterventionOrgane(int numeroOrgane);
	public Intervention rechercheInterventionNum(int numeroIntervention);
	
	public void ajouttypeextincteur(String nom);
	public List<TypeExtincteur> touslesTypeExtincteur();
	public TypeExtincteur rechercheTypeExtincteur(String Nom);
	public TypeExtincteur rechercheTypeExtincteurNom(String nom);
	
	public void ajouttyperia(String nom);
	public List<TypeRia> touslesTypeRIA();
	public TypeRia rechercheTypeRia(String Num);
	public TypeRia rechercheTypeRiaNom(String nom);
	
	public void ajouttypecoupefeu(String nom);
	public List<TypeCoupefeu> touslesTypeCoupefeu();
	public TypeCoupefeu rechercheTypeCoupefeu(String Num);
	public TypeCoupefeu rechercheTypeCoupefeuNom(String nom);
	
	public void ajouttypealarme(String nom);
	public List<TypeAlarme> touslesTypeAlarme();
	public TypeAlarme rechercheTypeAlarmeNom(String nom);
	public TypeAlarme rechercheTypeAlarme(String Num);
	
	public void ajoutmarquealarme(String nom);
	public List<MarqueAlarme> touteslesMarqueAlarme();
	public MarqueAlarme rechercheMarqueAlarme(String Num);
	public MarqueAlarme rechercheMarqueAlarmeNom(String nom);
	
	public void ajouttypebatterie(String nom);
	public List<TypeBatterie> touslesTypeBatterie();
	public TypeBatterie rechercheTypeBatterieNom(String nom);
	public TypeBatterie rechercheTypeBatterie(String Num);
	
	public void ajouttypebatterieaes(String nom);
	public List<TypeBatterieAES> touslesTypeBatterieAES();
	public TypeBatterieAES rechercheTypeBatterieaes(String Num);
	public TypeBatterieAES rechercheTypeBatterieaesNom(String nom);
	
	public void ajouttypeaes(String nom);
	public List<TypeAES> touslesTypeAES();
	public TypeAES rechercheTypeaes(String Num);
	public TypeAES rechercheTypeaesNom(String nom);
	
	
	public void ajouttypeeclairage(String nom);
	public TypeEclairage rechercheTypeEclairage(String Num);
	public TypeEclairage rechercheTypeEclairageNom(String nom);
	public void ajoutmarqueeclairage(String nom);
	public MarqueEclairage rechercheMarqueEclairage(String Num);
	public MarqueEclairage rechercheMarqueEclairageNom(String nom);
	public void ajouttypetelecommande(String nom);
	public Typetelecommande rechercheTypeTelecommande(String Num);
	public Typetelecommande rechercheTypeTelecommandeNom(String nom);
	
	public List<TypeEclairage> touslesTypeEclairage();
	public List<MarqueEclairage> touteslesMarqueEclairage();
	public List<Typetelecommande> touslesTypetelecommande();
	
	
	public void ajoutmarqueextincteur(String nom);
	public List<MarqueExtincteur> touteslesMarqueExtincteur();
	public MarqueExtincteur rechercheMarqueExtincteur(String Nom);
	public MarqueExtincteur rechercheMarqueExtincteurNom(String nom);
	
	public String rechercheObservationVerification(int numeroOrgane);
	public String rechercheConclusionVerificationExtincteur(int numeroBatiment);
	public String rechercheConclusionVerificationPharmacie(int numeroBatiment);
	public String rechercheConclusionVerificationCoupefeu(int numeroBatiment);
	public String rechercheConclusionVerificationPoteaux(int numeroBatiment);
	public String rechercheConclusionVerificationEclairage(int numeroBatiment);
	public String rechercheConclusionVerificationRia(int numeroBatiment);
	public String rechercheConclusionVerificationAlarme(int numeroBatiment);
	
	public String rechercheObservationMaintenanceprev(int numeroOrgane);
	public String rechercheConclusionMaintenanceprevExtincteur(int numeroBatiment);
	public String rechercheConclusionMaintenanceprevCoupefeu(int numeroBatiment);
	public String rechercheConclusionMaintenanceprevPoteaux(int numeroBatiment);
	public String rechercheConclusionMaintenanceprevEclairage(int numeroBatiment);
	public String rechercheConclusionMaintenanceprevRia(int numeroBatiment);
	public String rechercheConclusionMaintenanceprevAlarme(int numeroBatiment);
	
	public List<Integer> verificationCompte(String login, String pwd) throws CompteInconnuException;
	public void creercompteAdmin( String login, int admin,int statut);
	public String password();
	public void modifPassWord(int numero,String password);
	
	public Piece AjoutPiece(String nom,int numero) throws OrganeInconnuException;
	public void AjoutPieceBD(Piece P);
}
