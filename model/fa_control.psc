Glycolysis:
	Gluc > Pyr
	0.01

AcCoA_prod:
	Pyr > Acetyl_CoA
	0.01

TCA_flow:
	Acetyl_CoA > TCA
	50**(0.5)
	
FA_flow:
	Acetyl_CoA > FAsyn
	ATP**(0.5)

Mal_flow:
	FAsyn > Inp_1
	0.613

Acyl_flow:
	FAsyn > Acyl_CoA
	0.1

TCA_out:
	TCA > {30}ATP
	TCA
	
R1:
	Inp_1 + Acyl_CoA > Acyl_CoA_6
	0.00001

R2:
	Inp_1 + Acyl_CoA_6 > Acyl_CoA_8
	1.0

R3:
	Inp_1 + Acyl_CoA_8 > Acyl_CoA_10
	1.0

R4:
	Inp_1 + Acyl_CoA_10 > Acyl_CoA_12
	1.0

storage_C12:
	Acyl_CoA_12 > C12
	0.0000008

R5:
	Inp_1 + Acyl_CoA_12 > Acyl_CoA_14
	3.0

storage_C14:
	Acyl_CoA_14 > C14
	0.04

R6:
	Inp_1 + Acyl_CoA_14 > Acyl_CoA_16
	1.0

storage_C16:
	Acyl_CoA_16 > C16
	5.1
R7:
	Inp_1 + Acyl_CoA_16 > Acyl_CoA_18
	1.0

storage_C18:
	Acyl_CoA_18 > C18
	7.5
R8:
	Inp_1 + Acyl_CoA_18 > Acyl_CoA_20
	1.0

storage_C20:
	Acyl_CoA_20 > C20
	1.5

R9:
	Inp_1 + Acyl_CoA_20 > Acyl_CoA_22
	1.0

storage_C22:
	Acyl_CoA_20 > C22
	1.0



Gluc = 100
Pyr = 0
Acetyl_CoA = 0
TCA = 0
ATP = 50
FAsyn = 0
Inp_1 = 0
Acyl_CoA = 0
Acyl_CoA_6 = 0
Acyl_CoA_8 = 0
Acyl_CoA_10 = 0
Acyl_CoA_12 = 0
Acyl_CoA_14 = 0
Acyl_CoA_16 = 0
Acyl_CoA_18 = 0
Acyl_CoA_20 = 0
Acyl_CoA_22 = 0
C12 = 0
C14 = 0
C16 = 0
C18 = 0
C20 = 0
C22 = 0
