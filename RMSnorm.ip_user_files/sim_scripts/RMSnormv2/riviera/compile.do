transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -incr -v2k5 -l xil_defaultlib \
"../../../bd/RMSnormv2/ip/RMSnormv2_rms_sum_topv2_0_0/sim/RMSnormv2_rms_sum_topv2_0_0.v" \
"../../../bd/RMSnormv2/ip/RMSnormv2_rms_norm_top_0_0/sim/RMSnormv2_rms_norm_top_0_0.v" \
"../../../bd/RMSnormv2/sim/RMSnormv2.v" \


vlog -work xil_defaultlib \
"glbl.v"

