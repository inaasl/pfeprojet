package ejb.entites;

import javax.persistence.*;

@Table(name="typeextincteur")
@Entity
public class TypeExtincteur implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private int numero;
	private String nom;
	public TypeExtincteur () { };
	@Column(unique=true, nullable=false) 
	public String getNom () {
		return nom;
	}
	public void setNom (String newnom) {
		this.nom = newnom;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="typeextincteur_sequence")
	@SequenceGenerator(
			name="typeextincteur_sequence",
			sequenceName="typeextincteur_sequence",
			allocationSize=100
			)
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}
}
