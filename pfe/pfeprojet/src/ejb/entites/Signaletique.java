package ejb.entites;
import javax.persistence.*;

@Table(name="signaletique")
@Entity
@PrimaryKeyJoinColumn(name="numero")
public class Signaletique extends Organe implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	public Signaletique () { };
	
	public void addInterventions (Intervention intervention) {
		this.getInterventions().add(intervention);
	}
	@Override
	public String toString() {
		return "Fiche de l'organe : \nNumero : " + this.getNumero()
				+ "\nEmplacement : " + this.getEmplacement() 
				+ "\nObservations : " + this.getObservation() + "\n"+ this.getConclusion();
	}
}
