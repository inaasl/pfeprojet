package ejb.entites;

import javax.persistence.*;


@Table(name="typeeclairage")
@Entity
public class TypeEclairage implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	private int numero;
	private String nom;
	public TypeEclairage () { };
	
	@Column(unique=true, nullable=false) 
	public String getNom () {
		return nom;
	}
	public void setNom (String newnom) {
		this.nom = newnom;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="typeeclairage_sequence")
	@SequenceGenerator(
			name="typeeclairage_sequence",
			sequenceName="typeeclairage_sequence",
			allocationSize=100
			)
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}
}