package ejb.entites;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Table(name="ouvrant")
@Entity
public class Ouvrant implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private int numero;
	private String nom;

	private String observation;

	private String commande;
	
	private DesenfumageNaturel desenfumagenaturel;
	
	public Ouvrant(){}
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="ouvrant_sequence")
	@SequenceGenerator(
			name="ouvrant_sequence",
			sequenceName="ouvrant_sequence",
			allocationSize=100
			)
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getCommande() {
		return commande;
	}
	public void setCommande(String commande) {
		this.commande = commande;
	}
	public String getObservation() {
		return observation;
	}
	public void setObservation(String observation) {
		this.observation = observation;
	}
	@ManyToOne
	public DesenfumageNaturel getDesenfumagenaturel() {
		return desenfumagenaturel;
	}

	public void setDesenfumagenaturel(DesenfumageNaturel desenfumagenaturel) {
		this.desenfumagenaturel = desenfumagenaturel;
	}
}
