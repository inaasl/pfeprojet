package ejb.entites;

import javax.persistence.*;

@Table(name="compte")
@Entity

public class Compte implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	private int numero;
	private int numeroutilisateur;
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
	public int getNumero() {
		return numero;
	}
	public void setNumero(int num) {
		this.numero = num;
	}
	public int getNumeroutilisateur() {
		return numeroutilisateur;
	}
	public void setNumeroutilisateur(int numclient) {
		this.numeroutilisateur = numclient;
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