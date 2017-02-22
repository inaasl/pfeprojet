package ejb.entites;
import javax.persistence.*;


@Table(name="ria")
@Entity
@PrimaryKeyJoinColumn(name="numero")
public class RIA extends Organe implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private TypeRia type;
	private int pressionStatique;
	private int pressionDynamique;
	private int portee;
	
	public RIA () { };
	@ManyToOne
	@JoinColumn(name="numerotype")
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
	public int getPressionStatique() {
		return pressionStatique;
	}
	public void setPressionStatique(int pressionStatique) {
		this.pressionStatique = pressionStatique;
	}
	public int getPressionDynamique() {
		return pressionDynamique;
	}
	public void setPressionDynamique(int pressionDynamique) {
		this.pressionDynamique = pressionDynamique;
	}
	public int getPortee() {
		return portee;
	}
	public void setPortee(int portee) {
		this.portee = portee;
	}

}
