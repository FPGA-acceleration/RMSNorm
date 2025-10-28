onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib bf_mul_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {bf_mul.udo}

run 1000ns

quit -force
