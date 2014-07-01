R1:
	Pyr > Acetyl_CoA
	0.0001

R2:
	Acetyl_CoA > Acyl_CoA
	1.0

R3:
	Acetyl_CoA > Malonyl_CoA
	1.0

R4:
	Acetyl_CoA + OAAmit > ICITmit
	1.0

R5:
	ICITmit > SUCCmit
	1.0

R6:
	ICITmit > NADPHmit
	1.0

R7:
	Acyl_CoA + Malonyl_CoA + NADPHmit > Acyl_CoA_6
	0.00001

R8:
	Acyl_CoA_6 + Malonyl_CoA + NADPHmit > Acyl_CoA_8
	0.1

R9:
	Acyl_CoA_8 + Malonyl_CoA + NADPHmit > Acyl_CoA_10
	0.1

R10:
	Acyl_CoA_10 + Malonyl_CoA + NADPHmit > Acyl_CoA_12
	1.0

storage_C12:
	Acyl_CoA_12 > C12
	0.0003000656

R11:
	Acyl_CoA_12 + Malonyl_CoA + NADPHmit > Acyl_CoA_14
	0.99969993

storage_C14:
	Acyl_CoA_14 > C14
	0.0400323889

R12:
	Acyl_CoA_14 + Malonyl_CoA + NADPHmit > Acyl_CoA_16
	0.95996761

storage_C16:
	Acyl_CoA_16 > C16
	0.8235217126

R13:
	Acyl_CoA_16 + Malonyl_CoA + NADPHmit > Acyl_CoA_18
	0.17647829

storage_C18:
	Acyl_CoA_18 > C18
	0.9888339514

R14:
	Acyl_CoA_18 + Malonyl_CoA + NADPHmit > Acyl_CoA_20
	0.01116605

storage_C20:
	Acyl_CoA_20 > C20
	0.7785977860

R15:
	Acyl_CoA_20 + Malonyl_CoA + NADPHmit > Acyl_CoA_22
	0.22140221

storage_C22:
	Acyl_CoA_20 > C22
	1.0

Pyr = 100
Acyl_CoA = 0
Acetyl_CoA = 0
Malonyl_CoA = 0
NADPHmit = 0
OAAmit = 100
ICITmit = 0
SUCCmit = 0
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
