transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+RMSnormv2  -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.RMSnormv2 xil_defaultlib.glbl

do {RMSnormv2.udo}

run 1000ns

endsim

quit -force
