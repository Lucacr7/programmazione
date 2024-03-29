import("stdfaust.lib");
fader = vslider("[01]", -70., -70., +12., 0.1) : ba.db2linear : si.smoo;
panpot = vslider("[02]panpot [style:knob]", 0.5, 0.0, 1.0, 0.01) ; 
vmeter(x) = attach(x, envelop(x) : vbargraph("[99][unit:dB]", -70, +5))
with {
    envelop = abs : max ~ -(1.0/ma.SR) : max(ba.db2linear(-70)) : ba.linear2db;
}; 
pmode = nentry ("[01] pan mode [style:menu {'LInear' :0; 'exponential?:1}]", 0, 0, 1, 1) : int ;
process = _ <: * (1-panpot), * (sqrt(1-panpot)), * (panpot), * (sqrt(panpot)): ba.selectn (2,pmode), ba.selectn(2,pmode) : hgroup("meters [03]", *(fader), *(fader) : vmeter, vmeter);

//attach interrompe il flusso di un segnale, ma non chiudendolo, processandolo (envelop) (x,y) x*1,y*0
//vmeter ci da i valori dell'onda, ma la parte negativa viene resa positiva
//abs da il valore assoluto
//max è il valore massimo che può essere espresso
//SR significa Sample Rate
//(1.0/ma.SR) esprime la divisione di uno per la frequenza di campionamento
//db2linear converte i dB in valori da 0 a 1
//tutti i valori di process a envelop vanno a vbargraph che ce li a in forma visiva
