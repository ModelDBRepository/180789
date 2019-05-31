TITLE GKCA
: FORREST MD (2014) Two Compartment Model of the Cerebellar Purkinje Neuron 

UNITS {
       (molar) = (1/liter)
        (pA) = (picoamp)
	(mV) =	(millivolt)
        (S) = (siemens)
	(mA) =	(milliamp)
	(mM) =	(millimolar)
}


INDEPENDENT {v FROM -100 TO 50 WITH 50 (mV)}

NEURON {
	SUFFIX gkca
	USEION ca READ cai
	USEION k  WRITE ik
	RANGE  gkbar,km,oinf,n,ik
 
}


PARAMETER {
        dt (ms)
        cai   (mM)
        km = 0.00019    (mM)
        n = 4.0
        cainit = 0.000184 (mM)
        celsius = 35  (degC)
        gkbar = 0 (mho/cm2)        : (S/cm2)
 :       ek = -100 (mV)
        
 
}

ASSIGNED { 
           ik		(mA/cm2)
           oinf           
           ek (mV)
}


BREAKPOINT {
        oinf = 1/(1 + pow(km/cai,n))
	ik = oinf*gkbar*(v - ek)
}


COMMENT
INITIAL{
       cai = cainit}
ENDCOMMENT

