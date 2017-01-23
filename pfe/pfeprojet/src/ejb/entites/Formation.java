package ejb.entites;
import java.sql.Date;
import java.util.*;
import javax.persistence.*;


@Table(name="formation")
@Entity
public class Formation implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	private int numero;
	private String nom;
	private Date date;
	private String Description;
	private List<Technicien> techniciens;
	public Formation () { };

	@Id 
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="formation_sequence")
	@SequenceGenerator(
			name="formation_sequence",
			sequenceName="formation_sequence",
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
	public void setNom (String newnom) {
		this.nom = newnom;
	}
	
	public Date getDate () {
		return date;
	}
	public void setDate (Date newdate) {
		this.date = newdate;
	}
	@ManyToMany(mappedBy="formation")
	public List<Technicien> getTechniciens() {
		return (List<Technicien>) techniciens;
	}
	public void setTechniciens(List<Technicien> techniciens){
		this.techniciens=techniciens;
	}
	public void addTechniciens (Technicien technicien) {
		techniciens.add(technicien);
	}
	public void removeTechniciens (Technicien technicien)
	{
		techniciens.remove(technicien);
	}
	public String getDescription() {
		return Description;
	}

	public void setDescription(String description) {
		Description = description;
	}
	private String afficherlistedestechniciensparticipants(){
		String result="";
		for(int i=0;i<techniciens.size();i++){
			result+=techniciens.get(i).toString();
		}
		return result;
	}

	@Override
	public String toString() {
		return "Fiche Formation : \nNom de la formation : " + this.nom			+ "\nDate de la Formation=" + this.date
				+ "\nListe des techniciens participants : \n" + afficherlistedestechniciensparticipants();
	}
}