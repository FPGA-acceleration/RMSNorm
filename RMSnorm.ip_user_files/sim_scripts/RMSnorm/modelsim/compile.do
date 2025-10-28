vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr -mfcu  \
"../../../../RMSnorm.gen/sources_1/bd/RMSnorm/ip/RMSnorm_rms_sum_top_0_0/sim/RMSnorm_rms_sum_top_0_0.v" \
"../../../../RMSnorm.gen/sources_1/bd/RMSnorm/ip/RMSnorm_rms_norm_top_0_0/sim/RMSnorm_rms_norm_top_0_0.v" \
"../../../../RMSnorm.gen/sources_1/bd/RMSnorm/sim/RMSnorm.v" \


vlog -work xil_defaultlib \
"glbl.v"

