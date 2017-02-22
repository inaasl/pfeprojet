package ejb.entites;
import javax.persistence.*;

@Table(name="typecoupefeu")
@Entity
public class TypeCoupefeu implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private int numero;
	private String nom;
	public TypeCoupefeu () { };
	
	@Column(unique=true, nullable=false) 
	public String getNom () {
		return nom;
	}
	public void setNom (String newnom) {
		this.nom = newnom;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="typecoupefeu_sequence")
	@SequenceGenerator(
			name="typecoupefeu_sequence",
			sequenceName="typecoupefeu_sequence",
			allocationSize=100
			)
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}
}
