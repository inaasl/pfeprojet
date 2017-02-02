package ejb.entites;


import java.util.*;
import javax.persistence.*;


@Table(name="entreprise")
@Entity

public class Entreprise implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private int numero;
	private String nom;
	private String adresse;
	private String tel;
	private String adressemail;
	private String nominterlocuteur;
	
	private List<Batiment> batiments;

	public Entreprise () { };

	@Id 
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="entreprise_sequence")
	@SequenceGenerator(
			name="entreprise_sequence",
			sequenceName="entreprise_sequence",
			allocationSize=100
			)
	public int getNumero() {
		return numero;
	}
	public void setNumero(int numero) {
		this.numero = numero;
	}
	public String getNom () {
		return nom;
	}
	public void setNom (String newVar) {
		this.nom = newVar;
	}

	public String getAdresse () {
		return adresse;
	}
	public void setAdresse (String newVar) {
		this.adresse = newVar;
	}
	public String getTel () {
		return tel;
	}
	public void setTel (String newVar) {
		this.tel = newVar;
	}
	@OneToMany(mappedBy="entreprise",fetch=FetchType.EAGER)
	public List<Batiment> getBatiments () {
		return (List<Batiment>) batiments;
	}
	public void setBatiments(List<Batiment> batiments){
		this.batiments=batiments;
	}
	public void addBatiments (Batiment new_object) {
		batiments.add(new_object);
	}
	public void removeBatiments (Batiment new_object)
	{
		batiments.remove(new_object);
	}
	public String getNominterlocuteur() {
		return nominterlocuteur;
	}
	public void setNominterlocuteur(String nominterlocuteur) {
		this.nominterlocuteur = nominterlocuteur;
	}
	public String getAdressemail() {
		return adressemail;
	}

	public void setAdressemail(String adressemail) {
		this.adressemail = adressemail;
	}
	public String toString(){
		return "Fiche de l'entreprise : \n  Nom de l'entreprise : "+this.nom
				+"\nAdresse Postale : "+this.adresse
				+"\n Numero de telephone : "+this.tel;
	}


}