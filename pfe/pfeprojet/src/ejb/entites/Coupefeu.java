package ejb.entites;

import javax.persistence.*;


@Table(name="coupefeu")
@Entity
@PrimaryKeyJoinColumn(name="numero")
public class Coupefeu extends Organe implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private String Type;

	public Coupefeu () { };
	public void setTypeCoupefeu (String newVar) {
		this.Type = newVar;
	}
	public String getTypeCoupefeu () {
		return Type;
	}
	public void addInterventions (Intervention intervention) {
		this.getInterventions().add(intervention);
	}
	public String toString(){
		return "Fiche du coupe-feu : \n  Numero de l'organe : "+this.getNumero()
				+"\nType : "+this.Type
				+"\nEmplacement : "+this.getEmplacement()
				+"\nObservations : "+this.getObservation()+"\n"+this.getConclusion();
	}
}
