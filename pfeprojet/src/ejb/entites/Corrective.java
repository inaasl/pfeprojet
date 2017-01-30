package ejb.entites;
import javax.persistence.*;

@Table(name="maintenancecorrective")
@Entity

public class Corrective extends Maintenance implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	public Corrective () { };

}