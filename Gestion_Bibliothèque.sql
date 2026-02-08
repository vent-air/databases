create database Gestion_Bibliothèque;
use Gestion_Bibliothèque;
create table Livres(
id_livre int primary key auto_increment,
titre varchar(25) not null,
auteur varchar(25) not null,
categorie varchar(20),
stock int);
create table Adherents(
id_adherent int primary key auto_increment,
nom varchar(15),
ville varchar(20));
create table Emprunts(
id_emprunt int primary key auto_increment,
id_adherent int,
constraint FK_fromAdherents
foreign key (id_adherent)
references Adherents(id_adherent),
id_livre int,
constraint FK_fromLivres
foreign key (id_livre)
references Livres(id_livre),
date_emprunt date,
date_retour date);
insert into Livres(titre, auteur, categorie, stock)
values (1984, 'George Orwell', 'Fiction', 5),
('Le Petit Prince', 'Antoine de Saint-Exupéry', 'Jeunesse', 3),
('Python pour les Nuls', 'John Paul Mueller' ,'Informatique', 4),
("L'Étranger", 'Albert Camus', 'Classique', 2),
('Clean Code', 'Robert C. Martin', 'Informatique', 6),
('Le Comte de Monte-Cristo', 'Alexandre Dumas', 'Classique', 1);
insert into Adherents(nom, ville)
values ('Yasmine', 'Rabat'),
('Mohamed', 'Casablanca'),
('Fatima', 'Fès'),
('Ali', 'Agadir'),
('Salma', 'Meknès');
insert into Emprunts(id_adherent, id_livre, date_emprunt, date_retour)
values (5, 4, '2024-05-04', null),
(4, 5, '2024-02-24', '2024-04-17'),
(5, 2, '2024-04-11', null),
(2, 4, '2024-03-29', null),
(1, 4, '2024-05-05', '2024-04-17');

-- 1. Afficher les noms des adhérents ayant emprunté au moins un livre.
select id_adherent, nom from Adherents
where id_adherent in (select id_adherent from Emprunts);

-- 2. Afficher les titres des livres empruntés par Salma.
select  A.nom, L.id_livre, L.titre from Emprunts E
join livres L ON L.id_livre=E.id_livre 
join Adherents A ON E.id_adherent=A.id_adherent
where A.nom='Salma';

-- 3. Afficher les adhérents n’ayant jamais emprunté de livres.
select A.id_adherent, A.nom, not exists(select E.id_adherent from Emprunts E where E.id_adherent=A.id_adherent) as existance from Adherents A;

-- 4. Afficher les titres de livres jamais empruntés.
select L.id_livre, L.titre from livres L
where not exists(select E.id_livre from Emprunts E where E.id_livre=L.id_livre);

-- 5. Afficher pour chaque livre le nombre total d’exemplaires empruntés.
select L.id_livre, count(E.id_livre) as nb_exemplaires from Emprunts E
inner join livres L ON L.id_livre=E.id_livre
group by L.id_livre;

-- 6. Afficher la liste des livres non encore rendus.
select id_emprunt, id_livre from Emprunts
where date_retour is null;

-- 7. Afficher le nombre total d’emprunts par ville.
select A.ville, count(E.id_emprunt) as nb_total from Adherents A
left join Emprunts E ON E.id_adherent=A.id_adherent
group by A.ville;

-- 8. Afficher les livres empruntés en avril 2024.
select id_emprunt, id_livre from Emprunts
where month(date_emprunt)=04 and year(date_emprunt)=2024;

-- 9. Afficher la durée moyenne d’un emprunt pour les livres qui ont été rendus.
select avg(datediff(date_retour,date_emprunt)) as moyen from Emprunts
where date_retour is not null;

-- 10. Afficher les catégories de livres les plus empruntées.
select L.categorie, count(E.id_livre) as nb_cat from Emprunts E
join livres L ON L.id_livre=E.id_livre
group by L.categorie
order by nb_cat desc
limit 1;

-- 11. Afficher les emprunts classés par ordre chronologique.
select id_emprunt, date_emprunt from Emprunts
order by date_emprunt;

-- 12. Pour chaque adhérent, afficher le nombre de livres empruntés.
select A.id_adherent, count(L.id_livre) as count from Emprunts E
join Adherents A ON E.id_adherent=A.id_adherent
join livres L ON L.id_livre=E.id_livre
group by A.id_adherent
order by A.id_adherent;

-- 13. Afficher les adhérents ayant emprunté plus de 2 livres différents.
select A.id_adherent, count(E.id_livre) as count from Emprunts E
join Adherents A ON E.id_adherent=A.id_adherent
group by A.id_adherent
having count(E.id_livre)>2;

select A.id_adherent  from adherents a
inner join Emprunts E on A.id_adherent=E.id_adherent
group by A.id_adherent 
having count(distinct E.id_livre)>2;

-- 14. Afficher le livre le plus emprunté en nombre total d’exemplaires.
select L.id_livre, count(E.id_livre) as nb_exemplaires from Emprunts E
inner join livres L ON L.id_livre=E.id_livre
group by L.id_livre
order by nb_exemplaires desc
limit 1;