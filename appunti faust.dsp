import("stdfaust.lib");
panpot = vslider("panpot [style:knob]", 0.5, 0.0, 1.0, 0.01);
process = _ <: _,_ : * (1-panpot), * (panpot) ;
