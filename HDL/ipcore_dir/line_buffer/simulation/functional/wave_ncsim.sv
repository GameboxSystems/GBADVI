

 
 
 




window new WaveWindow  -name  "Waves for BMG Example Design"
waveform  using  "Waves for BMG Example Design"

      waveform add -signals /line_buffer_tb/status
      waveform add -signals /line_buffer_tb/line_buffer_synth_inst/bmg_port/CLKA
      waveform add -signals /line_buffer_tb/line_buffer_synth_inst/bmg_port/ADDRA
      waveform add -signals /line_buffer_tb/line_buffer_synth_inst/bmg_port/DINA
      waveform add -signals /line_buffer_tb/line_buffer_synth_inst/bmg_port/WEA
      waveform add -signals /line_buffer_tb/line_buffer_synth_inst/bmg_port/CLKB
      waveform add -signals /line_buffer_tb/line_buffer_synth_inst/bmg_port/ADDRB
      waveform add -signals /line_buffer_tb/line_buffer_synth_inst/bmg_port/DOUTB

console submit -using simulator -wait no "run"
