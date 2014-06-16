R1:
	Inp_1 + Inp_2 > Acyl_CoA_6
	2.1

R2:
	Inp_1 + Acyl_CoA_6 > Acyl_CoA_8
	2.0

R3:
	Inp_1 + Acyl_CoA_8 > Acyl_CoA_10
	2.0

R4:
	Inp_1 + Acyl_CoA_10 > Acyl_CoA_12
	4.0

storage_C12:
	Acyl_CoA_12 > C12
	0.005

R5:
	Inp_1 + Acyl_CoA_12 > Acyl_CoA_14
	3.0

storage_C14:
	Acyl_CoA_14 > C14
	0.05

R6:
	Inp_1 + Acyl_CoA_14 > Acyl_CoA_16
	3.0

storage_C16:
	Acyl_CoA_16 > C16
	1.0
R7:
	Inp_1 + Acyl_CoA_16 > Acyl_CoA_18
	3.0

storage_C18:
	Acyl_CoA_18 > C18
	1.0
R8:
	Inp_1 + Acyl_CoA_18 > Acyl_CoA_20
	3.0

storage_C20:
	Acyl_CoA_20 > C20
	1.0

R9:
	Inp_1 + Acyl_CoA_20 > Acyl_CoA_22
	3.0

storage_C22:
	Acyl_CoA_20 > C22
	1.0

Inp_1 = 300
Inp_2 = 100
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
