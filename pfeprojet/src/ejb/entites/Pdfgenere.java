package ejb.entites;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Table(name="pdf")
@Entity
public class Pdfgenere implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	private int numero;
	private List<Intervention> interventions;
	
	public Pdfgenere(){	};
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="pdf_sequence")
	@SequenceGenerator(
			name="pdf_sequence",
			sequenceName="pdf_sequence",
			allocationSize=100
			)
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}
	
	@OneToMany(mappedBy="pdf",fetch=FetchType.EAGER)
	public List<Intervention> getInterventions() {
		return interventions;
	}
	public void setInterventions(List<Intervention> interventions) {
		this.interventions = interventions;
	}
}
