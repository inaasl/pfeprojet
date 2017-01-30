package ejb.entites;

import java.util.List;

import javax.persistence.*;

@Table(name="maintenancepreventive")
@Entity
public class Preventive extends Maintenance implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private List<Piece> pieces;
	
	public Preventive () { }
	@OneToMany(mappedBy="preventive",fetch=FetchType.EAGER)
	public List<Piece> getPieces() {
		return pieces;
	}
	public void setPieces(List<Piece> pieces) {
		this.pieces = pieces;
	}
}