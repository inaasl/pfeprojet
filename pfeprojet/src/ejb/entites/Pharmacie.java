package ejb.entites;
import javax.persistence.*;

@Table(name="pharmacie")
@Entity
@PrimaryKeyJoinColumn(name="numero")
public class Pharmacie extends Organe implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	private int annee;
	private int capacite;
	
	public Pharmacie () { };
	public int getAnnee () {
		return annee;
	}
	public void setAnnee (int newannee) {
		this.annee = newannee;
	}

	public int getCapacite () {
		return capacite;
	}
	public void setCapacite (int newcapacite) {
		this.capacite = newcapacite;
	}
	@Override
	public String toString() {
		return "Fiche Pharmacie : \nNumero : " + this.getNumero() 
				+ "\nEmplacement : " + this.getEmplacement()
				+ "\nObservations : " + this.getObservation() +"\n"+this.getConclusion() 
				+ "\nAnnee : " + this.annee
				+ "\nCapacite : " + this.capacite;
	}
	public void addInterventions (Intervention intervention) {
		this.getInterventions().add(intervention);
	}
}