package ejb.entites;
import javax.persistence.*;


@Table(name="ria")
@Entity
@PrimaryKeyJoinColumn(name="numero")
public class RIA extends Organe implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private TypeRia type;
	
	public RIA () { };
	@ManyToOne
	public TypeRia getType () {
		return type;
	}
	public void setType(TypeRia type){
		this.type=type;
	}
	public void addType (TypeRia new_type) {
		type=new_type;
	}
	public void addInterventions (Intervention intervention) {
		this.getInterventions().add(intervention);
	}

	@Override
	public String toString() {
		return "Fiche de l'organe : \nNumero : " + this.getNumero() 
				+ "\nEmplacement : " + this.getEmplacement() 
				+ "\nObservations" + this.getObservation() +"\n"+this.getConclusion()
				+ "\nTyperia" + this.type;
	}

}
