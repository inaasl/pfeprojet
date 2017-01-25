package ejb.entites;

import javax.persistence.*;


@Table(name="typeria")
@Entity
public class TypeRia implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private int numero;
	private String nom;
	public TypeRia () { };
	@Column(unique=true, nullable=false) 
	public String getNom () {
		return nom;
	}
	public void setNom (String newnom) {
		this.nom = newnom;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="typeria_sequence")
	@SequenceGenerator(
			name="typeria_sequence",
			sequenceName="typeria_sequence",
			allocationSize=100
			)
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}
}
