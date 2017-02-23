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
		List<Entreprise> E = em.createQuery("from Entreprise e where nom like '%' || :name \n'%'")
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
	
	// Recherche du type d'eclairage
	public TypeEclairage rechercheTypeEclairage(String Num) {
		int Numero = Integer.parseInt(Num);
		TypeEclairage T = em.find(TypeEclairage.class, Numero);
		return T;
	}
	
	public TypeEclairage rechercheTypeEclairageNom(String nom) {
		return (TypeEclairage) em.createQuery("from TypeEclairage t WHERE t.nom like :name").setParameter("name",nom).getSingleResult();
	}
	// recherche marque d'eclairage
	public MarqueEclairage rechercheMarqueEclairage(String Num) {
		int Numero = Integer.parseInt(Num);
		MarqueEclairage M = em.find(MarqueEclairage.class, Numero);
		return M;
	}
	public MarqueEclairage rechercheMarqueEclairageNom(String nom) {
		return (MarqueEclairage) em.createQuery("from MarqueEclairage m WHERE m.nom like :name").setParameter("name",nom).getSingleResult();
	}
	// Recherche du type de telecommande
	public Typetelecommande rechercheTypeTelecommande(String Num) {
		int Numero = Integer.parseInt(Num);
		Typetelecommande T = em.find(Typetelecommande.class, Numero);
		return T;
	}
	
	public Typetelecommande rechercheTypeTelecommandeNom(String nom) {
		return (Typetelecommande) em.createQuery("from Typetelecommande t WHERE t.nom like :name").setParameter("name",nom).getSingleResult();
	}
	// Recherche du type
	public TypeRia rechercheTypeRia(String Num) {
		int Numero = Integer.parseInt(Num);
		TypeRia T = em.find(TypeRia.class, Numero);
		return T;
	}
	
	public TypeRia rechercheTypeRiaNom(String nom) {
		return (TypeRia) em.createQuery("from TypeRia t WHERE t.nom like :name").setParameter("name",nom).getSingleResult();
	}
	// Recherche du type coupe-feu
	public TypeCoupefeu rechercheTypeCoupefeu(String Num) {
		int Numero = Integer.parseInt(Num);
		TypeCoupefeu T = em.find(TypeCoupefeu.class, Numero);
		return T;
	}
	
	public TypeCoupefeu rechercheTypeCoupefeuNom(String nom) {
		return (TypeCoupefeu) em.createQuery("from TypeCoupefeu t WHERE t.nom like :name").setParameter("name",nom).getSingleResult();
	}
	
	// Recherche du type Alarme
	public TypeAlarme rechercheTypeAlarme(String Num) {
		int Numero = Integer.parseInt(Num);
		TypeAlarme T = em.find(TypeAlarme.class, Numero);
		return T;
	}
	
	public TypeAlarme rechercheTypeAlarmeNom(String nom) {
		return (TypeAlarme) em.createQuery("from TypeAlarme t WHERE t.nom like :name").setParameter("name",nom).getSingleResult();
	}
	// recherche marque alarme
	public MarqueAlarme rechercheMarqueAlarme(String Num) {
		int Numero = Integer.parseInt(Num);
		MarqueAlarme M = em.find(MarqueAlarme.class, Numero);
		return M;
	}
	public MarqueAlarme rechercheMarqueAlarmeNom(String nom) {
		return (MarqueAlarme) em.createQuery("from MarqueAlarme m WHERE m.nom like :name").setParameter("name",nom).getSingleResult();
	}
	// Recherche du type de batterie
	public TypeBatterie rechercheTypeBatterie(String Num) {
		int Numero = Integer.parseInt(Num);
		TypeBatterie T = em.find(TypeBatterie.class, Numero);
		return T;
	}
	
	public TypeBatterie rechercheTypeBatterieNom(String nom) {
		return (TypeBatterie) em.createQuery("from TypeBatterie t WHERE t.nom like :name").setParameter("name",nom).getSingleResult();
	}
	// Recherche du type de batterie AES
	public TypeBatterieAES rechercheTypeBatterieaes(String Num) {
		int Numero = Integer.parseInt(Num);
		TypeBatterieAES T = em.find(TypeBatterieAES.class, Numero);
		return T;
	}
	
	public TypeBatterieAES rechercheTypeBatterieaesNom(String nom) {
		return (TypeBatterieAES) em.createQuery("from TypeBatterieAES t WHERE t.nom like :name").setParameter("name",nom).getSingleResult();
	}
	
	// Recherche du type de AES
	public TypeAES rechercheTypeaes(String Num) {
		int Numero = Integer.parseInt(Num);
		TypeAES T = em.find(TypeAES.class, Numero);
		return T;
	}
	
	public TypeAES rechercheTypeaesNom(String nom) {
		return (TypeAES) em.createQuery("from TypeAES t WHERE t.nom like :name").setParameter("name",nom).getSingleResult();
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
	// recherche des coupe-feu d'un batiment
	public List<Coupefeu> rechercheCoupefeuBatiment(int numeroBatiment){
		return em.createQuery("from Coupefeu c WHERE c.batiment.numero = "+numeroBatiment).getResultList();
	}
	// recherche des poteaux d'un batiment
	public List<Poteaux> recherchePoteauxBatiment(int numeroBatiment){
		return em.createQuery("from Poteaux p WHERE p.batiment.numero = "+numeroBatiment).getResultList();
	}
	// recherche des eclairages d'un batiment
	public List<Eclairage> rechercheEclairageBatiment(int numeroBatiment){
		return em.createQuery("from Eclairage e WHERE e.batiment.numero = "+numeroBatiment).getResultList();
	}
	// recherche des eclairages d'un batiment
	public List<RIA> rechercheRiaBatiment(int numeroBatiment){
		return em.createQuery("from RIA r WHERE r.batiment.numero = "+numeroBatiment).getResultList();
	}
	// recherche des alarmes d'un batiment
	public List<Alarme> rechercheAlarmeBatiment(int numeroBatiment){
		return em.createQuery("from Alarme a WHERE a.batiment.numero = "+numeroBatiment).getResultList();
	}
	// recherche intervention
	public List<Intervention> rechercheInterventionOrgane(int numeroOrgane) {
		return em.createQuery("from Intervention i where i.organe.numero="+numeroOrgane).getResultList();
	}
	// recherche intervention pdf
	public List<Intervention> rechercheInterventionPdf(int numeroPdf) {
		return em.createQuery("from Intervention i where i.pdf.numero="+numeroPdf).getResultList();
	}
	// recherche intervention num
	public Intervention rechercheInterventionNum(int numeroIntervention){
		return em.find(Intervention.class,numeroIntervention);
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
	public Compte ajouterEntreprise(String nom, String adresse,String email, String tel, String nominterlocuteur,String prenomInterlocuteur) {
		Entreprise E = new Entreprise();
		E.setNom(nom);
		E.setAdresse(adresse);
		E.setAdressemail(email);
		E.setTel(tel);
		E.setNominterlocuteur(nominterlocuteur);
		E.setPrenominterlocuteur(prenomInterlocuteur);
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
	public void ajouterBatiment(int num, String nom, String adresse,String nominterlocuteur,String prenominterlocuteur, String numtel) throws EntrepriseInconnueException {
		Entreprise E = em.find(Entreprise.class, num);
		List<Batiment> batiments =  new ArrayList<Batiment>();
		if (E == null) {
			System.out.print("entreprise introuvable");
			throw new EntrepriseInconnueException();
		} else {
			Batiment B = new Batiment();
			B.setNom(nom);
			B.setNomresp(nominterlocuteur);
			B.setPrenomresp(prenominterlocuteur);
			B.setTelresp(numtel);
			B.setAdresse(adresse);
			B.setEntreprise(E);
			B.setMarche(true);
			if(E.getBatiments()==null){
				E.setBatiments(batiments);
			}
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

	// Ajout Type Eclairage
	public void ajouttypeeclairage(String nom) {
		TypeEclairage T = new TypeEclairage();
		T.setNom(nom);
		em.persist(T);
	}
	// Ajout Marque Extincteur
	public void ajoutmarqueeclairage(String nom) {
		MarqueEclairage M = new MarqueEclairage();
		M.setNom(nom);
		em.persist(M);
	}
	// Ajout Type Telecommande
	public void ajouttypetelecommande(String nom) {
		Typetelecommande T = new Typetelecommande();
		T.setNom(nom);
		em.persist(T);
	}
	// Ajout Type RIA
	public void ajouttyperia(String nom) {
		TypeRia T = new TypeRia();
		T.setNom(nom);
		em.persist(T);
	}
	// Ajout Type Coupefeu
	public void ajouttypecoupefeu(String nom) {
		TypeCoupefeu T = new TypeCoupefeu();
		T.setNom(nom);
		em.persist(T);
	}
	// Ajout Type Alarme
	public void ajouttypealarme(String nom) {
		TypeAlarme T = new TypeAlarme();
		T.setNom(nom);
		em.persist(T);
	}
	// Ajout Marque Alarme
	public void ajoutmarquealarme(String nom) {
		MarqueAlarme M = new MarqueAlarme();
		M.setNom(nom);
		em.persist(M);
	}

	// Ajout Type Batterie
	public void ajouttypebatterie(String nom) {
		TypeBatterie T = new TypeBatterie();
		T.setNom(nom);
		em.persist(T);
	}
	
	// Ajout Type Batterie AES
	public void ajouttypebatterieaes(String nom) {
		TypeBatterieAES T = new TypeBatterieAES();
		T.setNom(nom);
		em.persist(T);
	}
	
	// Ajout Type Type AES
	public void ajouttypeaes(String nom) {
		TypeAES T = new TypeAES();
		T.setNom(nom);
		em.persist(T);
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
		E.setConclusion("--");
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
		P.setConclusion("--");
		return P;
	}
	// Ajout Coupefeu
	public Coupefeu ajoutCoupefeu(int numbatiment, String Emp,String Obs, TypeCoupefeu type)throws BatimentInconnuException{
		Batiment B = rechercheBatimentnum(numbatiment);
		Coupefeu C = new Coupefeu();
		C.setEmplacement(Emp);
		C.setObservation(Obs);
		C.setBatiment(B);
		C.setType(type);
		C.setMarche(true);
		C.setConclusion("--");
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
		P.setConclusion("--");
		return P;
	}
	// Ajout eclairage
	public Eclairage ajoutEclairage(int numbatiment,String Emp,String Obs,TypeEclairage type, MarqueEclairage marque, boolean presence,boolean fonctionne,Typetelecommande typetel)throws BatimentInconnuException{
		Batiment B = rechercheBatimentnum(numbatiment);
		Eclairage E = new Eclairage();
		E.setEmplacement(Emp);
		E.setObservation(Obs);
		E.setType(type);
		E.setMarque(marque);
		E.setPresencetelecommande(presence);
		E.setFonctionnementtelecommande(fonctionne);
		E.setTypetelecommande(typetel);
		E.setBatiment(B);
		E.setMarche(true);
		E.setConclusion("--");
		return E;
	}
	// Ajout signaletique
	public Signaletique ajoutSignaletique(int numbatiment,String Emp,String Obs)throws BatimentInconnuException{
		Batiment B = rechercheBatimentnum(numbatiment);
		Signaletique S = new Signaletique();
		S.setEmplacement(Emp);
		S.setObservation(Obs);
		S.setBatiment(B);
		S.setMarche(true);
		S.setConclusion("--");
		return S;
	}
	// Ajout RIA
	public RIA ajoutRia(int numbatiment,String Emp, String Obs, TypeRia type,int pressionstat,int pressiondynam,int portee)throws BatimentInconnuException{
		Batiment B = rechercheBatimentnum(numbatiment);
		RIA R = new RIA();
		R.setEmplacement(Emp);
		R.setObservation(Obs);
		R.setConclusion("--");
		R.setType(type);
		R.setBatiment(B);
		R.setPressionStatique(pressionstat);
		R.setPressionDynamique(pressiondynam);
		R.setPortee(portee);
		R.setMarche(true);
		return R;
	}
	// Verification Alarme
	public Alarme verificationAlarme(Alarme A,int testvoltbatterie,int testampbatterie,int testchargeurbatterie,String optique,String obsionique,String thermique,String thermov,
			String flamme,String aspiration,String report,String manuel,String sonore,String lumineux,int testvoltaes,int testampaes, int testchargeuraes,String observation){
		A.setTestVoltBatterie(testvoltbatterie);
		A.setTestAmpereBatterie(testampbatterie);
		A.setTestVoltChargeur(testchargeurbatterie);
		A.setObservationDetecteurOptique(optique);
		A.setObservationDetecteurIonique(obsionique);
		A.setObservationDetecteurThermique(thermique);
		A.setObservationDetecteurThermovelocimetrique(thermov);
		A.setObservationDetecteurFlammes(flamme);
		A.setObservationDetecteurAspiration(aspiration);
		A.setObservationAutreReport(report);
		A.setObservationDeclencheurManuel(manuel);
		A.setObservationDiffusionSonore(sonore);
		A.setObservationDiffusionSonoreFlash(lumineux);
		A.setTestVoltBatterieAES(testvoltaes);
		A.setTestAmpereBatterieAES(testampaes);
		A.setTestVoltChargeurAES(testchargeuraes);
		A.setObservation(observation);
		em.merge(A);
		return A;
	}
	// Ajout Alarme
	public Alarme ajoutAlarme(int numbatiment,String Emp,String Obs,MarqueAlarme marquealarme,TypeAlarme typealarme,int annee,int nombrebatterie,int xbatterie,int ybatterie,
			int hbatterie,TypeBatterie typebatterie,int testvoltbatterie,int testampbatterie,int testchargeurbatterie,int nboptique, 
			String optique,int nbionique,String obsionique,int nbthermique,String thermique,int nbthermov,String thermov,
			int nbflamme,String flamme,int nbaspiration,String aspiration,int nbreport,String report,int nbmanuel,String manuel,
			int nbsonore,String sonore,int nblumineux,String lumineux,int nbAES,TypeAES typeaes, int nbbatterieaes, int xbatterieaes,
			int ybatterieaes,int hbatterieaes,TypeBatterieAES typebatterieaes, int testvoltaes,int testampaes, int testchargeuraes ) throws BatimentInconnuException{
		Batiment B = rechercheBatimentnum(numbatiment);
		Alarme A = new Alarme();
		A.setEmplacement(Emp);
		A.setObservation(Obs);
		A.setMarque(marquealarme);
		A.setType(typealarme);
		A.setAnnee(annee);
		A.setNombreBatterie(nombrebatterie);
		A.setXbatterie(xbatterie);
		A.setYbatterie(ybatterie);
		A.setHbatterie(hbatterie);
		A.setTypeBatterie(typebatterie);
		A.setTestVoltBatterie(testvoltbatterie);
		A.setTestAmpereBatterie(testampbatterie);
		A.setTestVoltChargeur(testchargeurbatterie);
		A.setNombreDetecteurOptique(nboptique);
		A.setObservationDetecteurOptique(optique);
		A.setNombreDetecteurIonique(nbionique);
		A.setObservationDetecteurIonique(obsionique);
		A.setNombreDetecteurThermique(nbthermique);
		A.setObservationDetecteurThermique(thermique);
		A.setNombreDetecteurThermovelocimetrique(nbthermov);
		A.setObservationDetecteurThermovelocimetrique(thermov);
		A.setNombreDetecteurFlammes(nbflamme);
		A.setObservationDetecteurFlammes(flamme);
		A.setNombreDetecteurAspiration(nbaspiration);
		A.setObservationDetecteurAspiration(aspiration);
		A.setNombreAutreReport(nbreport);
		A.setObservationAutreReport(report);
		A.setNombreDeclencheurManuel(nbmanuel);
		A.setObservationDeclencheurManuel(manuel);
		A.setNombreDiffusionSonore(nbsonore);
		A.setObservationDiffusionSonore(sonore);
		A.setNombreDiffusionSonoreFlash(nblumineux);
		A.setObservationDiffusionSonoreFlash(lumineux);
		A.setNombreAES(nbAES);
		A.setTypeAES(typeaes);
		A.setNombreBatterieAES(nbbatterieaes);
		A.setxBatterieAES(xbatterieaes);
		A.setyBatterieAES(ybatterieaes);
		A.sethBatteriesAES(hbatterieaes);
		A.setTypeBatterieAES(typebatterieaes);
		A.setTestVoltBatterieAES(testvoltaes);
		A.setTestAmpereBatterieAES(testampaes);
		A.setTestVoltChargeurAES(testchargeuraes);
		A.setMarche(true);
		A.setBatiment(B);
		A.setConclusion("--");
		return A;
	}

	// Ajout dans la base de donnée
	// Organe
	public void ajoutOrgane(List<Organe> organes){
		int i;
		for(i=0;i<organes.size();i++){
			em.merge(organes.get(i));
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
		if(Interv instanceof Verification ) {
			if( Interv.getOrgane() instanceof Alarme || Interv.getOrgane() instanceof DesenfumageNaturel)
			em.merge(Interv);
		}
		else 
			em.persist(Interv);
		
		O.addInterventions(Interv);
		O.setConclusion(conclusion);
		if(Interv instanceof Installation){
			B.addOrganes(O);
			em.merge(B);
			em.persist(O);
		}
		else {
			if(Interv instanceof Preventive && O instanceof Alarme){
				if (O.getInterventions() == null) {
				List<Intervention> interv = new ArrayList<Intervention>();
				O.setInterventions(interv);
				}
				O.addInterventions(Interv);
				String[] result;
				String Obs;
				Obs=Interv.getObservation();
				result=Obs.split(";");
				O.setObservation(result[0]);
				em.merge(O);
			}
			else {
				if (O.getInterventions() == null) {
				List<Intervention> interv = new ArrayList<Intervention>();
				O.setInterventions(interv);
				}
				O.addInterventions(Interv);
				em.merge(O);
			}
		}
		return Interv;
	}
	public Pdfgenere ajoutnewpdf(){
		Pdfgenere pdf = new Pdfgenere();
		em.merge(pdf);
		return pdf;
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
		if(O instanceof Alarme || O instanceof DesenfumageNaturel){
			
		}
		else{
			O.setObservation(Obs);
		}
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
	// remplacement eclairage
	public Eclairage remplacementeclairage(Eclairage E,String Emp,String Obs, TypeEclairage type, MarqueEclairage marque, boolean presence,boolean fonctionne,Typetelecommande typetel,boolean marche){
		E.setEmplacement(Emp);
		E.setObservation(Obs);
		E.setType(type);
		E.setMarque(marque);
		E.setPresencetelecommande(presence);
		E.setFonctionnementtelecommande(fonctionne);
		E.setTypetelecommande(typetel);
		E.setMarche(marche);
		return E;
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
	public Coupefeu remplacementcoupefeu(Coupefeu C, String Emp, String Obs,TypeCoupefeu type ,boolean marche){
		C.setEmplacement(Emp);
		C.setObservation(Obs);
		C.setMarche(marche);
		C.setType(type);
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
	public RIA remplacementria(RIA R,String Emp,String Obs,TypeRia type,int pressionstat,int pressiondynam,int portee, boolean marche){
		R.setEmplacement(Emp);
		R.setObservation(Obs);
		R.setMarche(marche);
		R.setType(type);
		R.setPressionStatique(pressionstat);
		R.setPressionDynamique(pressiondynam);
		R.setPortee(portee);
		return R;
	}
	
	public Alarme remplacementalarme(Alarme A, String Emp,String Obs,MarqueAlarme marquealarme,TypeAlarme typealarme,int annee,int nombrebatterie,int xbatterie,int ybatterie,
			int hbatterie,TypeBatterie typebatterie,int testvoltbatterie,int testampbatterie,int testchargeurbatterie,int nboptique, 
			String optique,int nbionique,String obsionique,int nbthermique,String thermique,int nbthermov,String thermov,
			int nbflamme,String flamme,int nbaspiration,String aspiration,int nbreport,String report,int nbmanuel,String manuel,
			int nbsonore,String sonore,int nblumineux,String lumineux,int nbAES,TypeAES typeaes, int nbbatterieaes, int xbatterieaes,
			int ybatterieaes,int hbatterieaes,TypeBatterieAES typebatterieaes, int testvoltaes,int testampaes, int testchargeuraes,boolean marche ){
		A.setEmplacement(Emp);
		A.setObservation(Obs);
		A.setMarque(marquealarme);
		A.setType(typealarme);
		A.setAnnee(annee);
		A.setNombreBatterie(nombrebatterie);
		A.setXbatterie(xbatterie);
		A.setYbatterie(ybatterie);
		A.setHbatterie(hbatterie);
		A.setTypeBatterie(typebatterie);
		A.setTestVoltBatterie(testvoltbatterie);
		A.setTestAmpereBatterie(testampbatterie);
		A.setTestVoltChargeur(testchargeurbatterie);
		A.setNombreDetecteurOptique(nboptique);
		A.setObservationDetecteurOptique(optique);
		A.setNombreDetecteurIonique(nbionique);
		A.setObservationDetecteurIonique(obsionique);
		A.setNombreDetecteurThermique(nbthermique);
		A.setObservationDetecteurThermique(thermique);
		A.setNombreDetecteurThermovelocimetrique(nbthermov);
		A.setObservationDetecteurThermovelocimetrique(thermov);
		A.setNombreDetecteurFlammes(nbflamme);
		A.setObservationDetecteurFlammes(flamme);
		A.setNombreDetecteurAspiration(nbaspiration);
		A.setObservationDetecteurAspiration(aspiration);
		A.setNombreAutreReport(nbreport);
		A.setObservationAutreReport(report);
		A.setNombreDeclencheurManuel(nbmanuel);
		A.setObservationDeclencheurManuel(manuel);
		A.setNombreDiffusionSonore(nbsonore);
		A.setObservationDiffusionSonore(sonore);
		A.setNombreDiffusionSonoreFlash(nblumineux);
		A.setObservationDiffusionSonoreFlash(lumineux);
		A.setNombreAES(nbAES);
		A.setTypeAES(typeaes);
		A.setNombreBatterieAES(nbbatterieaes);
		A.setxBatterieAES(xbatterieaes);
		A.setyBatterieAES(ybatterieaes);
		A.sethBatteriesAES(hbatterieaes);
		A.setTypeBatterieAES(typebatterieaes);
		A.setTestVoltBatterieAES(testvoltaes);
		A.setTestAmpereBatterieAES(testampaes);
		A.setTestVoltChargeurAES(testchargeuraes);
		A.setMarche(marche);
		return A;
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
	
	
	// Maintenance : Preventive
	public Preventive MaintenancePreventiveAlarme(Organe O, String Obs, String Obsraj, int numerotechnicien, 
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
//		if (O.getInterventions() == null) {
//			List<Intervention> interv = new ArrayList<Intervention>();
//			O.setInterventions(interv);
//		}
//		O.addInterventions(MP);
//		O.setObservation(Obs);
//		O.setConclusion(Obsraj);
//		O.setMarche(marche);
//		em.persist(MP);
//		em.merge(O);
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

	// liste de tous les types d'eclairage
	public List<TypeEclairage> touslesTypeEclairage() {
		List<TypeEclairage> T = em.createQuery("from TypeEclairage t").getResultList();
		return T;
	}
	// liste de toutes les marques d'eclairage
	@SuppressWarnings("unchecked")
	public List<MarqueEclairage> touteslesMarqueEclairage() {
		List<MarqueEclairage> M = em.createQuery("from MarqueEclairage m").getResultList();
		return M;
	}
	// liste de tous les types de telecommande
	public List<Typetelecommande> touslesTypetelecommande() {
		List<Typetelecommande> T = em.createQuery("from Typetelecommande t").getResultList();
		return T;
	}
	// liste de tous les types RIA
	@SuppressWarnings("unchecked")
	public List<TypeRia> touslesTypeRIA() {
		List<TypeRia> T = em.createQuery("from TypeRia t").getResultList();
		return T;
	}
	// liste de tous les types de Coupe-feu
	@SuppressWarnings("unchecked")
	public List<TypeCoupefeu> touslesTypeCoupefeu() {
		List<TypeCoupefeu> T = em.createQuery("from TypeCoupefeu t").getResultList();
		return T;
	}
	// liste de tous les types d'alarme
	@SuppressWarnings("unchecked")
	public List<TypeAlarme> touslesTypeAlarme() {
		List<TypeAlarme> T = em.createQuery("from TypeAlarme t").getResultList();
		return T;
	}
	// liste de toutes les marques d'alarme
	@SuppressWarnings("unchecked")
	public List<MarqueAlarme> touteslesMarqueAlarme() {
		List<MarqueAlarme> M = em.createQuery("from MarqueAlarme m").getResultList();
		return M;
	}
	// liste de tous les types de batterie
	@SuppressWarnings("unchecked")
	public List<TypeBatterie> touslesTypeBatterie() {
		List<TypeBatterie> T = em.createQuery("from TypeBatterie t").getResultList();
		return T;
	}
	// liste de tous les types AES
	@SuppressWarnings("unchecked")
	public List<TypeAES> touslesTypeAES() {
		List<TypeAES> T = em.createQuery("from TypeAES t").getResultList();
		return T;
	}
	// liste de tous les types de batterie AES
	@SuppressWarnings("unchecked")
	public List<TypeBatterieAES> touslesTypeBatterieAES() {
		List<TypeBatterieAES> T = em.createQuery("from TypeBatterieAES t").getResultList();
		return T;
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
	
	// derniere conclusion : Verification Alarme
	public String rechercheConclusionVerificationAlarme(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Verification> verifications = em.createQuery("FROM Verification v where v.organe.batiment.numero = "+numeroBatiment).getResultList();
		int test,i;
		test=0;
		i=verifications.size()-1;
		String conclusion="--";
		if(verifications.size()!=0){
			while(test==0 && i>-1) {
				if(verifications.get(i).getOrgane() instanceof Alarme ){
					test=1;
				}
				i--;
			}
			if(test==1)
				conclusion=verifications.get(i+1).getConclusion();
		}
		return conclusion;
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
	// derniere conclusion : Verification Eclairage
	public String rechercheConclusionVerificationEclairage(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Verification> verifications = em.createQuery("FROM Verification v where v.organe.batiment.numero = "+numeroBatiment).getResultList();
		int test,i;
		test=0;
		i=verifications.size()-1;
		String conclusion="--";
		if(verifications.size()!=0){
			while(test==0 && i>-1) {
				if(verifications.get(i).getOrgane() instanceof Eclairage ){
					test=1;
				}
				i--;
			}
			if(test==1)
				conclusion=verifications.get(i+1).getConclusion();
		}
		return conclusion;
	}
	// derniere conclusion : Verification RIA
	public String rechercheConclusionVerificationRia(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Verification> verifications = em.createQuery("FROM Verification v where v.organe.batiment.numero = "+numeroBatiment).getResultList();
		int test,i;
		test=0;
		i=verifications.size()-1;
		String conclusion="--";
		if(verifications.size()!=0){
			while(test==0 && i>-1) {
				if(verifications.get(i).getOrgane() instanceof RIA ){
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
	// derniere conclusion : Maintenance Corrective Eclairage
	public String rechercheConclusionMaintenancecorrEclairage(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Corrective> maintenancecorrective = em.createQuery("FROM Corrective m where m.organe.batiment.numero = "+numeroBatiment).getResultList();
		String conclusion="--";
		int test,i;
		test=0;
		i=maintenancecorrective.size()-1;
		if(maintenancecorrective.size()!=0){
			while(test==0 && i>-1) {
				if(maintenancecorrective.get(i).getOrgane() instanceof Eclairage ){
					test=1;
				}
				i--;
			}
			if(test==1)
				conclusion=maintenancecorrective.get(i+1).getConclusion();
		}
		return conclusion;
	}
	
	// derniere conclusion : Maintenance Corrective Eclairage
	public String rechercheConclusionMaintenancecorrRia(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Corrective> maintenancecorrective = em.createQuery("FROM Corrective m where m.organe.batiment.numero = "+numeroBatiment).getResultList();
		String conclusion="--";
		int test,i;
		test=0;
		i=maintenancecorrective.size()-1;
		if(maintenancecorrective.size()!=0){
			while(test==0 && i>-1) {
				if(maintenancecorrective.get(i).getOrgane() instanceof RIA ){
					test=1;
				}
				i--;
			}
			if(test==1)
				conclusion=maintenancecorrective.get(i+1).getConclusion();
		}
		return conclusion;
	}
	
	// derniere conclusion : Maintenance Corrective Alarme
	public String rechercheConclusionMaintenancecorrAlarme(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Corrective> maintenancecorrective = em.createQuery("FROM Corrective m where m.organe.batiment.numero = "+numeroBatiment).getResultList();
		String conclusion="--";
		int test,i;
		test=0;
		i=maintenancecorrective.size()-1;
		if(maintenancecorrective.size()!=0){
			while(test==0 && i>-1) {
				if(maintenancecorrective.get(i).getOrgane() instanceof Alarme ){
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
	
	// derniere conclusion : Maintenance Preventive RIA
	public String rechercheConclusionMaintenanceprevRia(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Preventive> maintenancepreventive = em.createQuery("FROM Preventive m where m.organe.batiment.numero = "+numeroBatiment).getResultList();
		String conclusion="--";
		int test,i;
		test=0;
		i=maintenancepreventive.size()-1;
		if(maintenancepreventive.size()!=0){
			while(test==0 && i>-1) {
				if(maintenancepreventive.get(i).getOrgane() instanceof RIA ){
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
		// derniere conclusion : Maintenance Eclairage
		public String rechercheConclusionMaintenanceprevEclairage(int numeroBatiment) {
			@SuppressWarnings("unchecked")
			List<Preventive> maintenancepreventive = em.createQuery("FROM Preventive m where m.organe.batiment.numero = "+numeroBatiment).getResultList();
			String conclusion="--";
			int test,i;
			test=0;
			i=maintenancepreventive.size()-1;
			if(maintenancepreventive.size()!=0){
				while(test==0 && i>-1) {
					if(maintenancepreventive.get(i).getOrgane() instanceof Eclairage ){
						test=1;
					}
					i--;
				}
				if(test==1)
					conclusion=maintenancepreventive.get(i+1).getConclusion();
			}
			return conclusion;
		}
		// derniere conclusion : Maintenance Preventive Alarme
		public String rechercheConclusionMaintenanceprevAlarme(int numeroBatiment) {
			@SuppressWarnings("unchecked")
			List<Preventive> maintenancepreventive = em.createQuery("FROM Preventive m where m.organe.batiment.numero = "+numeroBatiment).getResultList();
			String conclusion="--";
			int test,i;
			test=0;
			i=maintenancepreventive.size()-1;
			if(maintenancepreventive.size()!=0){
				while(test==0 && i>-1) {
					if(maintenancepreventive.get(i).getOrgane() instanceof Alarme ){
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
	
	public DesenfumageNaturel ajoutDesenfumage(int numbatiment,String Emp, String Obs,String cartouches, List<Ouvrant> ouvrants ) throws BatimentInconnuException{
		Batiment B = rechercheBatimentnum(numbatiment);
		if (B==null)
			throw new BatimentInconnuException();
		DesenfumageNaturel D = new DesenfumageNaturel();
		D.setEmplacement(Emp);
		D.setObservation(Obs);
		D.setCartouches(cartouches);
		D.setOuvrants(ouvrants);
		D.setBatiment(B);
		return D;
	}
	
	public List<Ouvrant> RechercheOuvrantDesenfumage(int numeroDesenfumage){
		return(List<Ouvrant>)em.createQuery("from Ouvrant o where o.desenfumagenaturel.numero ="+numeroDesenfumage).getResultList();
	}
	
	
	
	
	public Ouvrant ajoutOuvrant(String nom, String observation,String commande){
		Ouvrant O = new Ouvrant();
		O.setNom(nom);
		O.setObservation(observation);
		O.setCommande(commande);
		return O;
	}
	public void MAJOuvrantBD(Ouvrant O){
		em.merge(O);
	}
	public void AjoutOuvrantBD(Ouvrant O){
		em.persist(O);
	}
	
	// derniere conclusion : Verification DesenfumageNaturel
	public String rechercheConclusionVerificationDesenfumageNaturel(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Verification> verifications = em.createQuery("FROM Verification v where v.organe.batiment.numero = "+numeroBatiment).getResultList();
		int test,i;
		test=0;
		i=verifications.size()-1;
		String conclusion="--";
		if(verifications.size()!=0){
			while(test==0 && i>-1) {
				if(verifications.get(i).getOrgane() instanceof DesenfumageNaturel ){
					test=1;
				}
				i--;
			}
			if(test==1)
				conclusion=verifications.get(i+1).getConclusion();
		}
		return conclusion;
	}
	
	// derniere conclusion : Maintenance Corrective DesenfumageNaturel
	public String rechercheConclusionMaintenancecorrDesenfumageNaturel(int numeroBatiment) {
		@SuppressWarnings("unchecked")
		List<Corrective> maintenancecorrective = em.createQuery("FROM Corrective m where m.organe.batiment.numero = "+numeroBatiment).getResultList();
		String conclusion="--";
		int test,i;
		test=0;
		i=maintenancecorrective.size()-1;
		if(maintenancecorrective.size()!=0){
			while(test==0 && i>-1) {
				if(maintenancecorrective.get(i).getOrgane() instanceof DesenfumageNaturel ){
					test=1;
				}
				i--;
			}
			if(test==1)
				conclusion=maintenancecorrective.get(i+1).getConclusion();
		}
		return conclusion;
	}

	
	// recherche d'un organe 
		public DesenfumageNaturel rechercheDesenfumageNaturel(int numeroDesenfumageNaturel){
			return em.find(DesenfumageNaturel.class,numeroDesenfumageNaturel);
		}
		public List<DesenfumageNaturel> rechercheDesenfumageNaturelBatiment(int numeroBatiment){
			return em.createQuery("from DesenfumageNaturel e WHERE e.batiment.numero = "+numeroBatiment).getResultList();
		}
		public Ouvrant remplacementouvrant(Ouvrant O, String Commande,String Observation,String nom){
			O.setNom(nom);
			O.setCommande(Commande);
			O.setObservation(Observation);
			return O;
		}
		public DesenfumageNaturel remplacementdesenfumagenaturel(DesenfumageNaturel D, String observation, String Emp, List<Ouvrant> ouvrants, String cartouches){
			D.setCartouches(cartouches);
			D.setObservation(observation);
			D.setEmplacement(Emp);
			D.setOuvrants(ouvrants);
			return D;
		}

		// derniere conclusion : Maintenance Preventive Desenfumage naturel
		public String rechercheConclusionMaintenanceprevdesenfumagenaturel(int numeroBatiment) {
			@SuppressWarnings("unchecked")
			List<Preventive> maintenancepreventive = em.createQuery("FROM Preventive m where m.organe.batiment.numero = "+numeroBatiment).getResultList();
			String conclusion="--";
			int test,i;
			test=0;
			i=maintenancepreventive.size()-1;
			if(maintenancepreventive.size()!=0){
				while(test==0 && i>-1) {
					if(maintenancepreventive.get(i).getOrgane() instanceof DesenfumageNaturel ){
						test=1;
					}
					i--;
				}
				if(test==1)
					conclusion=maintenancepreventive.get(i+1).getConclusion();
			}
			return conclusion;
		}
	
}