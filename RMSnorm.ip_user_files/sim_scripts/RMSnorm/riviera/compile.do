transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -incr -v2k5 -l xil_defaultlib \
"../../../../RMSnorm.gen/sources_1/bd/RMSnorm/ip/RMSnorm_rms_sum_top_0_0/sim/RMSnorm_rms_sum_top_0_0.v" \
"../../../../RMSnorm.gen/sources_1/bd/RMSnorm/ip/RMSnorm_rms_norm_top_0_0/sim/RMSnorm_rms_norm_top_0_0.v" \
"../../../../RMSnorm.gen/sources_1/bd/RMSnorm/sim/RMSnorm.v" \


vlog -work xil_defaultlib \
"glbl.v"

