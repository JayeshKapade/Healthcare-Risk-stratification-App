Create Database Healthcare
use Healthcare

Create Table diagnoses
(DiagnosisID Int Primary key,
DiagnosisName Varchar(255));

Create Table outcomes
(OutcomeID Int Primary Key,
OutcomeName Varchar(255));

Create Table patients
(PatientID Int Primary Key,
Name Varchar(255),
Age Int, Gender Varchar(255),
DiagnosisID Int,
AdmissionDate Date,
DischargeDate Date,
OutcomeID Int,
TreatmentCost decimal(10,2),
foreign key (DiagnosisID) references diagnoses(DiagnosisID),
foreign key (OutcomeID) references outcomes(OutcomeID));

Create Table labs
(LabID Int Primary Key,
PatientID Int,
TestName Varchar(255),
Result decimal(10,2),
NormalRange Varchar(255)
foreign key (PatientID) references patients(PatientID));


