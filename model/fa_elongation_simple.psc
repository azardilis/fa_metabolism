
R1:
	Acetyl_CoA + Butanoyl_CoA > Hexanoyl_CoA
	2.1

storage_Hexanoyl:
	Hexanoyl_CoA > Hexanoyl_CoA_sink
	0.001

R2:
	Acetyl_CoA + Hexanoyl_CoA > Octanoyl_CoA
	2.0

storage_Octanoyl:
	Octanoyl_CoA > Octanoyl_CoA_sink
	0.001

R3:
	Acetyl_CoA + Octanoyl_CoA > Decanoyl_CoA
	2.0

storage_Decanoyl:
	Decanoyl_CoA > Decanoyl_CoA_sink
	0.001

R4:
	Acetyl_CoA + Decanoyl_CoA > Dodecanoyl_CoA
	4.0

storage_Dodecanoyl:
	Dodecanoyl_CoA > Dodecanoyl_CoA_sink
	0.005

R5:
	Acetyl_CoA + Dodecanoyl_CoA > Tetradecanoyl_CoA
	3.0

storage_Tetradecanoyl:
	Tetradecanoyl_CoA > Tetradecanoyl_CoA_sink
	0.05

R6:
	Acetyl_CoA + Tetradecanoyl_CoA > Hexadecanoyl_CoA
	3.0

storage_Hexadecanoyl:
	Hexadecanoyl_CoA > Hexadecanoyl_CoA_sink
	1.0


Acetyl_CoA = 300
Butanoyl_CoA = 100
Hexanoyl_CoA = 0
Octanoyl_CoA = 0
Decanoyl_CoA = 0
Dodecanoyl_CoA = 0
Hexadecanoyl_CoA = 0
Tetradecanoyl_CoA = 0
Hexanoyl_CoA_sink = 0
Octanoyl_CoA_sink = 0
Decanoyl_CoA_sink = 0
Dodecanoyl_CoA_sink = 0
Tetradecanoyl_CoA_sink = 0
Hexadecanoyl_CoA_sink = 0
