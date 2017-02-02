package ejb.entites;

import javax.persistence.*;

@Table(name="compte")
@Entity

public class Compte implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	private int numCompte;
	private int numAdmin;
	private String login;
	private String password;
	private int statut;
	
	
	public Compte(){}
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="compte_sequence")
	@SequenceGenerator(
			name="compte_sequence",
			sequenceName="compte_sequence",
			allocationSize=100
			)
	public int getNumCompte() {
		return numCompte;
	}
	public void setNumCompte(int num) {
		this.numCompte = num;
	}
	public int getNumAdmin() {
		return numAdmin;
	}
	public void setNumAdmin(int numclient) {
		this.numAdmin = numclient;
	}
	public String getLogin() {
		return login;
	}
	public void setLogin(String login) {
		this.login = login;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getStatut() {
		return statut;
	}
	public void setStatut(int statut) {
		this.statut = statut;
	}
}