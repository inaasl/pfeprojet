package ejb.entites;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Table(name="typebatterieaes")
@Entity
public class TypeBatterieAES implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private int numero;
	private String nom;
	public TypeBatterieAES () { };
	
	@Column(unique=true, nullable=false) 
	public String getNom () {
		return nom;
	}
	public void setNom (String newnom) {
		this.nom = newnom;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="typebatterieaes_sequence")
	@SequenceGenerator(
			name="typebatterieaes_sequence",
			sequenceName="typebatterieaes_sequence",
			allocationSize=100
			)
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}
}
