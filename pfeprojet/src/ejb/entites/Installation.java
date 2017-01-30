package ejb.entites;

import javax.persistence.*;

@Table(name="installation")
@Entity
public class Installation extends Intervention implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	public Installation () { };

}
