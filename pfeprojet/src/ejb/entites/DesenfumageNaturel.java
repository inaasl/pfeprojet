package ejb.entites;


import java.util.List;

import javax.persistence.*;


@Table(name="desenfumagenaturel")
@Entity
@PrimaryKeyJoinColumn(name="numero")
public class DesenfumageNaturel extends Organe implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	private List<Ouvrant> ouvrants;
	private String cartouches;
	
	public DesenfumageNaturel(){}
	
	public void addInterventions (Intervention intervention) {
		this.getInterventions().add(intervention);
	}
	@OneToMany(mappedBy="desenfumagenaturel",fetch=FetchType.EAGER)
	public List<Ouvrant> getOuvrants() {
		return ouvrants;
	}
	public void setOuvrants(List<Ouvrant> ouvrants) {
		this.ouvrants = ouvrants;
	}

	public String getCartouches() {
		return cartouches;
	}

	public void setCartouches(String cartouches) {
		this.cartouches = cartouches;
	}
}
