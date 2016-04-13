
 
 
 




window new WaveWindow  -name  "Waves for BMG Example Design"
waveform  using  "Waves for BMG Example Design"


      waveform add -signals /Ext_Mem_tb/status
      waveform add -signals /Ext_Mem_tb/Ext_Mem_synth_inst/bmg_port/CLKA
      waveform add -signals /Ext_Mem_tb/Ext_Mem_synth_inst/bmg_port/ADDRA
      waveform add -signals /Ext_Mem_tb/Ext_Mem_synth_inst/bmg_port/DINA
      waveform add -signals /Ext_Mem_tb/Ext_Mem_synth_inst/bmg_port/WEA
      waveform add -signals /Ext_Mem_tb/Ext_Mem_synth_inst/bmg_port/CLKB
      waveform add -signals /Ext_Mem_tb/Ext_Mem_synth_inst/bmg_port/ADDRB
      waveform add -signals /Ext_Mem_tb/Ext_Mem_synth_inst/bmg_port/DOUTB
console submit -using simulator -wait no "run"
