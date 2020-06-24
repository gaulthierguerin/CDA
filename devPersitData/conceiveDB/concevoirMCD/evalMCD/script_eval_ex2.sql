#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: Client
#------------------------------------------------------------

CREATE TABLE Client(
        N_Client        Int  Auto_increment  NOT NULL ,
        Nom_du_client    Varchar (50) NOT NULL ,
        Prenom_du_client Varchar (50) NOT NULL
	,CONSTRAINT Client_PK PRIMARY KEY (N__Client)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Commande
#------------------------------------------------------------

CREATE TABLE Commande(
        N__de_commande         Int  Auto_increment  NOT NULL ,
        Date_de_commande       Date NOT NULL ,
        Montant_de_la_commande Int NOT NULL ,
        N__Client              Int NOT NULL
	,CONSTRAINT Commande_PK PRIMARY KEY (N__de_commande)

	,CONSTRAINT Commande_Client_FK FOREIGN KEY (N__Client) REFERENCES Client(N__Client)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Article
#------------------------------------------------------------

CREATE TABLE Article(
        N__Article          Int  Auto_increment  NOT NULL ,
        Designation_article Varchar (50) NOT NULL ,
        Prix_unitaire       Decimal NOT NULL
	,CONSTRAINT Article_PK PRIMARY KEY (N__Article)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: SeComposeDe
#------------------------------------------------------------

CREATE TABLE SeComposeDe(
        N_Article     Int NOT NULL ,
        N_de_commande Int NOT NULL ,
        Quantite       Int NOT NULL ,
        Taux_TVA       TinyINT NOT NULL
	,CONSTRAINT SeComposeDe_PK PRIMARY KEY (N__Article,N__de_commande)

	,CONSTRAINT SeComposeDe_Article_FK FOREIGN KEY (N__Article) REFERENCES Article(N__Article)
	,CONSTRAINT SeComposeDe_Commande0_FK FOREIGN KEY (N__de_commande) REFERENCES Commande(N__de_commande)
)ENGINE=InnoDB;

