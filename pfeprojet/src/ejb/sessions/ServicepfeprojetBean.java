package ejb.sessions;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Random;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import ejb.entites.*;

@Stateless
public class ServicepfeprojetBean implements ServicepfeprojetLocal, ServicepfeprojetRemote {
	@PersistenceContext(unitName = "pfeprojet")
	protected EntityManager em;

	public ServicepfeprojetBean() {
	}

	// fonction check
	// fonction check batiment
	public void checkbatiment(int numerobatiment) throws BatimentInconnuException{
		Batiment B = rechercheBatimentnum(numerobatiment);
		boolean result;
		int i;
		result=true;
		i=0;
		List<Organe> organes = rechercheOrganeBatiment(numerobatiment);
		if(organes!=null){
			while(result==true && i<organes.size()){
				if(organes.get(i).isMarche()==false){
					result=false;
			}
			i++;
			}
		}
		B.setMarche(result);
		em.merge(B);
	}
	
	public List<Organe> rechercheOrganeDefectBatiment(int numerobatiment){
		List<Organe> listetotale = rechercheOrganeBatiment(numerobatiment);
		List<Organe> listeresult = new ArrayList<Organe>();
		for(int i=0;i<listetotale.size();i++){
			if(listetotale.get(i).isMarche()==false)
				listeresult.add(listetotale.get(i));
		}
		return listeresult;
	}
	
	
	// Recherche d'informations
	
	// Recherche d'une entreprise par nom
	public List<Entreprise> rechercheEntreprise(String Nom) throws EntrepriseInconnueException {
		@SuppressWarnings("unchecked")
		List<Entreprise> E = em.createQuery("from Entreprise e where nom like '%' || :name ||'%'")
				.setParameter("name", Nom).getResultList();
		if (E == null)
			throw new EntrepriseInconnueException();
		else
			return E;
	}

	// Recherche d'une entreprise par numero
	public Entreprise rechercheEntreprisenum(int Num) throws EntrepriseInconnueException {
		Entreprise E = em.find(Entreprise.class, Num);
		if (E == null)
			throw new EntrepriseInconnueException();
		else
			return E;
	}
	// Recherche d'une entreprise par email
	public Entreprise rechercheEntrepriseemail(String email) throws EntrepriseInconnueException {
		Entreprise E = (Entreprise) em.createQuery("from Entreprise e where e.adressemail like :name").setParameter("name", email).getSingleResult();
		if(E==null)
			throw new EntrepriseInconnueException();
		else
			return E;
	}

	// Recherche d'un batiment par nom et par entreprise
	public Batiment recherchebatiment(String nomentreprise, String Nom)
			throws BatimentInconnuException, EntrepriseInconnueException {
		Batiment B = null;
		Entreprise E = rechercheEntreprise(nomentreprise).get(0);
		for (int i = 0; i < E.getBatiments().size(); i++)
			if (E.getBatiments().get(i).getNom().compareTo(Nom) == 0)
				B = E.getBatiments().get(i);
		if (B == null)
			throw new BatimentInconnuException();
		else
			return B;
	}
	// Recherche d'un batiment par entreprise
	public List<Batiment> rechercheBatimentEntreprise(int numE){
		List<Batiment> bat=(List <Batiment>) em.createQuery("from Batiment b where b.entreprise.numero="+numE).getResultList();
		return bat;
	}
	// Recherche d'un batiment par numero
	public Batiment rechercheBatimentnum(int Num) throws BatimentInconnuException {
		Batiment B = em.find(Batiment.class, Num);
		if (B == null)
			throw new BatimentInconnuException();
		else
			return B;
	}
	// Recherche d'un technicien par nom
	public List<Technicien> rechercheTechnicien(String Nom) throws TechnicienInconnuException {
		@SuppressWarnings("unchecked")
		List<Technicien> T = em.createQuery("from Technicien t where nom like :name").setParameter("name", Nom)
				.getResultList();
		if (T == null)
			throw new TechnicienInconnuException();
		else
			return T;
	}
	
	public Technicien rechercheTechnicienemail(String email) throws TechnicienInconnuException {
		Technicien T = (Technicien) em.createQuery("from Technicien t where t.adressemail like :name").setParameter("name", email).getSingleResult();
		if(T==null)
			throw new TechnicienInconnuException();
		else
			return T;
	}
	
	// Recherche d'un technicien par numero
	public Technicien rechercheTechniciennum(int Num) throws TechnicienInconnuException {
		Technicien T = em.find(Technicien.class, Num);
		if (T == null)
			throw new TechnicienInconnuException();
		else
			return T;
	}
	// recherche d'un organe par numero
	public Organe rechercheOrgane(int numero) throws OrganeInconnuException {
		Organe O = em.find(Organe.class, numero);
		if (O == null) {
			throw new OrganeInconnuException();
		}
		return O;
	}
	// Recherche du type
	public TypeExtincteur rechercheTypeExtincteur(String Num) {
		int Numero = Integer.parseInt(Num);
		TypeExtincteur T = em.find(TypeExtincteur.class, Numero);
		return T;
	}
	
	public TypeExtincteur rechercheTypeExtincteurNom(String nom) {
		return (TypeExtincteur) em.createQuery("from TypeExtincteur t WHERE t.nom like :name").setParameter("name",nom).getSingleResult();
	}
	// recherche de la marque
	public MarqueExtincteur rechercheMarqueExtincteur(String Num) {
		int Numero = Integer.parseInt(Num);
		MarqueExtincteur M = em.find(MarqueExtincteur.class, Numero);
		return M;
	}
	public MarqueExtincteur rechercheMarqueExtincteurNom(String nom) {
		return (MarqueExtincteur) em.createQuery("from MarqueExtincteur m WHERE m.nom like :name").setParameter("name",nom).getSingleResult();
	}
	// recherche des organes d'un batiment 
	@SuppressWarnings("unchecked")
	public List<Organe> rechercheOrganeBatiment(int numeroBatiment){
		return em.createQuery("from Organe o WHERE o.batiment.numero = "+numeroBatiment).getResultList();
	}
	// recherche d'un organe par numero
	public Organe rechercheOrganeNum(int numeroOrgane){
		return em.find(Organe.class,numeroOrgane);
	}
	// recherche des extincteurs d'un batiment
	public List<Extincteur> rechercheExtincteurBatiment(int numeroBatiment){
		return em.createQuery("from Extincteur e WHERE e.batiment.numero = "+numeroBatiment).getResultList();
	}
	// recherche des pharmacies d'un batiment
	public List<Pharmacie> recherchePharmacieBatiment(int numeroBatiment){
		return em.createQuery("from Pharmacie p WHERE p.batiment.numero = "+numeroBatiment).getResultList();
	}
	public List<Coupefeu> rechercheCoupefeuBatiment(int numeroBatiment){
		return em.createQuery("from Coupefeu c WHERE c.batiment.numero = "+numeroBatiment).getResultList();
	}
	
	public List<Poteaux> recherchePoteauxBatiment(int numeroBatiment){
		return em.createQuery("from Poteaux p WHERE p.batiment.numero = "+numeroBatiment).getResultList();
	}
	
	// recherche intervention
	public List<Intervention> rechercheInterventionOrgane(int numeroOrgane) {
		return em.createQuery("from Intervention i where i.organe.numero="+numeroOrgane).getResultList();
	}
	// recherche intervention pdf
	public List<Intervention> rechercheInterventionPdf(int numeroPdf) {
		return em.createQuery("from Intervention i where i.pdf.numero="+numeroPdf).getResultList();
	}
	// recherche pdf batiment
	public List<Pdfgenere> recherchePdfgenereBatiment(int numeroBatiment){
		List<Pdfgenere> listetotale = getlistePdfgenere();
		List<Pdfgenere> listeresult = new ArrayList<Pdfgenere>();
		for(int i=0;i<listetotale.size();i++){
			if(listetotale.get(i).getInterventions().get(0).getOrgane().getBatiment().getNumero()==numeroBatiment){
				listeresult.add(listetotale.get(i));
			}
		}
		return listeresult;
	}
	// recherche pdf numero
	public Pdfgenere recherchePdfgenereNum(int numeroPdf){
		return em.find(Pdfgenere.class,numeroPdf);
	}
	// recherche pieces par intervention
	public List<Piece> recherchePieceIntervention(int numeroIntervention){
		return em.createQuery("from Piece p where p.preventive.numero="+numeroIntervention).getResultList();
	}
	
	
	
	// Fonctions d'ajouts

	// Ajout d'une entreprise
	public Compte ajouterEntreprise(String nom, String adresse,String email, String tel, String interlocuteur) {
		Entreprise E = new Entreprise();
		E.setNom(nom);
		E.setAdresse(adresse);
		E.setAdressemail(email);
		E.setTel(tel);
		E.setNominterlocuteur(interlocuteur);
		em.persist(E);
		Compte session = new Compte();
		session.setLogin(E.getAdressemail());
		session.setNumeroutilisateur(E.getNumero());
		session.setStatut(2);
		session.setPassword(password());
		em.persist(session);
		return session;
	}

	// Ajout d'un technicien
	public Compte ajouterTechnicien(String nom, String prenom, String adresse, String tel, String email) {
		Technicien T = new Technicien();
		T.setNom(nom);
		T.setPrenom(prenom);
		T.setAdresse(adresse);
		T.setTel(tel);
		T.setAdressemail(email);
		em.persist(T);
		Compte session = new Compte();
		session.setLogin(T.getAdressemail());
		session.setNumeroutilisateur(T.getNumero());
		session.setStatut(1);
		session.setPassword(password());
		em.persist(session);
		return session;
	}

	// Ajout d'un batiment
	public void ajouterBatiment(String nomentreprise, String nom, String adresse) throws EntrepriseInconnueException {
		Entreprise E = rechercheEntreprise(nomentreprise).get(0);
		if (E == null) {
			System.out.print("entreprise introuvable");
			throw new EntrepriseInconnueException();
		} else {
			Batiment B = new Batiment();
			B.setNom(nom);
			B.setAdresse(adresse);
			B.setEntreprise(E);
			B.setMarche(true);
			E.addBatiments(B);
			em.persist(B);
			em.merge(E);
		}
	}
	// Ajout pieces
	public Piece AjoutPiece(String nom,int numero) throws OrganeInconnuException {
		Piece P = new Piece();
		P.setNom(nom);
		Organe O = rechercheOrgane(numero);
		P.setOrgane(O);
		return P;
//		em.persist(P);
	}
	
	public void AjoutPieceBD(Piece P){
		em.persist(P);
	}
	
	// Ajout Type Extincteur
	public void ajouttypeextincteur(String nom) {
		TypeExtincteur T = new TypeExtincteur();
		T.setNom(nom);
		em.persist(T);
	}
	// Ajout Marque Extincteur
	public void ajoutmarqueextincteur(String nom) {
		MarqueExtincteur M = new MarqueExtincteur();
		M.setNom(nom);
		em.persist(M);
	}

	
	// Interventions sur les extincteurs
	// Intervention : Installation
	public Installation InstallationOrgane(String Obs, java.sql.Date date, int numtechnicien,int numbatiment,Organe O)
			throws TechnicienInconnuException, BatimentInconnuException, EntrepriseInconnueException {
		Technicien T = rechercheTechniciennum(numtechnicien);
		Batiment B = rechercheBatimentnum(numbatiment);
		Installation Inst = new Installation();
		Inst.setDate(date);
		Inst.setObservation(Obs);
		Inst.setOrgane(O);
		Inst.setTechnicien(T);
		return Inst;
	}
	// Ajout Extincteur 
	public Extincteur ajoutExtincteur(int numbatiment, int Annee, String Emp, String Obs, String nommarque, String nomtype) throws BatimentInconnuException{
		Batiment B = rechercheBatimentnum(numbatiment);
		Extincteur E = new Extincteur();
		E.setAnnee(Annee);
		E.setEmplacement(Emp);
		E.setObservation(Obs);
		E.setBatiment(B);
		E.setMarche(true);
		MarqueExtincteur M = rechercheMarqueExtincteur(nommarque);
		E.setMarque(M);
		TypeExtincteur Tp = rechercheTypeExtincteur(nomtype);
		E.setType(Tp);
		return E;
	}
	// Ajout Pharmacie
	public Pharmacie ajoutPharmacie(int numbatiment, int Annee, String Emp,String Obs, int capacite)throws BatimentInconnuException{
		Batiment B = rechercheBatimentnum(numbatiment);
		Pharmacie P = new Pharmacie();
		P.setAnnee(Annee);
		P.setEmplacement(Emp);
		P.setObservation(Obs);
		P.setBatiment(B);
		P.setCapacite(capacite);
		P.setMarche(true);
		return P;
	}
	// Ajout Coupefeu
	public Coupefeu ajoutCoupefeu(int numbatiment, String Emp,String Obs, String type)throws BatimentInconnuException{
		Batiment B = rechercheBatimentnum(numbatiment);
		Coupefeu C = new Coupefeu();
		C.setEmplacement(Emp);
		C.setObservation(Obs);
		C.setBatiment(B);
		C.setTypeCoupefeu(type);
		C.setMarche(true);
		return C;
	}
	// Ajout Poteaux
	public Poteaux ajoutPoteaux(int numbatiment,String Emp,String Obs, int diametre, int pressionstat,int pression60,int pression1bar)throws BatimentInconnuException{
		Batiment B = rechercheBatimentnum(numbatiment);
		Poteaux P = new Poteaux();
		P.setEmplacement(Emp);
		P.setObservation(Obs);
		P.setDiametre(diametre);
		P.setPressionstat(pressionstat);
		P.setPression60(pression60);
		P.setPression1bar(pression1bar);
		P.setBatiment(B);
		P.setMarche(true);
		return P;
	}
	
	

	// Ajout dans la base de donnée
	// Organe
	public void ajoutOrgane(List<Organe> organes){
		int i;
		for(i=0;i<organes.size();i++){
			em.persist(organes.get(i));
		}
	}
	
	// Intervention
	public Intervention ajoutIntervention(int numbatiment, Intervention Interv, Organe O, String conclusion) throws BatimentInconnuException{
		Batiment B = rechercheBatimentnum(numbatiment);
		Interv.setConclusion(conclusion);
		
		if (O.getInterventions() == null) {
		List<Intervention> interv = new ArrayList<Intervention>();
		O.setInterventions(interv);
		}
		
		O.addInterventions(Interv);
		O.setConclusion(conclusion);
		if(Interv instanceof Installation){
			B.addOrganes(O);
			em.merge(B);
			em.persist(O);
		}
		else {
			em.merge(O);
		}
		em.persist(Interv);
		return Interv;
	}
	// Ajout pdf
	public Pdfgenere ajoutpdf(List<Intervention> interventions){
		Pdfgenere pdf = new Pdfgenere();
		pdf.setInterventions(interventions);
		em.persist(pdf);
		for(int i=0;i<interventions.size();i++){
			interventions.get(i).setPdf(pdf);
			em.merge(interventions.get(i));
		}
		return pdf;
	}
	// Intervention : Verification
	public Verification Verification(int numero, String Obs, String conclusion, int numerotechnicien, java.sql.Date date, boolean marche)
			throws OrganeInconnuException, TechnicienInconnuException, BatimentInconnuException {
		Organe O = rechercheOrgane(numero);
		Technicien T = em.find(Technicien.class, numerotechnicien);
		if (T == null) {
			throw new TechnicienInconnuException();
		}
		O.setObservation(Obs);
		O.setConclusion(conclusion);
		O.setMarche(marche);
		Verification V = new Verification();
		V.setDate(date);
		V.setObservation(Obs);
		V.setConclusion(conclusion);
		V.setTechnicien(T);
		V.setOrgane(O);
		if (O.getInterventions() == null) {
			List<Intervention> interv = new ArrayList<Intervention>();
			O.setInterventions(interv);
		}
		O.addInterventions(V);
		em.persist(V);
		em.merge(O);
		return V;
	}
	// Recherche : Verifications effectuees sur un organe
	@SuppressWarnings("unchecked")
	public List<Verification> getVerificationOrgane(Organe O) {
		return em.createQuery("from Verification v WHERE v.organe.numero = " +O.getNumero()).getResultList();
	}
	// Recherche : Verifications effectuees sur tous les organes d'un batiment
	public List<Verification> getVerificationBatiment(int numeroBatiment){
		List<Verification> result = new ArrayList<Verification>();
		List<Extincteur> extincteurs = rechercheExtincteurBatiment(numeroBatiment);
		for(int i=0;i<extincteurs.size();i++){
			result.add((Verification) getVerificationOrgane(extincteurs.get(i)));
		}
		return result;
	}
	// Intervention : Maintenance
	// Maintenance : Corrective
	public Corrective MaintenanceCorrectiveOrgane(String Obs,java.sql.Date date,  int numerotechnicien, Organe O) throws TechnicienInconnuException {
		Technicien T = em.find(Technicien.class, numerotechnicien);
		if (T == null) {
			throw new TechnicienInconnuException();
		}
		Corrective MC = new Corrective();
		MC.setDate(date);
		MC.setObservation(Obs);
		MC.setTechnicien(T);
		MC.setOrgane(O);
		return MC;
	}
	// remplacement poteaux
	public Poteaux remplacementpoteaux(Poteaux P, String Emp,String Obs, int diametre,int pressionstat,int pression60,int pression1bar,boolean marche){
		P.setEmplacement(Emp);
		P.setObservation(Obs);
		P.setDiametre(diametre);
		P.setPressionstat(pressionstat);
		P.setPression60(pression60);
		P.setPression1bar(pression1bar);
		P.setMarche(marche);
		return P;
	}
	// remplacement coupe-feu
	public Coupefeu remplacementcoupefeu(Coupefeu C, String Emp, String Obs,String type ,boolean marche){
		C.setEmplacement(Emp);
		C.setObservation(Obs);
		C.setMarche(marche);
		C.setTypeCoupefeu(type);
		return C;
	}
	
	// remlacement pharmacie
	public Pharmacie remplacementpharmacie(Pharmacie P, int Annee, String Emp, String Obs, int capacite,boolean marche){
		P.setAnnee(Annee);
		P.setEmplacement(Emp);
		P.setObservation(Obs);
		P.setMarche(marche);
		P.setCapacite(capacite);
		return P;
	}
	// remlacement extincteur
	public Extincteur remplacementextincteur(Extincteur E, int Annee, String Emp, String Obs, String nommarque, String nomtype,boolean marche){
		E.setAnnee(Annee);
		E.setEmplacement(Emp);
		E.setObservation(Obs);
		E.setMarche(marche);
		MarqueExtincteur M = rechercheMarqueExtincteur(nommarque);
		E.setMarque(M);
		TypeExtincteur Tp = rechercheTypeExtincteur(nomtype);
		E.setType(Tp);
		return E;
	}
	
	
	
	
	
	
	// Maintenance : Preventive
	public Preventive MaintenancePreventiveOrgane(Organe O, String Obs, String Obsraj, int numerotechnicien, 
			java.sql.Date date, boolean marche) throws OrganeInconnuException, TechnicienInconnuException {
		Technicien T = em.find(Technicien.class, numerotechnicien);
		if (T == null) {
			throw new TechnicienInconnuException();
		}
		Preventive MP = new Preventive();
		MP.setDate(date);
		MP.setObservation(Obs);
		MP.setConclusion(Obsraj);
		MP.setTechnicien(T);
		MP.setOrgane(O);
		if (O.getInterventions() == null) {
			List<Intervention> interv = new ArrayList<Intervention>();
			O.setInterventions(interv);
		}
		O.addInterventions(MP);
		O.setObservation(Obs);
		O.setConclusion(Obsraj);
		O.setMarche(marche);
		em.persist(MP);
		em.merge(O);
		return MP;
	}
	
	
	public Preventive rechercheMaintenancePreventive(int numeroMaintenance){
		return em.find(Preventive.class, numeroMaintenance);
	}

	// Listes : A partir de la base de donnees
	
	// Liste des PDF
	public List<Pdfgenere> getlistePdfgenere() {
		return em.createQuery("from Pdfgenere P").getResultList();
	}
	
	// Liste des interventions
	@SuppressWarnings("unchecked")
	public List<Intervention> getlisteIntervention() {
		return em.createQuery("from Intervention I").getResultList();
	}
	
	
	// Liste des installations
	@SuppressWarnings("unchecked")
	public List<Installation> getlisteInstallation() {
		return em.createQuery("from Installation I ").getResultList();
	}
	// Liste des entreprises
	@SuppressWarnings("unchecked")
	public List<Entreprise> getlisteEntreprises() {
		return em.createQuery("from Entreprise e ").getResultList();
	}
	// Liste des techniciens
	@SuppressWarnings("unchecked")
	public List<Technicien> getlisteTechniciens() {
		return em.createQuery("from Technicien t ").getResultList();
	}
	// liste de tous les types d'extincteurs
	@SuppressWarnings("unchecked")
	public List<TypeExtincteur> touslesTypeExtincteur() {
		List<TypeExtincteur> T = em.createQuery("from TypeExtincteur t").getResultList();
		return T;
	}
	// liste de toutes les marques d'extincteurs
	@SuppressWarnings("unchecked")
	public List<MarqueExtincteur> touteslesMarqueExtincteur() {
		List<MarqueExtincteur> M = em.createQuery("from MarqueExtincteur m").getResultList();
		return M;
	}

	// derniere observation : Verification
	public String rechercheObservationVerification(int numeroOrgane) {
		@SuppressWarnings("unchecked")
		List<Verification> verifications = em.createQuery("FROM Verification v where v.organe.numero = "+numeroOrgane).getResultList();
		String observation="--";
		if(verifications.size()!=0)
			observation=verifications.get(verifications.size()-1).getObservation();
		return observation;
	}

	// derniere conclusion : Verification Extincteur
	public String rechercheConclusionVerificationExtincteur(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Verification> verifications = em.createQuery("FROM Verification v where v.organe.batiment.numero = "+numeroBatiment).getResultList();
		int test,i;
		test=0;
		i=verifications.size()-1;
		String conclusion="--";
		if(verifications.size()!=0){
			while(test==0 && i>-1) {
				if(verifications.get(i).getOrgane() instanceof Extincteur ){
					test=1;
				}
				i--;
			}
			if(test==1)
				conclusion=verifications.get(i+1).getConclusion();
		}
		return conclusion;
	}
	
	// derniere conclusion : Verification Pharmacie
	public String rechercheConclusionVerificationPharmacie(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Verification> verifications = em.createQuery("FROM Verification v where v.organe.batiment.numero = "+numeroBatiment).getResultList();
		int test,i;
		test=0;
		i=verifications.size()-1;
		String conclusion="--";
		if(verifications.size()!=0){
			while(test==0 && i>-1) {
				if(verifications.get(i).getOrgane() instanceof Pharmacie ){
					test=1;
				}
				i--;
			}
			if(test==1)
				conclusion=verifications.get(i+1).getConclusion();
		}
		return conclusion;
	}
	// derniere conclusion : Verification Coupefeu
	public String rechercheConclusionVerificationCoupefeu(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Verification> verifications = em.createQuery("FROM Verification v where v.organe.batiment.numero = "+numeroBatiment).getResultList();
		int test,i;
		test=0;
		i=verifications.size()-1;
		String conclusion="--";
		if(verifications.size()!=0){
			while(test==0 && i>-1) {
				if(verifications.get(i).getOrgane() instanceof Coupefeu ){
					test=1;
				}
				i--;
			}
			if(test==1)
				conclusion=verifications.get(i+1).getConclusion();
		}
		return conclusion;
	}
	// derniere conclusion : Verification Poteaux
	public String rechercheConclusionVerificationPoteaux(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Verification> verifications = em.createQuery("FROM Verification v where v.organe.batiment.numero = "+numeroBatiment).getResultList();
		int test,i;
		test=0;
		i=verifications.size()-1;
		String conclusion="--";
		if(verifications.size()!=0){
			while(test==0 && i>-1) {
				if(verifications.get(i).getOrgane() instanceof Poteaux ){
					test=1;
				}
				i--;
			}
			if(test==1)
				conclusion=verifications.get(i+1).getConclusion();
		}
		return conclusion;
	}
	// derniere observation : Maintenance Corrective
	public String rechercheObservationMaintenancecorr(int numeroOrgane) {
		@SuppressWarnings("unchecked")
		List<Corrective> maintenancecorrective = em.createQuery("FROM Corrective m where m.organe.numero = "+numeroOrgane).getResultList();
		String observation="--";
		if(maintenancecorrective.size()!=0)
			observation=maintenancecorrective.get(maintenancecorrective.size()-1).getObservation();
		return observation;
	}

	// derniere conclusion : Maintenance Corrective Extincteur
	public String rechercheConclusionMaintenancecorrExtincteur(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Corrective> maintenancecorrective = em.createQuery("FROM Corrective m where m.organe.batiment.numero = "+numeroBatiment).getResultList();
		String conclusion="--";
		int test,i;
		test=0;
		i=maintenancecorrective.size()-1;
		if(maintenancecorrective.size()!=0){
			while(test==0 && i>-1) {
				if(maintenancecorrective.get(i).getOrgane() instanceof Extincteur ){
					test=1;
				}
				i--;
			}
			if(test==1)
				conclusion=maintenancecorrective.get(i+1).getConclusion();
		}
		return conclusion;
	}
	// derniere conclusion : Maintenance Corrective Pharmacie
	public String rechercheConclusionMaintenancecorrPharmacie(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Corrective> maintenancecorrective = em.createQuery("FROM Corrective m where m.organe.batiment.numero = "+numeroBatiment).getResultList();
		String conclusion="--";
		int test,i;
		test=0;
		i=maintenancecorrective.size()-1;
		if(maintenancecorrective.size()!=0){
			while(test==0 && i>-1) {
				if(maintenancecorrective.get(i).getOrgane() instanceof Pharmacie ){
					test=1;
				}
				i--;
			}
			if(test==1)
				conclusion=maintenancecorrective.get(i+1).getConclusion();
		}
		return conclusion;
	}
	// derniere conclusion : Maintenance Corrective Coupefeu
	public String rechercheConclusionMaintenancecorrCoupefeu(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Corrective> maintenancecorrective = em.createQuery("FROM Corrective m where m.organe.batiment.numero = "+numeroBatiment).getResultList();
		String conclusion="--";
		int test,i;
		test=0;
		i=maintenancecorrective.size()-1;
		if(maintenancecorrective.size()!=0){
			while(test==0 && i>-1) {
				if(maintenancecorrective.get(i).getOrgane() instanceof Coupefeu ){
					test=1;
				}
				i--;
			}
			if(test==1)
				conclusion=maintenancecorrective.get(i+1).getConclusion();
		}
		return conclusion;
	}
	// derniere conclusion : Maintenance Corrective Poteaux
	public String rechercheConclusionMaintenancecorrPoteaux(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Corrective> maintenancecorrective = em.createQuery("FROM Corrective m where m.organe.batiment.numero = "+numeroBatiment).getResultList();
		String conclusion="--";
		int test,i;
		test=0;
		i=maintenancecorrective.size()-1;
		if(maintenancecorrective.size()!=0){
			while(test==0 && i>-1) {
				if(maintenancecorrective.get(i).getOrgane() instanceof Poteaux ){
					test=1;
				}
				i--;
			}
			if(test==1)
				conclusion=maintenancecorrective.get(i+1).getConclusion();
		}
		return conclusion;
	}
	
	
	// derniere observation : Maintenance Preventive
	public String rechercheObservationMaintenanceprev(int numeroOrgane) {
		@SuppressWarnings("unchecked")
		List<Preventive> maintenancepreventive = em.createQuery("FROM Preventive m where m.organe.numero = "+numeroOrgane).getResultList();
		String observation="--";
		if(maintenancepreventive.size()!=0)
			observation=maintenancepreventive.get(maintenancepreventive.size()-1).getObservation();
		return observation;
	}

	// derniere conclusion : Maintenance Preventive Extincteur
	public String rechercheConclusionMaintenanceprevExtincteur(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Preventive> maintenancepreventive = em.createQuery("FROM Preventive m where m.organe.batiment.numero = "+numeroBatiment).getResultList();
		String conclusion="--";
		int test,i;
		test=0;
		i=maintenancepreventive.size()-1;
		if(maintenancepreventive.size()!=0){
			while(test==0 && i>-1) {
				if(maintenancepreventive.get(i).getOrgane() instanceof Extincteur ){
					test=1;
				}
				i--;
			}
			if(test==1)
				conclusion=maintenancepreventive.get(i+1).getConclusion();
		}
		return conclusion;
	}

	
	// derniere conclusion : Maintenance Coupefeu
	public String rechercheConclusionMaintenanceprevCoupefeu(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Preventive> maintenancepreventive = em.createQuery("FROM Preventive m where m.organe.batiment.numero = "+numeroBatiment).getResultList();
		String conclusion="--";
		int test,i;
		test=0;
		i=maintenancepreventive.size()-1;
		if(maintenancepreventive.size()!=0){
			while(test==0 && i>-1) {
				if(maintenancepreventive.get(i).getOrgane() instanceof Coupefeu ){
					test=1;
				}
				i--;
			}
			if(test==1)
				conclusion=maintenancepreventive.get(i+1).getConclusion();
		}
		return conclusion;
	}
	// derniere conclusion : Maintenance Poteaux
		public String rechercheConclusionMaintenanceprevPoteaux(int numeroBatiment) {
			@SuppressWarnings("unchecked")
			List<Preventive> maintenancepreventive = em.createQuery("FROM Preventive m where m.organe.batiment.numero = "+numeroBatiment).getResultList();
			String conclusion="--";
			int test,i;
			test=0;
			i=maintenancepreventive.size()-1;
			if(maintenancepreventive.size()!=0){
				while(test==0 && i>-1) {
					if(maintenancepreventive.get(i).getOrgane() instanceof Poteaux ){
						test=1;
					}
					i--;
				}
				if(test==1)
					conclusion=maintenancepreventive.get(i+1).getConclusion();
			}
			return conclusion;
		}
	// Creation des comptes et generations des mots de passe
	public void creercompteAdmin(String login, int admin, int statut) {
		Compte session = new Compte();
		session.setLogin(login);
		session.setNumeroutilisateur(admin);
		session.setStatut(0);
		session.setPassword(password());
		em.persist(session);
	}

	public String password() {
	    String chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"; // Tu supprimes les lettres dont tu ne veux pas
	    String pass = "";
	    for(int x=0;x<8;x++)   {
	       int i = (int)Math.floor(Math.random() * chars.length() -1); // Si tu supprimes des lettres tu diminues ce nb
	       pass += chars.charAt(i);
	    }
	    return pass;
	}
	// verification des comptes admin
	public List<Integer> verificationCompte(String login, String pwd) throws CompteInconnuException {
		@SuppressWarnings("unchecked")
		List<Compte> session = (List<Compte>) em.createQuery("from Compte c").getResultList();
		List<Integer> liste = new ArrayList<Integer>();
		boolean trouver = false;
		int i = 0;
		while (i < session.size() && !trouver) {

			if (session.get(i).getLogin().compareTo(login) == 0 && session.get(i).getPassword().compareTo(pwd) == 0) {
				trouver = true;
				liste.add(session.get(i).getNumeroutilisateur());
				liste.add(session.get(i).getStatut());
				liste.add(session.get(i).getNumero());
			} else
				i++;
		}
		if (!trouver)
			throw new CompteInconnuException();

		return liste;
	}

	public void modifPassWord(int numero,String password){
		Compte compte= em.find(Compte.class,numero);
		compte.setPassword(password);
		em.merge(compte);
	}


}