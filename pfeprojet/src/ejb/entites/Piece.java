package ejb.entites;

import javax.persistence.*;

@Table(name="piece")
@Entity

public class Piece implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	private int numero;
	private String nom;
	
	private Organe organe;
	private Preventive preventive;

	public Piece () { };
	
	@Id 
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="piece_sequence")
	@SequenceGenerator(
			name="piece_sequence",
			sequenceName="piece_sequence",
			allocationSize=100
			)
	public int getNumero () {
		return numero;
	}
	public void setNumero (int newnumero) {
		this.numero = newnumero;
	}
	public String getNom () {
		return nom;
	}
	public void setNom (String newnom) {
		this.nom = newnom;
	}
	@ManyToOne
	public Organe getOrgane() {
		return organe;
	}
	public void setOrgane(Organe organe) {
		this.organe = organe;
	}
	@ManyToOne
	public Preventive getPreventive() {
		return preventive;
	}
	public void setPreventive(Preventive preventive) {
		this.preventive = preventive;
	}
	@Override
	public String toString() {
		return "Id : " + this.numero 
				+"\nNom : "+ this.nom;
	}
}