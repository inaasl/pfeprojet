package ejb.entites;

import javax.persistence.*;

@Table(name="piece")
@Entity

public class Piece implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	private int numero;
	private String nom;
	private Extincteur extincteur;
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
	public Extincteur getExtincteur() {
		return extincteur;
	}
	public void setExtincteur(Extincteur extincteur) {
		this.extincteur = extincteur;
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