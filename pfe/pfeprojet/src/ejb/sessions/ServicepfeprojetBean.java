package ejb.sessions;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import ejb.entites.*;


@Stateless
public class ServicepfeprojetBean implements ServicepfeprojetLocal, ServicepfeprojetRemote {
	@PersistenceContext(unitName = "pfeprojet")
	protected EntityManager em;
	public ServicepfeprojetBean(){

	}
	// Recherche d'informations
	// Recherche d'une entreprise
	public List<Entreprise> rechercheEntreprise(String Nom) throws EntrepriseInconnueException{
		@SuppressWarnings("unchecked")
		List <Entreprise> E = em.createQuery("from Entreprise e where nom like '%' || :name ||'%'").setParameter("name",Nom).getResultList();
		if(E==null)
			throw new EntrepriseInconnueException();
		else
			return E;
	}
	public Entreprise rechercheEntreprisenum(int Num) throws EntrepriseInconnueException{
		Entreprise E =em.find(Entreprise.class, Num);
		if(E==null)
				throw new EntrepriseInconnueException();
		else
			return E;
	}
	// Recherche d'un batiment
	public Batiment recherchebatiment(String nomentreprise, String Nom) throws BatimentInconnuException, EntrepriseInconnueException{
		Batiment B = null;
		Entreprise E = rechercheEntreprise(nomentreprise).get(0);
		for(int i=0;i<E.getBatiments().size();i++)
			if(E.getBatiments().get(i).getNom().compareTo(Nom)==0)
				B=E.getBatiments().get(i);
		if(B==null)
			throw new BatimentInconnuException();
		else
			return B;
	}
	public Batiment rechercheBatimentnum(int Num) throws BatimentInconnuException{
		Batiment B =em.find(Batiment.class, Num);
		if(B==null)
				throw new BatimentInconnuException();
		else
			return B;
	}
	// Recherche d'un technicien
	public List<Technicien> rechercheTechnicien(String Nom) throws TechnicienInconnuException{
		@SuppressWarnings("unchecked")
		List <Technicien> T = em.createQuery("from Technicien t where nom like :name").setParameter("name",Nom).getResultList();
		if(T==null)
			throw new TechnicienInconnuException();
		else
			return T;
	}
	
	public Technicien rechercheTechniciennum(int Num) throws TechnicienInconnuException{
		Technicien T =em.find(Technicien.class, Num);
		if(T==null)
				throw new TechnicienInconnuException();
		else
			return T;
	}
	// Fonctions d'ajouts
	// Ajout d'une entreprise
	public void ajouterEntreprise(String nom, String adresse, String tel){
		Entreprise E = new Entreprise();
		E.setNom(nom);
		E.setAdresse(adresse);
		E.setTel(tel);
		em.persist(E);
	}
	//Ajout d'un technicien
	public void ajouterTechnicien(String nom,String prenom, String adresse, String tel){
		Technicien T = new Technicien();
		T.setNom(nom);
		T.setPrenom(prenom);
		T.setAdresse(adresse);
		T.setTel(tel);
		em.persist(T);
	}
	//Ajout d'un batiment
	public void ajouterBatiment(String nomentreprise, String nom, String adresse) throws EntrepriseInconnueException{
		Entreprise E = rechercheEntreprise(nomentreprise).get(0);
		if(E==null){
			System.out.print("entreprise introuvable");
			throw new EntrepriseInconnueException();
		}
		else {
			Batiment B = new Batiment();
			B.setNom(nom);
			B.setAdresse(adresse);
			B.setEntreprise(E);
			E.addBatiments(B);
			em.persist(B);
			em.merge(E);
		}
	}
	// Ajout pieces
	public List<Piece> AjoutPiece(List<Piece> Pieces ,String nom){
		Piece P = new Piece(); 
		P.setNom(nom);
		Pieces.add(P);
		return Pieces;
	}

	//Interventions sur les extincteurs
	// Installation
	public void InstallationExtincteur(int Annee, String Emp, String Obs, String Obsraj, java.sql.Date date, int numtechnicien, int numbatiment) throws TechnicienInconnuException, BatimentInconnuException, EntrepriseInconnueException{
		Technicien T = rechercheTechniciennum(numtechnicien);
		Batiment B = rechercheBatimentnum(numbatiment);
		Extincteur E = new Extincteur();
		E.setAnnee(Annee);
		E.setEmplacement(Emp);
		E.setObservation(Obs);
		E.setConclusion(Obsraj);
		E.setBatiment(B);
		Installation Inst = new Installation();
		Inst.setDate(date);
		Inst.setObservation(Obs);
		Inst.setConclusion(Obsraj);
		Inst.setOrgane(E);
		Inst.setTechnicien(T);
		em.persist(Inst);
		
		if(E.getInterventions()==null) {
			List<Intervention> interv =new ArrayList<Intervention>();
			E.setInterventions(interv);
		}
		E.addInterventions(Inst);
		em.persist(E);
		B.addOrganes(E);
		em.merge(B);
		
	}
	// Verification
	public void VerificationExtincteur(int numero,String Obs, String Obsraj, int numerotechnicien, java.sql.Date date/*, List<Piece> piecesajoutees*/) throws OrganeInconnuException,TechnicienInconnuException{
		Extincteur E =em.find(Extincteur.class, numero);
		if(E==null){
			throw new OrganeInconnuException();
		}

		Technicien T = em.find(Technicien.class,numerotechnicien);
		if(T==null){
			throw new TechnicienInconnuException();
		}

		E.setObservation(Obs);
		E.setConclusion(Obsraj);

		//		for(int i=0; i<piecesajoutees.size();i++){
		//			E.getPieces().add(piecesajoutees.get(i));
		//		}
		//		
		Verification V = new Verification();
		V.setDate(date);
		V.setObservation(Obs);
		V.setConclusion(Obsraj);
		V.setTechnicien(T);
		V.setOrgane(E);
		if(E.getInterventions()==null) {
			List<Intervention> interv =new ArrayList<Intervention>();
			E.setInterventions(interv);
		}
		E.addInterventions(V);
		em.persist(V);
		em.merge(E);
	}
	//Maintenance
	//Maintenance Corrective
	public void MaintenanceCorrectiveExtincteur(int numeroExtincteur,String Obs, String Obsraj, int numerotechnicien, java.sql.Date date) throws OrganeInconnuException,TechnicienInconnuException{
		Extincteur E =em.find(Extincteur.class, numeroExtincteur);
		if(E==null){
			throw new OrganeInconnuException();
		}

		Technicien T = em.find(Technicien.class,numerotechnicien);
		if(T==null){
			throw new TechnicienInconnuException();
		}

		Corrective MC = new Corrective();
		MC.setDate(date);
		MC.setObservation(Obs);
		MC.setConclusion(Obsraj);
		MC.setTechnicien(T);
		MC.setOrgane(E);
		if(E.getInterventions()==null) {
			List<Intervention> interv =new ArrayList<Intervention>();
			E.setInterventions(interv);
		}
		E.addInterventions(MC);
		em.persist(MC);
		em.persist(E);
	}
	//Maintenance Preventive
	public void MaintenancePreventiveExtincteur(int numeroextincteur ,String Obs, String Obsraj, int numerotechnicien, java.sql.Date date/*,List<Piece> piecesajoutees*/) throws OrganeInconnuException,TechnicienInconnuException{
		Extincteur E =em.find(Extincteur.class, numeroextincteur);
		if(E==null){
			throw new OrganeInconnuException();
		}
		Technicien T = em.find(Technicien.class,numerotechnicien);
		if(T==null){
			throw new TechnicienInconnuException();
		}
		Preventive MP = new Preventive();
		MP.setDate(date);
		MP.setObservation(Obs);
		MP.setConclusion(Obsraj);
		MP.setTechnicien(T);
		MP.setOrgane(E);
		/*
		for(int i=0; i<piecesajoutees.size();i++){
			E.getPiecesextincteur().add(piecesajoutees.get(i));
			}
		 */
		if(E.getInterventions()==null) {
			List<Intervention> interv =new ArrayList<Intervention>();
			E.setInterventions(interv);
		}
		E.addInterventions(MP);
		em.persist(MP);
		em.persist(E);
	}

	// Affichages des Informations
	// Affichage de la liste des entreprises
	@SuppressWarnings("unchecked")
	public List<Entreprise> getlisteEntreprises()  {
		return em.createQuery("from Entreprise e ").getResultList();
	}
	public void affichagelisteEntreprise(){
		List<Entreprise> list = (List<Entreprise>) getlisteEntreprises();
		for(int i=0;i<list.size();i++){
			System.out.println(list.get(i).toString());
		}
	}
	// Affichage de la liste des batiments
	public void affichagelisteBatiments(String NomEntreprise) throws EntrepriseInconnueException{
		Entreprise E = em.find(Entreprise.class, NomEntreprise);
		if(E==null)
			throw new EntrepriseInconnueException();
		for(int i=0;i<E.getBatiments().size();i++){
			System.out.println(E.getBatiments().get(i).toString());
		}
	}
	// Affichage de la liste des techniciens
	@SuppressWarnings("unchecked")
	public List<Technicien> getlisteTechniciens()  {
		return em.createQuery("from Technicien t ").getResultList();
	}
	public void affichagelisteTechnicien(){
		Collection<Technicien> list = getlisteTechniciens();
		for(int i=0;i<list.size();i++){
			System.out.println(((List<Technicien>) list).get(i).toString());
		}
	}


	//Affichage d'un batiment
	public void affichageBatiment(int numerobatiment) throws BatimentInconnuException{
		Batiment B = em.find(Batiment.class, numerobatiment);
		if(B==null)
			throw new BatimentInconnuException();
		else System.out.println(B.toString());
	}
	
	
	
	// Ajout Type Extincteur
	public void ajouttypeextincteur(String nom) {
		TypeExtincteur T = new TypeExtincteur();
		T.setNom(nom);
		em.persist(T);
	}
	// recherche liste de tous les types d'extincteurs
	public List<TypeExtincteur> touslesTypeExtincteur(){
		List <TypeExtincteur> T = (List<TypeExtincteur>) em.createQuery("from TypeExtincteur t");
		return T;
	}
	// Ajout Marque Extincteur
	public void ajoutmarqueextincteur(String nom) {
		MarqueExtincteur M = new MarqueExtincteur();
		M.setNom(nom);
		em.persist(M);
	}
	public List<MarqueExtincteur> touteslesMarqueExtincteur(){
		List <MarqueExtincteur> M = (List<MarqueExtincteur>) em.createQuery("from MarqueExtincteur m");
		return M;
	}
}