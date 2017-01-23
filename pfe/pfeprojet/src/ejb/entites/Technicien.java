package ejb.entites;

import java.util.List;

import javax.persistence.*;

@Table(name="technicien")
@Entity
public class Technicien implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	
	private int numero;
	private String nom;
	private String prenom;
	private String adresse;
	private String tel;
	private List<Formation> formation;
	
	public Technicien () { };

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="technicien_sequence")
	@SequenceGenerator(
			name="technicien_sequence",
			sequenceName="technicien_sequence",
			allocationSize=100
			)
	public int getNumero() {
		return numero;
	}
	public void setNumero(int newnumero) {
		this.numero=newnumero;
	}
	public String getNom () {
		return nom;
	}
	public void setNom (String newnom) {
		this.nom = newnom;
	}
	public String getPrenom() {
		return prenom;
	}
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	public String getAdresse () {
		return adresse;
	}
	public void setAdresse (String newadresse) {
		this.adresse = newadresse;
	}
	public String getTel () {
		return tel;
	}
	public void setTel (String newTel) {
		this.tel = newTel;
	}
	@ManyToMany
	public List<Formation> getFormation() {
		return formation;
	}
	public void setFormation(List<Formation> formation) {
		this.formation = formation;
	}
	@Override
	public String toString() {
		return "Nom : " + this.nom 
				+ "	\nAdresse : " + this.adresse
				+ " \nNumero de telephone : " + this.tel;
	}
}