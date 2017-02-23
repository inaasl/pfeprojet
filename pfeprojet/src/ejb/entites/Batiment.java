package ejb.entites;


import java.util.*;
import javax.persistence.*;
@Table(name="batiment")
@Entity

public class Batiment implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private int numero;
	private String nom;
	private String adresse;
	private String nomresp;
	private String prenomresp;
	private String telresp;
	private boolean marche;
	
	private List<Organe> organes;
	
	private Entreprise entreprise;
	
	public Batiment () { };

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="batiment_sequence")
	@SequenceGenerator(
			name="batiment_sequence",
			sequenceName="batiment_sequence",
			allocationSize=100
			)
	public int getNumero () {
		return numero;
	}
	public void setnumero (int num) {
		this.numero = num;
	}

	public String getNom () {
		return nom;
	}
	public void setNom (String nom) {
		this.nom = nom;
	}

	public String getAdresse () {
		return adresse;
	}
	public void setAdresse (String adress) {
		this.adresse = adress;
	}

	@OneToMany(mappedBy="batiment",fetch=FetchType.EAGER)
	public List<Organe> getOrganes () {
		return (List<Organe>) organes;
	}
	public void setOrganes(List<Organe> organe){
		this.organes=organe;
	}

	public void addOrganes (Organe new_organe) {
		organes.add(new_organe);
	}
	public void removeOrganes (Organe new_organe)
	{
		organes.remove(new_organe);
	}
	@ManyToOne
	public Entreprise getEntreprise() {
		return entreprise;
	}

	public void setEntreprise(Entreprise e) {
		entreprise = e;
	}
	public String toString(){
		return "Fiche du batiment : \n  Numero du batiment : "+this.numero+"\nNom du batiment : "+this.nom
				+"\nAdresse Postale : "+this.adresse;
	}

	public String getNomresp() {
		return nomresp;
	}

	public void setNomresp(String nomresp) {
		this.nomresp = nomresp;
	}

	public String getPrenomresp() {
		return prenomresp;
	}

	public void setPrenomresp(String prenomresp) {
		this.prenomresp = prenomresp;
	}

	public boolean isMarche() {
		return marche;
	}

	public void setMarche(boolean marche) {
		this.marche = marche;
	}

	public String getTelresp() {
		return telresp;
	}

	public void setTelresp(String telresp) {
		this.telresp = telresp;
	}


}
