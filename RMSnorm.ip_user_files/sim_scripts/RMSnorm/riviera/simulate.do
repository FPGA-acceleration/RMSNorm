transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+RMSnorm  -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.RMSnorm xil_defaultlib.glbl

do {RMSnorm.udo}

run 1000ns

endsim

quit -force
