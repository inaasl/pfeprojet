package ejb.entites;

import javax.persistence.*;


@Table(name="marqueextincteur")
@Entity
public class MarqueExtincteur implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	private int numero;
	
	private String nom;

	public MarqueExtincteur () { };
	
	@Column(unique=true, nullable=false) 
	public String getNom () {
		return nom;
	}
	public void setNom (String newnom) {
		this.nom = newnom;
	}
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="marqueextincteur_sequence")
	@SequenceGenerator(
			name="marqueextincteur_sequence",
			sequenceName="marqueextincteur_sequence",
			allocationSize=100
			)
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}

}
