package ejb.entites;

import java.sql.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Table(name="intervention")
@Entity
public abstract class Intervention implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	
	
	private int numero;
	private Date date;
	private String conclusion;
	

	private String observation;
	
	private Pdfgenere pdf;	
	private Technicien technicien;
	private Organe organe;
	
	public Intervention() { }
	

	@Id 
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="intervention_sequence")
	@SequenceGenerator(
			name="intervention_sequence",
			sequenceName="intervention_sequence",
			allocationSize=100
			)
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	@Column(length=2000)
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
	@ManyToOne
	public Technicien getTechnicien() {
		return technicien;
	}
	public void setTechnicien(Technicien technicien) {
		this.technicien = technicien;
	}
	@ManyToOne
	public Organe getOrgane() {
		return organe;
	}
	public void setOrgane(Organe organe) {
		this.organe = organe;
	}

	@ManyToOne
	public Pdfgenere getPdf() {
		return pdf;
	}


	public void setPdf(Pdfgenere pdf) {
		this.pdf = pdf;
	}



}