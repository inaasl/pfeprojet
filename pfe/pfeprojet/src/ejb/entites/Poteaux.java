package ejb.entites;
import javax.persistence.*;



@Table(name="poteaux")
@Entity
@PrimaryKeyJoinColumn(name="numero")
public class Poteaux extends Organe implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	
	private int diametre;
	private int pressionstat;
	private int pression60;
	private int pression1bar;

	public Poteaux () { };

	public int getDiametre () {
		return diametre;
	}
	public void setDiametre (int newdiametre) {
		this.diametre = newdiametre;
	}
	public int getPressionstat () {
		return pressionstat;
	}
	public void setPressionstat (int newpression) {
		this.pressionstat = newpression;
	}
	public int getPression60 () {
		return pression60;
	}
	public void setPression60 (int newpression) {
		this.pression60 = newpression;
	}
	public int getPression1bar () {
		return pression1bar;
	}
	public void setPression1bar (int newpression) {
		this.pression1bar = newpression;
	}
	public void addInterventions (Intervention intervention) {
		this.getInterventions().add(intervention);
	}
	@Override
	public String toString() {
		return "Fiche de l'organe :  \nNumero : " + this.getNumero() 
				+ "\nEmplacement : " + this.getEmplacement()
				+ "\nObservations : " + this.getObservation() +"\n"+this.getConclusion()
				+ "\nDiametre : " + this.diametre 
				+ "\nPression stat : " + this.pressionstat 
				+ "\nPression 60 : " + this.pression60 
				+ "\nPression 1bar : " + this.pression1bar;
	}
}