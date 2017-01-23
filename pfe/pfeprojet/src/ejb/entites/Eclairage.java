package ejb.entites;

import javax.persistence.*;


@Table(name="eclairage")
@Entity
@PrimaryKeyJoinColumn(name="numero")
public class Eclairage extends Organe implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private String categorie;
	private boolean presencetelecommande;
	private boolean fonctionnementtelecommande;
	private MarqueEclairage marqueeclairage;
	private Typetelecommande typetelecommande;

	public Eclairage () { };

	public String getCategorie () {
		return categorie;
	}
	public void setCategorie (String newVar) {
		this.categorie = newVar;
	}
	public boolean isPresencetelecommande () {
		return presencetelecommande;
	}
	public void setPresencetelecommande (boolean newVar) {
		this.presencetelecommande = newVar;
	}
	public boolean isFonctionnementtelecommande () {
		return fonctionnementtelecommande;
	}
	public void setFonctionnementtelecommande (boolean newVar) {
		this.fonctionnementtelecommande = newVar;
	}
	@ManyToOne
	public MarqueEclairage getMarqueeclairage () {
		return marqueeclairage;
	}
	public void setMarqueeclairage(MarqueEclairage marque){
		this.marqueeclairage=marque;
	}
	public void addMarqueeclairage (MarqueEclairage new_object) {
		this.marqueeclairage=new_object;
	}
	@ManyToOne
	public Typetelecommande getTypetelecommande () {
		return typetelecommande;
	}
	public void setTypetelecommande(Typetelecommande type){
		this.typetelecommande=type;
	}
	public void addTypetelecommande (Typetelecommande new_object) {
		typetelecommande=new_object;
	}
	public void addInterventions (Intervention intervention) {
		this.getInterventions().add(intervention);
	}
	public String toString(){
		return "Fiche de l'eclairage : \n  Numero de l'organe : "+this.getNumero()
				+"\nCategorie : " +this.categorie
				+"\nEmplacement : "+this.getEmplacement()
				+"\nMarque : "+this.marqueeclairage
				+"\nType Telecommande : "+this.typetelecommande
				+"\nType Observation : "+this.getObservation()+"\n"+this.getConclusion();
	}
}