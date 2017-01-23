package ejb.entites;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Table(name="organe")
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public abstract class Organe implements java.io.Serializable {
	

	private static final long serialVersionUID = 1L;
	
	private int numero;
	private String emplacement;
	private String conclusion;
	private String observation;
	private List<Intervention> interventions;
	
	private Batiment batiment; 
	
	@Id 
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="organe_sequence")
	@SequenceGenerator(
			name="organe_sequence",
			sequenceName="organe_sequence",
			allocationSize=100
			)
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}
	public String getEmplacement() {
		return emplacement;
	}
	public void setEmplacement(String emplacement) {
		this.emplacement = emplacement;
	}
	
	public String getConclusion() {
		return conclusion;
	}
	public void setConclusion(String observationsrajoutees) {
		this.conclusion = observationsrajoutees;
	}
	
	public String getObservation() {
		return observation;
	}
	public void setObservation(String observation) {
		this.observation = observation;
	}
	@OneToMany(mappedBy="organe",fetch=FetchType.EAGER)
	public List<Intervention> getInterventions() {
		return interventions;
	}
	public void setInterventions(List<Intervention> interventions) {
		this.interventions = interventions;
	}
	public abstract void addInterventions (Intervention intervention);
	@ManyToOne
	public Batiment getBatiment() {
		return batiment;
	}
	public void setBatiment(Batiment batiment) {
		this.batiment = batiment;
	}
}
