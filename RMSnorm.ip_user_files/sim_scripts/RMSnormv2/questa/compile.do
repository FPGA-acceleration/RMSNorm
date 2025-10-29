vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr -mfcu  \
"../../../bd/RMSnormv2/ip/RMSnormv2_rms_sum_topv2_0_0/sim/RMSnormv2_rms_sum_topv2_0_0.v" \
"../../../bd/RMSnormv2/ip/RMSnormv2_rms_norm_top_0_0/sim/RMSnormv2_rms_norm_top_0_0.v" \
"../../../bd/RMSnormv2/sim/RMSnormv2.v" \


vlog -work xil_defaultlib \
"glbl.v"

