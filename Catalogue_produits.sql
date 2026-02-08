create database catalogue_produits;
use catalogue_produits;
create table produits(
ID_Produit char(4) primary key,
Nom_Produit varchar(35),
Categorie varchar(25) not null,
Cout int check(cout>=0),
prix int check(prix>=0),
stock int check(stock>=0),
date_Ajout date);
insert into produits
values ('P001','PC Portable PRO','Informatique',6500,7999,10,'2025-12-10'),
('P002','Clé USB 64Go','Accessoires',90,150,50,'2024-03-15'),
('P003','Souris Sans Fil','Accessoires',70,100,30,'2024-04-01'),
('P004','Imprimante Laser','Bureautique',1200,1500,15,'2024-04-10'),
('P005','Disque Dur 1To','Informatique',500,750,20,'2024-04-15'),
('P006','Casque Bluetooth','Audio',300,500,5,'2024-04-20'),
('P007','Écran 24 pouces','Affichage',900,1300,12,'2024-05-01');
select * from produits;
select * from produits
where categorie='Accessoires';
select * from produits
where stock<=10;
select * from produits
where prix>cout*1.3;
select * from produits
where year(date_Ajout)='2024' and month(date_Ajout)='4';
select ID_Produit, prix-cout as Bénéfice_unitaire, (prix-cout)*stock as Bénéfice_potentiel from produits;
select round(avg(prix),2) as prix_moyen, sum(stock) as stock_total, sum((prix-cout)*stock) as Bénéfice_total_potentiel from produits;
select ID_Produit from produits
order by prix desc
limit 3;
select case
when prix>=1500 then 'Haut de gamme'
when prix>=800 and prix<1500 then 'Milieu de gamme'
else 'Entrée de gamme'
end as Etiquette
from produits;
select concat(Nom_Produit,' - seulement ',prix,' DH') as Nom_Commercial from produits;
select * from produits
where instr(Nom_Produit,'sans');
select date_Ajout, datediff(curdate(),date_Ajout) as NB_jours,dayname(date_Ajout) as jour from produits;
select * from produits
where datediff(curdate(),date_Ajout)<30;