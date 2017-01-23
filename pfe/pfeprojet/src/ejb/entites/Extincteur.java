package ejb.entites;
import java.util.*;
import javax.persistence.*;


@Table(name="extincteur")
@Entity
@PrimaryKeyJoinColumn(name="numero")
public class Extincteur extends Organe implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	private int annee;
	private TypeExtincteur type;
	private MarqueExtincteur marque;
	private List<Piece> pieces;

	public Extincteur () { };
	public int getAnnee () {
		return annee;
	}
	public void setAnnee (int newVar) {
		this.annee = newVar;
	}
	@ManyToOne
	public TypeExtincteur getType () {
		return type;
	}
	public void setType(TypeExtincteur type){
		this.type=type;
	}
	public void addType (TypeExtincteur new_object) {
		type=new_object;
	}
	@ManyToOne
	public MarqueExtincteur getMarque () {
		return marque;
	}
	public void setMarque(MarqueExtincteur marque){
		this.marque=marque;
	}
	public void addMarqueextincteur (MarqueExtincteur new_object) {
		marque=new_object;
	}
	@OneToMany(mappedBy="extincteur",fetch=FetchType.EAGER)
	public List<Piece> getPieces () {
		return (List<Piece>) pieces;
	}
	public void setPieces(List<Piece> pieces){
		this.pieces=pieces;
	}
	public void addPiecesextincteur (Piece new_piece) {
		pieces.add(new_piece);
	}
	public void removePiecesextincteur (Piece piece)
	{
		pieces.remove(piece);
	}
	public void addInterventions (Intervention intervention) {
		this.getInterventions().add(intervention);
	}
	@Override
	public String toString() {
		return "Fiche Extincteur : \nNumeroExtincteur=" + this.getNumero() 
				+ "\nEmplacement : " + this.getEmplacement()
				+ "\nObservation : " + this.getObservation()+"\n"+this.getConclusion() 
				+ "\nAnnee : " + this.annee
				+ "\nType : " + this.type
				+ "\nMarque " + this.marque;
	}
}