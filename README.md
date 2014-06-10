fa_metabolism
=============

The idea is to model the Fatty Acid elongation pathway(from KEGG: [hsa00062](http://www.genome.jp/kegg-bin/show_pathway?hsa00062)) using Stochastic Petri Nets(described formally for example [here](http://link.springer.com/chapter/10.1007/978-3-540-75140-3_14) and [here](http://www.fd.cvut.cz/department/k611/pedagog/THO_A/A_soubory/SPN_Introduction.pdf)).

The pathway, as obtained from KEGG, was first manually converted to a Stochastic Petri Net using [SNOOPY](http://www-dssz.informatik.tu-cottbus.de/DSSZ/Software/Snoopy) for a first experimentation.
The net was then simplified to capture only the most important aspects of the pathway. SNOOPY files for both the initial and simplified nets are in the /model directory.

While SNOOPY is good for a first exploration it is not very convenient for performing multiple simulations(for example for the inference of the SPN). `fa.py` contains functions to read the model from [PySCeS](http://pysces.sourceforge.net/) format(located in the /model directory along with the SNOOPY files) into the appropriate data structures and then simulate it.

`infer.py` contains a function to read the real data(real FA outputs of the pathway), which are located in the /data directory, and score a particular SPN based on how similar are the simulated data from that SPN to the real data.

