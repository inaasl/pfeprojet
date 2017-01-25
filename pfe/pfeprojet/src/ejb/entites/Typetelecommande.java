package ejb.entites;

import javax.persistence.*;

@Table(name="typetelecommande")
@Entity
public class Typetelecommande implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private int numero;
	private String nom;
	public Typetelecommande () { };
	@Column(unique=true, nullable=false) 
	public String getNom () {
		return nom;
	}
	public void setNom (String newnom) {
		this.nom = newnom;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="typetelecomm_sequence")
	@SequenceGenerator(
			name="typetelecomm_sequence",
			sequenceName="typetelecomm_sequence",
			allocationSize=100
			)
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}
}
