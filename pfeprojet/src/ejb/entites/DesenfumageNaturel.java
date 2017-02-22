package ejb.entites;


import javax.persistence.*;


@Table(name="desenfumagenaturel")
@Entity
@PrimaryKeyJoinColumn(name="numero")
public class DesenfumageNaturel extends Organe implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	
	private String ouvrant;
	private int quantite;
	private int commandes;
	private int ouvrants;
	private String cartouches;
	private String commande;
	
	
	public String getCommande() {
		return commande;
	}
	public void setCommande(String commande) {
		this.commande = commande;
	}
	public String getOuvrant() {
		return ouvrant;
	}
	public void setOuvrant(String ouvrant) {
		this.ouvrant = ouvrant;
	}
	public int getQuantite() {
		return quantite;
	}
	public void setQuantite(int quantite) {
		this.quantite = quantite;
	}
	public int getCommandes() {
		return commandes;
	}
	public void setCommandes(int commandes) {
		this.commandes = commandes;
	}
	public int getOuvrants() {
		return ouvrants;
	}
	public void setOuvrants(int ouvrants) {
		this.ouvrants = ouvrants;
	}
	public String getCartouches() {
		return cartouches;
	}
	public void setCartouches(String cartouches) {
		this.cartouches = cartouches;
	}
	
	
	
	public DesenfumageNaturel(){}
	public void addInterventions (Intervention intervention) {
		this.getInterventions().add(intervention);
	}
}
