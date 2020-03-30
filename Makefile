all:
	iverilog nano_sc_system.v nanocpu.v rom.v memory.v mux2_1.v alu.v control.v extender.v adder.v  regfile.v 
	mv a.out nano_sc_system.vvp

sim:
	vvp ./nano_sc_system.vvp
	open /Applications/Scansion.app ./nano_sc_system.vcd

clean:
	rm nano_sc_system.vvp
	rm nano_sc_system.vcd