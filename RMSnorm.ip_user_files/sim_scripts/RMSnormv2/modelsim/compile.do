vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr -mfcu  \
"../../../bd/RMSnormv2/ip/RMSnormv2_rms_sum_topv2_0_0/sim/RMSnormv2_rms_sum_topv2_0_0.v" \
"../../../bd/RMSnormv2/ip/RMSnormv2_rms_norm_top_0_0/sim/RMSnormv2_rms_norm_top_0_0.v" \
"../../../bd/RMSnormv2/sim/RMSnormv2.v" \


vlog -work xil_defaultlib \
"glbl.v"

