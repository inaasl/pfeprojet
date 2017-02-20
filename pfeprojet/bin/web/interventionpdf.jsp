<html>

<head>
<title>Fiche d'installation</title>
<meta charset="UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="container">

		<%@ page import="java.io.FileOutputStream"%>
		
		<%@ page import="com.itextpdf.text.Anchor"%>
		<%@ page import="com.itextpdf.text.BadElementException"%>
		<%@ page import="com.itextpdf.text.BaseColor"%>
		<%@ page import="com.itextpdf.text.Chapter"%>
		<%@ page import="com.itextpdf.text.Document"%>
		<%@ page import="com.itextpdf.text.DocumentException"%>
		<%@ page import="com.itextpdf.text.Element"%>
		<%@ page import="com.itextpdf.text.Font"%>
		<%@ page import="com.itextpdf.text.ListItem"%>
		<%@ page import="com.itextpdf.text.Paragraph"%>
		<%@ page import="com.itextpdf.text.Phrase"%>
		<%@ page import="com.itextpdf.text.Section"%>
		<%@ page import="com.itextpdf.text.pdf.PdfPCell"%>
		<%@ page import="com.itextpdf.text.pdf.PdfWriter"%>
		<%@ page import="com.itextpdf.text.pdf.PdfPTable"%>
		<%@ page import="com.itextpdf.text.Image" %>
		<%@ page import="com.itextpdf.text.pdf.PdfContentByte" %>
		<%@ page import="com.itextpdf.text.pdf.ColumnText" %>
		
		<%@ page import="java.net.URL"%>
		<%@ page import="java.net.URLConnection"%>
		<%@ page import="java.io.* "%>
		<%@ page import="ejb.sessions.*"%>
		<%@ page import="ejb.entites.* "%>
		<%@ page import="java.util.List"%>
		<%@ page import="javax.naming.InitialContext"%>
		<%@ page import="javax.naming.NamingException"%>

		<%@ page import="java.util.Date"%>
		<%@ page import="java.text.SimpleDateFormat"%>
		<%@ page import="java.text.DateFormat"%>

	<%!
	String FILE = "/home/inas/Documents/pfe/pfeprojet/src/tmp/installationextincteur.pdf";
	Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 18, Font.BOLD);
	Font redFont = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL, BaseColor.RED);
	Font subFont = new Font(Font.FontFamily.TIMES_ROMAN, 16, Font.BOLD);
	Font smallBold = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD);

	String numBatiment, numeroB, chaine;
	Batiment B;
	Pdfgenere pdf;
	int num;
	List<Organe> organes;
	String ajout;
	%>
	<%
     	session = request.getSession();
		numeroB = (String)session.getAttribute("numBatiment");
		num=Integer.parseInt(numeroB);
		session.setAttribute("numBatiment",String.valueOf(num));

		List<Organe> organes=(List<Organe>)session.getAttribute("organes");
		if(organes!=null) organes.clear();
		session.setAttribute("organes",organes);
	
		String ajout=String.valueOf(session.getAttribute("ajout"));
		if(ajout!=null) ajout="0";
		session.setAttribute("ajout",ajout);
		
		List<Intervention> interv=(List<Intervention>)session.getAttribute("interv");
		if(interv!=null) interv.clear();
		session.setAttribute("Interv",interv);
		
	    pdf=(Pdfgenere)session.getAttribute("pdf");

		
     	try {
        	InitialContext ctx = new InitialContext();
     		Object obj = ctx.lookup("ejb:pfeprojet/pfeprojetSessions/"+ "ServicepfeprojetBean!ejb.sessions.ServicepfeprojetRemote");
     		ServicepfeprojetRemote service = (ServicepfeprojetRemote) obj;
     		

     		Document document = new Document();
        	PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(FILE));
        	document.open();
            PdfContentByte cb = writer.getDirectContent();
        	
        	Paragraph ndoc = new Paragraph("Id document : "+pdf.getNumero());
        	ndoc.setAlignment(Element.ALIGN_CENTER);
        	document.add(ndoc);

        	Image img = Image.getInstance("/home/inas/Documents/pfe/pfeprojet/src/img/logo-site.png");
        	document.add(img);
        	
        	Paragraph preface = new Paragraph();
        	preface.add(new Paragraph(" "));
        	String client = new String("Client :");
        	String lieuIntervention = new String("Lieu D'intervention :");
        	String nomdurespondable = new String("Nom du responsable du site :");
        	String tel = new String("Tel :");
        	Batiment bat = service.rechercheBatimentnum(num);
        	client= client +" "+bat.getEntreprise().getNom();
        	preface.add(new Paragraph(client));
        	lieuIntervention = lieuIntervention +" "+ bat.getNom()+" - "+bat.getAdresse();
        	preface.add(new Paragraph(lieuIntervention));
        	nomdurespondable=nomdurespondable+" "+bat.getNomresp()+" "+bat.getPrenomresp();
        	preface.add(new Paragraph(nomdurespondable));
        	tel=tel+" "+bat.getEntreprise().getTel();
        	preface.add(new Paragraph(tel));
        	preface.add(new Paragraph(" "));
			Date date = pdf.getInterventions().get(0).getDate();
			DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
			String text = df.format(date);
        	preface.add(new Paragraph("Date de l'intervention : "+text));
        	document.add(preface);
        	// type de l'organe de sécurité
        	Paragraph typeorgane = new Paragraph();
        	if(pdf.getInterventions().get(0).getOrgane() instanceof Extincteur) {
        	typeorgane = new Paragraph("Extincteurs",catFont);
        	}
        	else {
            	if(pdf.getInterventions().get(0).getOrgane() instanceof Pharmacie) {
                	typeorgane = new Paragraph("Pharmacie",catFont);
                }
            	else {
                	if(pdf.getInterventions().get(0).getOrgane() instanceof Eclairage) {
                    	typeorgane = new Paragraph("Eclairage",catFont);
                    }
                	else {
                    	if(pdf.getInterventions().get(0).getOrgane() instanceof Signaletique) {
                        	typeorgane = new Paragraph("Signalétique",catFont);
                        }
                    	else {
                        	if(pdf.getInterventions().get(0).getOrgane() instanceof RIA) {
                            	typeorgane = new Paragraph("RIA",catFont);
                            }
                        	else {
                            	if(pdf.getInterventions().get(0).getOrgane() instanceof Coupefeu) {
                                	typeorgane = new Paragraph("Porte Coupe-feu",catFont);
                                }
                            	else {
                                	if(pdf.getInterventions().get(0).getOrgane() instanceof Poteaux) {
                                    	typeorgane = new Paragraph("Poteaux Incendie",catFont);
                                    }
                            	}
                        	}
                    	}
                	}
            	}
        	}
        	typeorgane.setAlignment(Element.ALIGN_CENTER);
        	document.add(typeorgane); 
        	// type de l'intervention
        	Paragraph typeintervention = new Paragraph();
        	if(pdf.getInterventions().get(0) instanceof Installation){
            	typeintervention.add(new Paragraph("Type de l'intervention : Installation",catFont));
        	}
        	else {
        		if(pdf.getInterventions().get(0) instanceof Verification) {
                typeintervention.add(new Paragraph("Type de l'intervention : Vérification",catFont));
        		}
        		else {
        			if(pdf.getInterventions().get(0) instanceof Preventive) {
                    	typeintervention.add(new Paragraph("Type de l'intervention : Maintenance Préventive",catFont));
        			}
        			else {
                    	typeintervention.add(new Paragraph("Type de l'intervention : Maintenance Corrective",catFont));
        			}
        		}
        	}
        	typeintervention.setAlignment(Element.ALIGN_CENTER);
           	document.add(new Paragraph(" "));
        	document.add(typeintervention); 
           	
       		document.add(new Paragraph(" "));
    		// conclusion
	    	Paragraph conclusion = new Paragraph();
	    	chaine = "conclusion ";
	    	conclusion.add(new Paragraph(chaine,smallBold));
	    	conclusion.add(new Paragraph(pdf.getInterventions().get(0).getConclusion()));
	    	document.add(conclusion);
	        for(int i=0;i<5;i++){
	        	document.add(new Paragraph(" "));
	        }
	        
	        PdfPTable signatureclient = new PdfPTable(2);
	        signatureclient.setWidthPercentage(100);
	   		chaine = "CLIENT Nom, Prénom, Cachet\n"+"Observations";
	        PdfPCell c2 = new PdfPCell(new Phrase(chaine));
	        c2.setFixedHeight(72f);
	        signatureclient.addCell(c2);
	        c2 = new PdfPCell(new Phrase("  "));
	        signatureclient.addCell(c2);
	        
	        document.add(signatureclient);
	    	
	        PdfPTable signaturedesentec = new PdfPTable(2);
	        signaturedesentec.setWidthPercentage(100);
	   		chaine = "DESENTEC Nom, Prénom intervenant\n"+"Signature";
	        PdfPCell c3 = new PdfPCell(new Phrase(chaine));
	        c3.setFixedHeight(72f);
	        signaturedesentec.addCell(c3);
	        Paragraph nomprentechnicien = new Paragraph(pdf.getInterventions().get(0).getTechnicien().getNom()+" "+pdf.getInterventions().get(0).getTechnicien().getPrenom(),smallBold);
	        nomprentechnicien.setAlignment(Element.ALIGN_CENTER);
	        c3 = new PdfPCell(nomprentechnicien);
	        signaturedesentec.addCell(c3);
	        
	        document.add(signaturedesentec);
	        
	
	        Phrase footer = new Phrase("Renseignements administratifs "+"Nombre d'exemplaires : 2                    page 1 sur 1");
	        ColumnText.showTextAligned(cb, Element.ALIGN_CENTER,
	                footer,
	                (document.right() - document.left()) / 2 + document.leftMargin(),
	                document.bottom() - 5, 0);
	        
		  	document.close();
		  	
		  	pdf=null;
			session.setAttribute("pdf",pdf);
	     	}catch(NamingException e){
	         	  
	        } 
	        catch (Exception e) {
	                e.printStackTrace();
	        }
		  %>
	  </div>
</body>
</html>