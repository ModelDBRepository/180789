TITLE slowly inactivating K current
: FORREST MD (2014) Two Compartment Model of the Cerebellar Purkinje Neuron
 
COMMENT
  from "An Active Membrane Model of the Cerebellar Purkinje Cell
        1. Simulation of Current Clamp in Slice"
ENDCOMMENT
 
UNITS {
        (mA) = (milliamp)
        (mV) = (millivolt)
}
 
NEURON {
        SUFFIX kd
        USEION k READ ek  WRITE ik
        RANGE  gkbar, ik, gk, minf, hinf, mexp, hexp, h
} 
 
INDEPENDENT {t FROM 0 TO 1 WITH 1 (ms)}
 
PARAMETER {
        v (mV)
        celsius = 37 (degC)
        dt (ms)
        gkbar = .0045 (mho/cm2)
   :     ek = -85 (mV)
}
 
STATE {
        m h
}
 
ASSIGNED {
        ik (mA/cm2)
        gk minf hinf mexp hexp 
         ek (mV)
}
 
BREAKPOINT {
        SOLVE states
        gk = gkbar * m*h
	ik = gk* (v-ek)
}
 
UNITSOFF
 
INITIAL {
	rates(v)
	m = minf
	h = hinf
}

PROCEDURE states() {  :Computes state variables m, h
        rates(v)      :             at the current v and dt.
        m = m + mexp*(minf-m)
        h = h + hexp*(hinf-h)
}
 
PROCEDURE rates(v) {  :Computes rate and other constants at current v.
                      :Call once from HOC to initialize inf at resting v.
        LOCAL  q10, tinc, alpha, beta, sum
        TABLE minf, mexp, hinf, hexp DEPEND dt, celsius FROM -100 TO 100 WITH 200
        q10 = 3^((celsius - 37)/10)
        tinc = -dt * q10
                :"m" potassium activation system
        alpha = 8.5/(1+exp((v+17)/(-12.5)))
        beta =  35/(1+exp((v+99)/14.5))
        sum = alpha + beta
        minf = alpha/sum
        mexp = 1 - exp(tinc*sum/10)
                :"h" potassium inactivation system
        alpha = 0.0015/(1+exp((v+89)/8))
        beta = 0.0055/(1+exp((v+83)/(-8)))
        sum = alpha + beta
        hinf = alpha/sum
        hexp = 1 - exp(tinc*sum*1.6)
}

 
UNITSON

