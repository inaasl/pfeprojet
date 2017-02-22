package ejb.entites;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Table(name="typebatterie")
@Entity
public class TypeBatterie implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private int numero;
	private String nom;
	public TypeBatterie () { };
	
	@Column(unique=true, nullable=false) 
	public String getNom () {
		return nom;
	}
	public void setNom (String newnom) {
		this.nom = newnom;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="typebatterie_sequence")
	@SequenceGenerator(
			name="typebatterie_sequence",
			sequenceName="typebatterie_sequence",
			allocationSize=100
			)
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}
}
