package ejb.entites;

import javax.persistence.*;


@Table(name="eclairage")
@Entity
@PrimaryKeyJoinColumn(name="numero")
public class Eclairage extends Organe implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private TypeEclairage type;
	private boolean presencetelecommande;
	private boolean fonctionnementtelecommande;
	
	private MarqueEclairage marque;
	private Typetelecommande typetelecommande;

	public Eclairage () { };

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
	public MarqueEclairage getMarque () {
		return marque;
	}
	public void setMarque(MarqueEclairage marque){
		this.marque=marque;
	}
	public void addMarque (MarqueEclairage new_object) {
		this.marque=new_object;
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
	
	@ManyToOne
	public TypeEclairage getType() {
		return type;
	}

	public void setType(TypeEclairage typeeclairage) {
		this.type = typeeclairage;
	}
	
	public String toString(){
		return "Fiche de l'eclairage : \n  Numero de l'organe : "+this.getNumero()
				+"\nCategorie : " +this.type.getNom()
			//	+"\nEmplacement : "+this.getEmplacement()
				+"\nMarque : "+this.marque
				+"\nType Telecommande : "+this.typetelecommande
				+"\nType Observation : "+this.getObservation()+"\n"+this.getConclusion();
	}
}