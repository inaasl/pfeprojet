package ejb.entites;

import javax.persistence.Entity;
import javax.persistence.Table;

@Table(name="maintenance")
@Entity

public abstract class Maintenance extends Intervention implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	public Maintenance() { }
}
