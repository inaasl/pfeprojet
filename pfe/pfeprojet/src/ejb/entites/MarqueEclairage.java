package ejb.entites;
import javax.persistence.*;

@Table(name="marqueeclairage")
@Entity
public class MarqueEclairage implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private int numero;
	private String nom;
	
	public MarqueEclairage () { };
	
	@Column(unique=true, nullable=false) 
	public String getNom () {
		return nom;
	}
	public void setNom (String newnom) {
		this.nom = newnom;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="marqueeclairage_sequence")
	@SequenceGenerator(
			name="marqueeclairage_sequence",
			sequenceName="marqueeclairage_sequence",
			allocationSize=100
			)
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}
}
