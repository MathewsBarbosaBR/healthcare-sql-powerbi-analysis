-- Projeto em SQL com foco na analise de:

-- Padrões hospitalares
-- Perfil dos pacientes
-- Custos médicos
-- Seguradoras e faturamento hospitalar

use healthcare;
select *
from healthcare;

-- Padrões hospitalares

-- Quais hospitais tem mais pacientes
select Hospital, count(Name) as Patients
from healthcare
group by Hospital
having Patients >= 10
order by Patients desc;

-- Quais hospitais tem mais receita
select distinct Hospital, sum(cast(replace(`Billing Amount`, '$', '') as decimal(20, 2))) as Total
from healthcare
group by Hospital
order by Total desc;

-- Qual tipo de admissão gera mais faturamento
 select count(Name) as Qtt_Pacients, `Admission Type` as Admission_Type, sum(cast(replace(`Billing Amount`, '$', '') as decimal(20, 2))) as Total
 from healthcare
 group by Admission_Type
 order by Total desc;
 
  -- Pacientes Admitidos por ano
 select year(str_to_date(`Date of Admission`, '%d/%m/%Y')) as Year_, count(*) as Patients
 from healthcare
 group by Year_
 Order By Year_ desc;
 
  -- Pacientes que receberam alta por ano
 select year(str_to_date(`Discharge Date`, '%d/%m/%Y')) as Year_, count(*) as Patients
 from healthcare
 group by Year_
 order by Year_ desc;
 
 -- Qual tipo de admissão teve mais pacientes
 select distinct `Admission Type`, count(*) as Patients
 from healthcare
 group by `Admission Type`
 order by Patients desc;
 
 -- Perfil dos pacientes

-- Quantos pacientes tem por gênero
select Gender, count(Name) as Patients
from healthcare
group by Gender;

-- Quantidade de pacientes por tipo sanguíneo
select `Blood Type`, count(Name) as Patients
from healthcare
group by `Blood Type`
order by Patients desc;

-- Quantidade de pacientes por condição médica
select distinct `Medical Condition` as Medical_Condition, count(Name) as Patients
from healthcare
group by Medical_Condition
order by Patients desc;

-- Quantidade de pacientes e faturamento por idade
-- Incluindo classificação pot faixa etária
select distinct Age, count(Age) as Total_Patients, 

sum(cast(replace(`Billing Amount`, '$', '') as decimal(20, 2))) as Total_Billing,

case
 when  Age >= 60 then "Senior"
 when   Age >= 20 then "Adult"
 else "Teenager"
 end as Age_Range
from healthcare
group by Age
order by Total_Patients desc;

-- Qual faixa etária apresenta maior faturamento e quantidade de pacientes

select
case
 when  Age >= 60 then "Senior"
 when   Age >= 20 then "Adult"
 else "Teenager"
 end as Age_Range,
 
 count(Age) as Total_Patients, 

sum(cast(replace(`Billing Amount`, '$', '') as decimal(20, 2))) as Total_Billing
 
from healthcare
group by Age_Range
order by Total_Patients desc;

-- Condição Médica que mais aparece por faixa etária
select
case 
 when Age >= 60 then 'Senior'
 when Age >= 20 then 'Adult'
 else 'Teenager'
 end as Patients_Age, `Medical Condition` as Medical_Condition, count(*) as Total_Cases
 from healthcare
 group by Patients_Age, `Medical_Condition`
 order by Patients_Age, Total_Cases desc;
 
 -- Custos médicos
 
 -- Faturamento total por condição médica
 select `Medical Condition` as Medical_Condition, sum(cast(replace(`Billing Amount`, '$', '') as decimal(20, 2))) as Total
 from healthcare
 group by Medical_Condition
 order by Total desc;
 
 -- Média geral do faturamento hospitalar
 select avg(cast(replace(`Billing Amount`, '$', '') as decimal(20, 2))) as Average_Billing
 from healthcare;
 
 -- Médicamentos com maior faturamento e quantidade de pacientes
 select distinct Medication, sum(cast(replace(`Billing Amount`, '$', '') as decimal(20, 2))) as Total, count(*) as Patients
 from healthcare
 group by Medication
 order by Total desc;
 
 -- Seguradoras e faturamneto hospitalar
 
-- Total por Seguro
select distinct `Insurance Provider` as Insurance_Provider, sum(cast(replace(`Billing Amount`, '$', '') as decimal(20, 2))) as Total
from healthcare
group by Insurance_Provider
order by Total desc;
  
-- Média de faturamento por seguradora e condição médica
-- incluindo quantidade de pacientes atendidos
 select distinct `Insurance Provider`as Insurance_Provider, avg(cast(replace(`Billing Amount`, '$', '') as decimal(20, 2))) as Average_Billing, count(Name) as Total_Patients, `Medical Condition` as Medical_Condition
 from healthcare
 group by Insurance_Provider, Medical_Condition
 order by Average_Billing desc;
 
 -- Insights
 
 -- Determinados hospitais concentram maior volume de pacientes e faturamento;
 -- certas condições médicas apresentam custos significamente maiores;
 -- Adultos representam maior volume financeiro hospitalar;
 -- Algumas seguradoras possuem maior faturamento médio superior em condições específicas;
 -- tipos de admissão específicos concentram maior geração de receita hospitalar;
 -- determinados medicamentos estão associados aos maiores custos hospitalares;