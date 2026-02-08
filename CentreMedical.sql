create database CentreMedical;
use CentreMedical;
create table patients(
id_patient int primary key auto_increment,
nom varchar(15),
date_naissance date,
ville varchar(20));
create table rendezVous(
id_rdv int primary key auto_increment,
id_patient int,
constraint FK_FROMpatients
foreign key (id_patient)
references patients(id_patient),
date_rdv date,
statut varchar(15),
motif varchar(20));
insert into patients (nom, date_naissance, ville)
values ('Meryem', '1995-02-15', 'Rabat'),
('Anas', '1989-11-22', 'Casablanca'),
('Anas', '1989-11-22', 'Casablanca'),
('Rachid', '1993-04-07', 'Fès'),
('Malika', '1985-12-30', 'Marrakech');
insert into rendezVous (id_patient, date_rdv, statut, motif)
values (1, '2024-06-01', 'Honoré', 'Consultation'),
(2, '2024-06-02', 'Annulé', 'Fièvre'),
(3, '2026-02-02', 'Non venu', 'Consultation'),
(1, '2026-02-10', 'Annulé', 'Douleur lombaire'),
(4, '2024-06-11', 'Honoré', 'Tension');

-- 3. Afficher les rendez-vous qui ont eu lieu avant la date du jour.
select id_rdv from rendezVous
where current_date()>date_rdv;

-- 4. Afficher les patients dont le prénom contient la lettre a
select distinct nom from patients
where nom like '%a%';

-- 5. Afficher le nombre de rendez-vous annulés pour chaque patient.
select id_patient, count(id_rdv) as nb_rdv from rendezVous
where statut='Annulé'
group by id_patient;

-- 6. Afficher le prénom, la ville et l’âge du patient le plus jeune ayant honoré un rendez-vous.
select p.nom, p.ville, year(current_date())-year(date_naissance) as age, r.statut from patients p
inner join rendezVous r on r.id_patient=p.id_patient
where statut='Honoré'
order by age
limit 1;
-- 7. Afficher la liste des patients n’ayant jamais eu de rendez-vous.
select p.* from patients p
where not exists(select r.id_patient from rendezVous r where r.id_patient=p.id_patient);

-- 8. Afficher le nombre total de rendez-vous honorés, annulés et non venus.
select statut, count(statut) as nb_total from rendezVous
group by statut;

-- 9. Afficher le nom et l’âge du patient le plus jeune ayant eu un rendez-vous en 2024.
select p.nom, year(current_date())-year(date_naissance) as age from patients p
inner join rendezVous r on r.id_patient=p.id_patient
where year(date_rdv)=2024
order by age
limit 1;

-- 10. Afficher les rendez-vous dont le motif est identique à celui le plus fréquent dans la table.
select motif, count(motif) nb_motif from rendezVous
group by motif
order by nb_motif desc
limit 1;