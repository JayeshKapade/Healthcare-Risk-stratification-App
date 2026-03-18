ALTER TABLE patients
ADD CONSTRAINT FK_patients_diagnoses
FOREIGN KEY (DiagnosisID)
REFERENCES diagnoses(DiagnosisID);

ALTER TABLE patients
ADD CONSTRAINT FK_patients_outcomes
FOREIGN KEY (OutcomeID)
REFERENCES outcomes(OutcomeID);

ALTER TABLE labs
ADD CONSTRAINT FK_labs_patients
FOREIGN KEY (PatientID)
REFERENCES patients(PatientID);

select * from patients
select * from labs
select * from diagnoses
-- Retrieve Detailed Patient Lab History
SELECT p.PatientID, p.Name, d.diagnosisname, o.OutcomeName, l.testname, l.result, l.NormalRange
from dbo.patients p
join diagnoses d on p.DiagnosisID = d.DiagnosisID
join outcomes o on p.outcomeid = o.outcomeid
join labs l on p.patientid = l.PatientID
order by PatientID,TestName;

-- Avg Lab results by PER diagnosis
select d.DiagnosisName,l.testname, avg(l.result)as avg_result 
from patients p 
join diagnoses d on p.DiagnosisID = d.DiagnosisID
join labs l on p.PatientID = l.PatientID
Group by d.DiagnosisName, l.TestName;

-- Count Abnormal lab results
select p.patientid, p.name, count(*) as abnormal_count
from patients p
join labs l on p.patientid = l.PatientID
where (l.Testname = 'Blood Sugar' and l.result > 120) or
(l.Testname = 'Cholestrol' and l.result > 200) or
(l.Testname = 'Hemoglobin' and l.result < 13)
Group by p.PatientID, p.name
order by abnormal_count desc;

-- diagnosis with highercost
select d.diagnosisname, sum(p.TreatmentCost) TOTALCost from
patients p join diagnoses d on p.DiagnosisID = d.DiagnosisID
group by d.DiagnosisName
order by TOTALCost desc;

-- Patients at Risk by Age and Gender
select p.patientid, p.name, p.age, d.diagnosisname, o.outcomename,p.Gender
from patients p join diagnoses d on p.DiagnosisID = d.DiagnosisID
join outcomes o on p.OutcomeID = o.OutcomeID
where (age>50 and gender = 'M' and OutcomeName! = 'Recovered')
order by age asc;

-- Lab Trends over time for specific person
select p.patientid, p.admissiondate, l.result, l.testname
from labs l join patients p on l.PatientID = p.PatientID
where p.PatientID In (2,8,19,27,13,29)
order by PatientID;

-- Distribution of Outcomes by Diagnosis
select d.diagnosisname, o.outcomename, count(*) as OutcomeCount 
from patients p join diagnoses d on p.DiagnosisID = d.DiagnosisID
join outcomes o on p.OutcomeID = o.OutcomeID
Group by d.DiagnosisName, o.OutcomeName
Order By d.DiagnosisName, o.OutcomeName desc;
