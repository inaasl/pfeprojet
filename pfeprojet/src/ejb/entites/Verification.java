package ejb.entites;

import javax.persistence.*;


@Table(name="verification")
@Entity
public class Verification extends Intervention implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	public Verification () { };
}
