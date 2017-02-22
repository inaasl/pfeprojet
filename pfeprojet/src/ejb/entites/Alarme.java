package ejb.entites;
import javax.persistence.*;

@Table(name="alarme")
@Entity
@PrimaryKeyJoinColumn(name="numero")
public class Alarme extends Organe implements java.io.Serializable{

	private static final long serialVersionUID = 1L;
	
	private TypeAlarme type;
	private MarqueAlarme marque;
	
	private int annee;
	private int nombre;
	
	private int testVoltBatterie;
	private int testAmpereBatterie;
	private int testVoltChargeur;
	
	private int nombreBatterie;

	private int nombreDetecteurOptique;
	private String observationDetecteurOptique;

	private int nombreDetecteurIonique;
	private String observationDetecteurIonique;
	
	private int nombreDetecteurThermique;
	private String observationDetecteurThermique;
	
	private int nombreDetecteurThermovelocimetrique;
	private String observationDetecteurThermovelocimetrique;
	
	private int nombreDetecteurFlammes;
	private String observationDetecteurFlammes;
	
	private int nombreDetecteurAspiration;
	private String observationDetecteurAspiration;
	
	private int nombreAutreReport;
	private String observationAutreReport;
	
	private int nombreDeclencheurManuel;
	private String observationDeclencheurManuel;
	
	private int nombreDiffusionSonore;
	private String observationDiffusionSonore;
	
	private int nombreDiffusionSonoreFlash;
	private String observationDiffusionSonoreFlash;
	
	private int nombreAES;
	private int nombreBatterieAES;
	
	private int testVoltBatterieAES;
	private int testAmpereBatterieAES;
	private int testVoltChargeurAES;
	
	/* AES */
	private TypeAES typeAES;
	
	private int xBatterieAES;
	private int yBatterieAES;
	private int hBatteriesAES;
	
	private TypeBatterieAES typeBatterieAES;
	
	/* Batterie */
	
	private int xbatterie;
	private int ybatterie;
	private int hbatterie;
	
	private TypeBatterie typeBatterie;
	
	public Alarme(){}
	public void addInterventions (Intervention intervention) {
		this.getInterventions().add(intervention);
	}
	
	public int getNombreDetecteurOptique() {
		return nombreDetecteurOptique;
	}

	public void setNombreDetecteurOptique(int nombreDetecteurOptique) {
		this.nombreDetecteurOptique = nombreDetecteurOptique;
	}

	public String getObservationDetecteurOptique() {
		return observationDetecteurOptique;
	}

	public void setObservationDetecteurOptique(String observationDetecteurOptique) {
		this.observationDetecteurOptique = observationDetecteurOptique;
	}

	public int getNombreDetecteurIonique() {
		return nombreDetecteurIonique;
	}

	public void setNombreDetecteurIonique(int nombreDetecteurIonique) {
		this.nombreDetecteurIonique = nombreDetecteurIonique;
	}

	public String getObservationDetecteurIonique() {
		return observationDetecteurIonique;
	}

	public void setObservationDetecteurIonique(String observationDetecteurIonique) {
		this.observationDetecteurIonique = observationDetecteurIonique;
	}

	public int getNombreDetecteurThermique() {
		return nombreDetecteurThermique;
	}

	public void setNombreDetecteurThermique(int nombreDetecteurThermique) {
		this.nombreDetecteurThermique = nombreDetecteurThermique;
	}

	public String getObservationDetecteurThermique() {
		return observationDetecteurThermique;
	}

	public void setObservationDetecteurThermique(String observationDetecteurThermique) {
		this.observationDetecteurThermique = observationDetecteurThermique;
	}

	public int getNombreDetecteurThermovelocimetrique() {
		return nombreDetecteurThermovelocimetrique;
	}

	public void setNombreDetecteurThermovelocimetrique(int nombreDetecteurThermovelocimetrique) {
		this.nombreDetecteurThermovelocimetrique = nombreDetecteurThermovelocimetrique;
	}

	public String getObservationDetecteurThermovelocimetrique() {
		return observationDetecteurThermovelocimetrique;
	}

	public void setObservationDetecteurThermovelocimetrique(String observationDetecteurThermovelocimetrique) {
		this.observationDetecteurThermovelocimetrique = observationDetecteurThermovelocimetrique;
	}

	public int getNombreDetecteurFlammes() {
		return nombreDetecteurFlammes;
	}

	public void setNombreDetecteurFlammes(int nombreDetecteurFlammes) {
		this.nombreDetecteurFlammes = nombreDetecteurFlammes;
	}

	public String getObservationDetecteurFlammes() {
		return observationDetecteurFlammes;
	}

	public void setObservationDetecteurFlammes(String observationDetecteurFlammes) {
		this.observationDetecteurFlammes = observationDetecteurFlammes;
	}

	public int getNombreDetecteurAspiration() {
		return nombreDetecteurAspiration;
	}

	public void setNombreDetecteurAspiration(int nombreDetecteurAspiration) {
		this.nombreDetecteurAspiration = nombreDetecteurAspiration;
	}

	public String getObservationDetecteurAspiration() {
		return observationDetecteurAspiration;
	}

	public void setObservationDetecteurAspiration(String observationDetecteurAspiration) {
		this.observationDetecteurAspiration = observationDetecteurAspiration;
	}

	public int getNombreAutreReport() {
		return nombreAutreReport;
	}

	public void setNombreAutreReport(int nombreAutreReport) {
		this.nombreAutreReport = nombreAutreReport;
	}

	public String getObservationAutreReport() {
		return observationAutreReport;
	}

	public void setObservationAutreReport(String observationAutreReport) {
		this.observationAutreReport = observationAutreReport;
	}

	public int getNombreDeclencheurManuel() {
		return nombreDeclencheurManuel;
	}

	public void setNombreDeclencheurManuel(int nombreDeclencheurManuel) {
		this.nombreDeclencheurManuel = nombreDeclencheurManuel;
	}

	public String getObservationDeclencheurManuel() {
		return observationDeclencheurManuel;
	}

	public void setObservationDeclencheurManuel(String observationDeclencheurManuel) {
		this.observationDeclencheurManuel = observationDeclencheurManuel;
	}

	public int getNombreDiffusionSonore() {
		return nombreDiffusionSonore;
	}

	public void setNombreDiffusionSonore(int nombreDiffusionSonore) {
		this.nombreDiffusionSonore = nombreDiffusionSonore;
	}

	public String getObservationDiffusionSonore() {
		return observationDiffusionSonore;
	}

	public void setObservationDiffusionSonore(String observationDiffusionSonore) {
		this.observationDiffusionSonore = observationDiffusionSonore;
	}

	public int getNombreDiffusionSonoreFlash() {
		return nombreDiffusionSonoreFlash;
	}

	public void setNombreDiffusionSonoreFlash(int nombreDiffusionSonoreFlash) {
		this.nombreDiffusionSonoreFlash = nombreDiffusionSonoreFlash;
	}

	public String getObservationDiffusionSonoreFlash() {
		return observationDiffusionSonoreFlash;
	}

	public void setObservationDiffusionSonoreFlash(String observationDiffusionSonoreFlash) {
		this.observationDiffusionSonoreFlash = observationDiffusionSonoreFlash;
	}

	public int getNombreAES() {
		return nombreAES;
	}

	public void setNombreAES(int nombreAES) {
		this.nombreAES = nombreAES;
	}
	
	@ManyToOne
	public TypeAES getTypeAES() {
		return typeAES;
	}

	public void setTypeAES(TypeAES typeAES) {
		this.typeAES = typeAES;
	}

	public int getNombreBatterieAES() {
		return nombreBatterieAES;
	}

	public void setNombreBatterieAES(int nombreBatterieAES) {
		this.nombreBatterieAES = nombreBatterieAES;
	}

	public int getxBatterieAES() {
		return xBatterieAES;
	}

	public void setxBatterieAES(int xBatterieAES) {
		this.xBatterieAES = xBatterieAES;
	}

	public int getyBatterieAES() {
		return yBatterieAES;
	}

	public void setyBatterieAES(int yBatterieAES) {
		this.yBatterieAES = yBatterieAES;
	}

	public int gethBatteriesAES() {
		return hBatteriesAES;
	}

	public void sethBatteriesAES(int hBatteriesAES) {
		this.hBatteriesAES = hBatteriesAES;
	}
	@ManyToOne
	public TypeBatterieAES getTypeBatterieAES() {
		return typeBatterieAES;
	}

	public void setTypeBatterieAES(TypeBatterieAES typeBatterieAES) {
		this.typeBatterieAES = typeBatterieAES;
	}

	public int getTestVoltBatterieAES() {
		return testVoltBatterieAES;
	}

	public void setTestVoltBatterieAES(int testVoltBatterieAES) {
		this.testVoltBatterieAES = testVoltBatterieAES;
	}

	public int getTestAmpereBatterieAES() {
		return testAmpereBatterieAES;
	}

	public void setTestAmpereBatterieAES(int testAmpereBatterieAES) {
		this.testAmpereBatterieAES = testAmpereBatterieAES;
	}

	public int getTestVoltChargeurAES() {
		return testVoltChargeurAES;
	}

	public void setTestVoltChargeurAES(int testVoltChargeurAES) {
		this.testVoltChargeurAES = testVoltChargeurAES;
	}
	
	
	@ManyToOne
	public TypeAlarme getType() {
		return type;
	}

	public void setType(TypeAlarme type) {
		this.type = type;
	}
	@ManyToOne
	public MarqueAlarme getMarque() {
		return marque;
	}

	public void setMarque(MarqueAlarme marque) {
		this.marque = marque;
	}

	public int getAnnee() {
		return annee;
	}

	public void setAnnee(int annee) {
		this.annee = annee;
	}

	public int getNombre() {
		return nombre;
	}

	public void setNombre(int nombre) {
		this.nombre = nombre;
	}

	public int getNombreBatterie() {
		return nombreBatterie;
	}

	public void setNombreBatterie(int nombreBatterie) {
		this.nombreBatterie = nombreBatterie;
	}

	public int getXbatterie() {
		return xbatterie;
	}

	public void setXbatterie(int xbatterie) {
		this.xbatterie = xbatterie;
	}

	public int getYbatterie() {
		return ybatterie;
	}

	public void setYbatterie(int ybatterie) {
		this.ybatterie = ybatterie;
	}

	public int getHbatterie() {
		return hbatterie;
	}

	public void setHbatterie(int zbatterie) {
		this.hbatterie = zbatterie;
	}
	@ManyToOne
	public TypeBatterie getTypeBatterie() {
		return typeBatterie;
	}

	public void setTypeBatterie(TypeBatterie typeBatterie) {
		this.typeBatterie = typeBatterie;
	}

	public int getTestVoltBatterie() {
		return testVoltBatterie;
	}

	public void setTestVoltBatterie(int testVoltBatterie) {
		this.testVoltBatterie = testVoltBatterie;
	}

	public int getTestAmpereBatterie() {
		return testAmpereBatterie;
	}

	public void setTestAmpereBatterie(int testAmpereBatterie) {
		this.testAmpereBatterie = testAmpereBatterie;
	}

	public int getTestVoltChargeur() {
		return testVoltChargeur;
	}

	public void setTestVoltChargeur(int testVoltChargeur) {
		this.testVoltChargeur = testVoltChargeur;
	}

}
