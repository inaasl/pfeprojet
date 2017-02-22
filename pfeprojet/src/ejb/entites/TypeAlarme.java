package ejb.entites;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Table(name="typealarme")
@Entity
public class TypeAlarme implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private int numero;
	private String nom;
	
	public TypeAlarme () { };
	
	@Column(unique=true, nullable=false) 
	public String getNom () {
		return nom;
	}
	public void setNom (String newnom) {
		this.nom = newnom;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="typealarme_sequence")
	@SequenceGenerator(
			name="typealarme_sequence",
			sequenceName="typealarme_sequence",
			allocationSize=100
			)
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}
}
