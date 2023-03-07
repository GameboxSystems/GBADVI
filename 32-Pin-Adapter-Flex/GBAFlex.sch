<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="9.6.2">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="2" name="Route2" color="16" fill="1" visible="no" active="no"/>
<layer number="3" name="Route3" color="17" fill="1" visible="no" active="no"/>
<layer number="4" name="Route4" color="18" fill="1" visible="no" active="no"/>
<layer number="5" name="Route5" color="19" fill="1" visible="no" active="no"/>
<layer number="6" name="Route6" color="25" fill="1" visible="no" active="no"/>
<layer number="7" name="Route7" color="26" fill="1" visible="no" active="no"/>
<layer number="8" name="Route8" color="27" fill="1" visible="no" active="no"/>
<layer number="9" name="Route9" color="28" fill="1" visible="no" active="no"/>
<layer number="10" name="Route10" color="29" fill="1" visible="no" active="no"/>
<layer number="11" name="Route11" color="30" fill="1" visible="no" active="no"/>
<layer number="12" name="Route12" color="20" fill="1" visible="no" active="no"/>
<layer number="13" name="Route13" color="21" fill="1" visible="no" active="no"/>
<layer number="14" name="Route14" color="22" fill="1" visible="no" active="no"/>
<layer number="15" name="Route15" color="23" fill="1" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="24" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="88" name="SimResults" color="9" fill="1" visible="yes" active="yes"/>
<layer number="89" name="SimProbes" color="9" fill="1" visible="yes" active="yes"/>
<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="32pin_0.5mm">
<packages>
<package name="32PIN_0.5MM">
<smd name="P$1" x="0.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$2" x="0.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$3" x="1.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$4" x="1.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$5" x="2.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$6" x="2.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$7" x="3.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$8" x="3.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$9" x="4.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$10" x="4.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$11" x="5.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$12" x="5.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$13" x="6.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$14" x="6.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$15" x="7.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$16" x="7.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$17" x="8.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$18" x="8.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$19" x="9.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$20" x="9.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$21" x="10.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$22" x="10.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$23" x="11.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$24" x="11.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$25" x="12.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$26" x="12.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$27" x="13.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$28" x="13.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$29" x="14.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$30" x="14.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$31" x="15.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$32" x="15.65" y="0" dx="0.3" dy="4" layer="1"/>
<wire x1="-0.35" y1="-2.1" x2="-0.35" y2="2.05" width="0.0762" layer="21"/>
<wire x1="-0.35" y1="2.05" x2="16.15" y2="2.05" width="0.0762" layer="21"/>
<wire x1="16.15" y1="2.05" x2="16.15" y2="-2.15" width="0.0762" layer="21"/>
</package>
</packages>
<symbols>
<symbol name="32PIN_0.5MM">
<wire x1="-10.16" y1="48.26" x2="-10.16" y2="-35.56" width="0.0762" layer="94"/>
<wire x1="-10.16" y1="-35.56" x2="10.16" y2="-35.56" width="0.0762" layer="94"/>
<wire x1="10.16" y1="-35.56" x2="10.16" y2="48.26" width="0.0762" layer="94"/>
<wire x1="10.16" y1="48.26" x2="-10.16" y2="48.26" width="0.0762" layer="94"/>
<pin name="P$1" x="15.24" y="45.72" length="middle" rot="R180"/>
<pin name="P$2" x="15.24" y="43.18" length="middle" rot="R180"/>
<pin name="P$3" x="15.24" y="40.64" length="middle" rot="R180"/>
<pin name="P$4" x="15.24" y="38.1" length="middle" rot="R180"/>
<pin name="P$5" x="15.24" y="35.56" length="middle" rot="R180"/>
<pin name="P$6" x="15.24" y="33.02" length="middle" rot="R180"/>
<pin name="P$7" x="15.24" y="30.48" length="middle" rot="R180"/>
<pin name="P$8" x="15.24" y="27.94" length="middle" rot="R180"/>
<pin name="P$9" x="15.24" y="25.4" length="middle" rot="R180"/>
<pin name="P$10" x="15.24" y="22.86" length="middle" rot="R180"/>
<pin name="P$11" x="15.24" y="20.32" length="middle" rot="R180"/>
<pin name="P$12" x="15.24" y="17.78" length="middle" rot="R180"/>
<pin name="P$13" x="15.24" y="15.24" length="middle" rot="R180"/>
<pin name="P$14" x="15.24" y="12.7" length="middle" rot="R180"/>
<pin name="P$15" x="15.24" y="10.16" length="middle" rot="R180"/>
<pin name="P$16" x="15.24" y="7.62" length="middle" rot="R180"/>
<pin name="P$17" x="15.24" y="5.08" length="middle" rot="R180"/>
<pin name="P$18" x="15.24" y="2.54" length="middle" rot="R180"/>
<pin name="P$19" x="15.24" y="0" length="middle" rot="R180"/>
<pin name="P$20" x="15.24" y="-2.54" length="middle" rot="R180"/>
<pin name="P$21" x="15.24" y="-5.08" length="middle" rot="R180"/>
<pin name="P$22" x="15.24" y="-7.62" length="middle" rot="R180"/>
<pin name="P$23" x="15.24" y="-10.16" length="middle" rot="R180"/>
<pin name="P$24" x="15.24" y="-12.7" length="middle" rot="R180"/>
<pin name="P$25" x="15.24" y="-15.24" length="middle" rot="R180"/>
<pin name="P$26" x="15.24" y="-17.78" length="middle" rot="R180"/>
<pin name="P$27" x="15.24" y="-20.32" length="middle" rot="R180"/>
<pin name="P$28" x="15.24" y="-22.86" length="middle" rot="R180"/>
<pin name="P$29" x="15.24" y="-25.4" length="middle" rot="R180"/>
<pin name="P$30" x="15.24" y="-27.94" length="middle" rot="R180"/>
<pin name="P$31" x="15.24" y="-30.48" length="middle" rot="R180"/>
<pin name="P$32" x="15.24" y="-33.02" length="middle" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="32PIN_0.5MM">
<gates>
<gate name="G$1" symbol="32PIN_0.5MM" x="0" y="-7.62"/>
</gates>
<devices>
<device name="" package="32PIN_0.5MM">
<connects>
<connect gate="G$1" pin="P$1" pad="P$1"/>
<connect gate="G$1" pin="P$10" pad="P$10"/>
<connect gate="G$1" pin="P$11" pad="P$11"/>
<connect gate="G$1" pin="P$12" pad="P$12"/>
<connect gate="G$1" pin="P$13" pad="P$13"/>
<connect gate="G$1" pin="P$14" pad="P$14"/>
<connect gate="G$1" pin="P$15" pad="P$15"/>
<connect gate="G$1" pin="P$16" pad="P$16"/>
<connect gate="G$1" pin="P$17" pad="P$17"/>
<connect gate="G$1" pin="P$18" pad="P$18"/>
<connect gate="G$1" pin="P$19" pad="P$19"/>
<connect gate="G$1" pin="P$2" pad="P$2"/>
<connect gate="G$1" pin="P$20" pad="P$20"/>
<connect gate="G$1" pin="P$21" pad="P$21"/>
<connect gate="G$1" pin="P$22" pad="P$22"/>
<connect gate="G$1" pin="P$23" pad="P$23"/>
<connect gate="G$1" pin="P$24" pad="P$24"/>
<connect gate="G$1" pin="P$25" pad="P$25"/>
<connect gate="G$1" pin="P$26" pad="P$26"/>
<connect gate="G$1" pin="P$27" pad="P$27"/>
<connect gate="G$1" pin="P$28" pad="P$28"/>
<connect gate="G$1" pin="P$29" pad="P$29"/>
<connect gate="G$1" pin="P$3" pad="P$3"/>
<connect gate="G$1" pin="P$30" pad="P$30"/>
<connect gate="G$1" pin="P$31" pad="P$31"/>
<connect gate="G$1" pin="P$32" pad="P$32"/>
<connect gate="G$1" pin="P$4" pad="P$4"/>
<connect gate="G$1" pin="P$5" pad="P$5"/>
<connect gate="G$1" pin="P$6" pad="P$6"/>
<connect gate="G$1" pin="P$7" pad="P$7"/>
<connect gate="G$1" pin="P$8" pad="P$8"/>
<connect gate="G$1" pin="P$9" pad="P$9"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="40pin_0.5mm">
<packages>
<package name="40PIN_0.5MM">
<smd name="P$1" x="0.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$2" x="0.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$3" x="1.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$4" x="1.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$5" x="2.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$6" x="2.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$7" x="3.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$8" x="3.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$9" x="4.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$10" x="4.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$11" x="5.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$12" x="5.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$13" x="6.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$14" x="6.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$15" x="7.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$16" x="7.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$17" x="8.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$18" x="8.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$19" x="9.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$20" x="9.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$21" x="10.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$22" x="10.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$23" x="11.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$24" x="11.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$25" x="12.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$26" x="12.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$27" x="13.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$28" x="13.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$29" x="14.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$30" x="14.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$31" x="15.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$32" x="15.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$33" x="16.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$34" x="16.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$35" x="17.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$36" x="17.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$37" x="18.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$38" x="18.65" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$39" x="19.15" y="0" dx="0.3" dy="4" layer="1"/>
<smd name="P$40" x="19.65" y="0" dx="0.3" dy="4" layer="1"/>
<wire x1="-0.35" y1="-2.25" x2="-0.35" y2="2.05" width="0.0762" layer="21"/>
<wire x1="-0.35" y1="2.05" x2="20.15" y2="2.05" width="0.0762" layer="21"/>
<wire x1="20.15" y1="2.05" x2="20.15" y2="-2.45" width="0.0762" layer="21"/>
</package>
</packages>
<symbols>
<symbol name="40PIN_0.5MM">
<wire x1="-2.54" y1="38.1" x2="-2.54" y2="-66.04" width="0.0762" layer="94"/>
<wire x1="-2.54" y1="-66.04" x2="12.7" y2="-66.04" width="0.0762" layer="94"/>
<wire x1="12.7" y1="-66.04" x2="12.7" y2="38.1" width="0.0762" layer="94"/>
<wire x1="12.7" y1="38.1" x2="-2.54" y2="38.1" width="0.0762" layer="94"/>
<pin name="P$1" x="17.78" y="35.56" length="middle" rot="R180"/>
<pin name="P$2" x="17.78" y="33.02" length="middle" rot="R180"/>
<pin name="P$3" x="17.78" y="30.48" length="middle" rot="R180"/>
<pin name="P$4" x="17.78" y="27.94" length="middle" rot="R180"/>
<pin name="P$5" x="17.78" y="25.4" length="middle" rot="R180"/>
<pin name="P$6" x="17.78" y="22.86" length="middle" rot="R180"/>
<pin name="P$7" x="17.78" y="20.32" length="middle" rot="R180"/>
<pin name="P$8" x="17.78" y="17.78" length="middle" rot="R180"/>
<pin name="P$9" x="17.78" y="15.24" length="middle" rot="R180"/>
<pin name="P$10" x="17.78" y="12.7" length="middle" rot="R180"/>
<pin name="P$11" x="17.78" y="10.16" length="middle" rot="R180"/>
<pin name="P$12" x="17.78" y="7.62" length="middle" rot="R180"/>
<pin name="P$13" x="17.78" y="5.08" length="middle" rot="R180"/>
<pin name="P$14" x="17.78" y="2.54" length="middle" rot="R180"/>
<pin name="P$15" x="17.78" y="0" length="middle" rot="R180"/>
<pin name="P$16" x="17.78" y="-2.54" length="middle" rot="R180"/>
<pin name="P$17" x="17.78" y="-5.08" length="middle" rot="R180"/>
<pin name="P$18" x="17.78" y="-7.62" length="middle" rot="R180"/>
<pin name="P$19" x="17.78" y="-10.16" length="middle" rot="R180"/>
<pin name="P$20" x="17.78" y="-12.7" length="middle" rot="R180"/>
<pin name="P$21" x="17.78" y="-15.24" length="middle" rot="R180"/>
<pin name="P$22" x="17.78" y="-17.78" length="middle" rot="R180"/>
<pin name="P$23" x="17.78" y="-20.32" length="middle" rot="R180"/>
<pin name="P$24" x="17.78" y="-22.86" length="middle" rot="R180"/>
<pin name="P$25" x="17.78" y="-25.4" length="middle" rot="R180"/>
<pin name="P$26" x="17.78" y="-27.94" length="middle" rot="R180"/>
<pin name="P$27" x="17.78" y="-30.48" length="middle" rot="R180"/>
<pin name="P$28" x="17.78" y="-33.02" length="middle" rot="R180"/>
<pin name="P$29" x="17.78" y="-35.56" length="middle" rot="R180"/>
<pin name="P$30" x="17.78" y="-38.1" length="middle" rot="R180"/>
<pin name="P$31" x="17.78" y="-40.64" length="middle" rot="R180"/>
<pin name="P$32" x="17.78" y="-43.18" length="middle" rot="R180"/>
<pin name="P$33" x="17.78" y="-45.72" length="middle" rot="R180"/>
<pin name="P$34" x="17.78" y="-48.26" length="middle" rot="R180"/>
<pin name="P$35" x="17.78" y="-50.8" length="middle" rot="R180"/>
<pin name="P$36" x="17.78" y="-53.34" length="middle" rot="R180"/>
<pin name="P$37" x="17.78" y="-55.88" length="middle" rot="R180"/>
<pin name="P$38" x="17.78" y="-58.42" length="middle" rot="R180"/>
<pin name="P$39" x="17.78" y="-60.96" length="middle" rot="R180"/>
<pin name="P$40" x="17.78" y="-63.5" length="middle" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="40PIN_0.5MM">
<gates>
<gate name="G$1" symbol="40PIN_0.5MM" x="-5.08" y="12.7"/>
</gates>
<devices>
<device name="" package="40PIN_0.5MM">
<connects>
<connect gate="G$1" pin="P$1" pad="P$1"/>
<connect gate="G$1" pin="P$10" pad="P$10"/>
<connect gate="G$1" pin="P$11" pad="P$11"/>
<connect gate="G$1" pin="P$12" pad="P$12"/>
<connect gate="G$1" pin="P$13" pad="P$13"/>
<connect gate="G$1" pin="P$14" pad="P$14"/>
<connect gate="G$1" pin="P$15" pad="P$15"/>
<connect gate="G$1" pin="P$16" pad="P$16"/>
<connect gate="G$1" pin="P$17" pad="P$17"/>
<connect gate="G$1" pin="P$18" pad="P$18"/>
<connect gate="G$1" pin="P$19" pad="P$19"/>
<connect gate="G$1" pin="P$2" pad="P$2"/>
<connect gate="G$1" pin="P$20" pad="P$20"/>
<connect gate="G$1" pin="P$21" pad="P$21"/>
<connect gate="G$1" pin="P$22" pad="P$22"/>
<connect gate="G$1" pin="P$23" pad="P$23"/>
<connect gate="G$1" pin="P$24" pad="P$24"/>
<connect gate="G$1" pin="P$25" pad="P$25"/>
<connect gate="G$1" pin="P$26" pad="P$26"/>
<connect gate="G$1" pin="P$27" pad="P$27"/>
<connect gate="G$1" pin="P$28" pad="P$28"/>
<connect gate="G$1" pin="P$29" pad="P$29"/>
<connect gate="G$1" pin="P$3" pad="P$3"/>
<connect gate="G$1" pin="P$30" pad="P$30"/>
<connect gate="G$1" pin="P$31" pad="P$31"/>
<connect gate="G$1" pin="P$32" pad="P$32"/>
<connect gate="G$1" pin="P$33" pad="P$33"/>
<connect gate="G$1" pin="P$34" pad="P$34"/>
<connect gate="G$1" pin="P$35" pad="P$35"/>
<connect gate="G$1" pin="P$36" pad="P$36"/>
<connect gate="G$1" pin="P$37" pad="P$37"/>
<connect gate="G$1" pin="P$38" pad="P$38"/>
<connect gate="G$1" pin="P$39" pad="P$39"/>
<connect gate="G$1" pin="P$4" pad="P$4"/>
<connect gate="G$1" pin="P$40" pad="P$40"/>
<connect gate="G$1" pin="P$5" pad="P$5"/>
<connect gate="G$1" pin="P$6" pad="P$6"/>
<connect gate="G$1" pin="P$7" pad="P$7"/>
<connect gate="G$1" pin="P$8" pad="P$8"/>
<connect gate="G$1" pin="P$9" pad="P$9"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="U$1" library="32pin_0.5mm" deviceset="32PIN_0.5MM" device=""/>
<part name="U$2" library="40pin_0.5mm" deviceset="40PIN_0.5MM" device=""/>
</parts>
<sheets>
<sheet>
<plain>
</plain>
<instances>
<instance part="U$1" gate="G$1" x="3.81" y="45.72" smashed="yes"/>
<instance part="U$2" gate="G$1" x="-5.08" y="-30.48" smashed="yes"/>
</instances>
<busses>
</busses>
<nets>
<net name="DCLK" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$38"/>
<wire x1="12.7" y1="-88.9" x2="24.13" y2="-88.9" width="0.1524" layer="91"/>
<label x="24.13" y="-88.9" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$31"/>
<wire x1="19.05" y1="15.24" x2="26.67" y2="15.24" width="0.1524" layer="91"/>
<label x="26.67" y="15.24" size="1.778" layer="95"/>
</segment>
</net>
<net name="GND" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$35"/>
<wire x1="12.7" y1="-81.28" x2="24.13" y2="-81.28" width="0.1524" layer="91"/>
<label x="24.13" y="-81.28" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$27"/>
<wire x1="19.05" y1="25.4" x2="26.67" y2="25.4" width="0.1524" layer="91"/>
<label x="26.67" y="25.4" size="1.778" layer="95"/>
</segment>
</net>
<net name="R5" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$33"/>
<wire x1="12.7" y1="-76.2" x2="24.13" y2="-76.2" width="0.1524" layer="91"/>
<label x="24.13" y="-76.2" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$26"/>
<wire x1="19.05" y1="27.94" x2="26.67" y2="27.94" width="0.1524" layer="91"/>
<label x="26.67" y="27.94" size="1.778" layer="95"/>
</segment>
</net>
<net name="R4" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$32"/>
<wire x1="12.7" y1="-73.66" x2="24.13" y2="-73.66" width="0.1524" layer="91"/>
<label x="24.13" y="-73.66" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$25"/>
<wire x1="19.05" y1="30.48" x2="26.67" y2="30.48" width="0.1524" layer="91"/>
<label x="26.67" y="30.48" size="1.778" layer="95"/>
</segment>
</net>
<net name="R3" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$31"/>
<wire x1="12.7" y1="-71.12" x2="24.13" y2="-71.12" width="0.1524" layer="91"/>
<label x="24.13" y="-71.12" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$24"/>
<wire x1="19.05" y1="33.02" x2="26.67" y2="33.02" width="0.1524" layer="91"/>
<label x="26.67" y="33.02" size="1.778" layer="95"/>
</segment>
</net>
<net name="R2" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$30"/>
<wire x1="12.7" y1="-68.58" x2="24.13" y2="-68.58" width="0.1524" layer="91"/>
<label x="24.13" y="-68.58" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$23"/>
<wire x1="19.05" y1="35.56" x2="26.67" y2="35.56" width="0.1524" layer="91"/>
<label x="26.67" y="35.56" size="1.778" layer="95"/>
</segment>
</net>
<net name="R1" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$29"/>
<wire x1="12.7" y1="-66.04" x2="24.13" y2="-66.04" width="0.1524" layer="91"/>
<label x="24.13" y="-66.04" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$22"/>
<wire x1="19.05" y1="38.1" x2="26.67" y2="38.1" width="0.1524" layer="91"/>
<label x="26.67" y="38.1" size="1.778" layer="95"/>
</segment>
</net>
<net name="G5" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$28"/>
<wire x1="12.7" y1="-63.5" x2="24.13" y2="-63.5" width="0.1524" layer="91"/>
<label x="24.13" y="-63.5" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$21"/>
<wire x1="19.05" y1="40.64" x2="26.67" y2="40.64" width="0.1524" layer="91"/>
<label x="26.67" y="40.64" size="1.778" layer="95"/>
</segment>
</net>
<net name="G4" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$27"/>
<wire x1="12.7" y1="-60.96" x2="24.13" y2="-60.96" width="0.1524" layer="91"/>
<label x="24.13" y="-60.96" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$20"/>
<wire x1="19.05" y1="43.18" x2="26.67" y2="43.18" width="0.1524" layer="91"/>
<label x="26.67" y="43.18" size="1.778" layer="95"/>
</segment>
</net>
<net name="G3" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$26"/>
<wire x1="12.7" y1="-58.42" x2="24.13" y2="-58.42" width="0.1524" layer="91"/>
<label x="24.13" y="-58.42" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$19"/>
<wire x1="19.05" y1="45.72" x2="26.67" y2="45.72" width="0.1524" layer="91"/>
<label x="26.67" y="45.72" size="1.778" layer="95"/>
</segment>
</net>
<net name="G2" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$25"/>
<wire x1="12.7" y1="-55.88" x2="24.13" y2="-55.88" width="0.1524" layer="91"/>
<label x="24.13" y="-55.88" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$18"/>
<wire x1="19.05" y1="48.26" x2="26.67" y2="48.26" width="0.1524" layer="91"/>
<label x="26.67" y="48.26" size="1.778" layer="95"/>
</segment>
</net>
<net name="G1" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$24"/>
<wire x1="12.7" y1="-53.34" x2="24.13" y2="-53.34" width="0.1524" layer="91"/>
<label x="25.4" y="-53.34" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$17"/>
<wire x1="19.05" y1="50.8" x2="26.67" y2="50.8" width="0.1524" layer="91"/>
<label x="26.67" y="50.8" size="1.778" layer="95"/>
</segment>
</net>
<net name="B5" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$22"/>
<wire x1="12.7" y1="-48.26" x2="24.13" y2="-48.26" width="0.1524" layer="91"/>
<label x="24.13" y="-48.26" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$15"/>
<wire x1="19.05" y1="55.88" x2="26.67" y2="55.88" width="0.1524" layer="91"/>
<label x="26.67" y="55.88" size="1.778" layer="95"/>
</segment>
</net>
<net name="B4" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$21"/>
<wire x1="12.7" y1="-45.72" x2="24.13" y2="-45.72" width="0.1524" layer="91"/>
<label x="24.13" y="-45.72" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$14"/>
<wire x1="19.05" y1="58.42" x2="26.67" y2="58.42" width="0.1524" layer="91"/>
<label x="26.67" y="58.42" size="1.778" layer="95"/>
</segment>
</net>
<net name="B3" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$20"/>
<wire x1="12.7" y1="-43.18" x2="24.13" y2="-43.18" width="0.1524" layer="91"/>
<label x="24.13" y="-43.18" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$13"/>
<wire x1="19.05" y1="60.96" x2="26.67" y2="60.96" width="0.1524" layer="91"/>
<label x="26.67" y="60.96" size="1.778" layer="95"/>
</segment>
</net>
<net name="B2" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$19"/>
<wire x1="12.7" y1="-40.64" x2="24.13" y2="-40.64" width="0.1524" layer="91"/>
<label x="24.13" y="-40.64" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$12"/>
<wire x1="19.05" y1="63.5" x2="26.67" y2="63.5" width="0.1524" layer="91"/>
<label x="26.67" y="63.5" size="1.778" layer="95"/>
</segment>
</net>
<net name="B1" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$18"/>
<wire x1="12.7" y1="-38.1" x2="24.13" y2="-38.1" width="0.1524" layer="91"/>
<label x="24.13" y="-38.1" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$11"/>
<wire x1="19.05" y1="66.04" x2="26.67" y2="66.04" width="0.1524" layer="91"/>
<label x="26.67" y="66.04" size="1.778" layer="95"/>
</segment>
</net>
<net name="SPL" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$17"/>
<wire x1="12.7" y1="-35.56" x2="24.13" y2="-35.56" width="0.1524" layer="91"/>
<label x="24.13" y="-35.56" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$10"/>
<wire x1="19.05" y1="68.58" x2="26.67" y2="68.58" width="0.1524" layer="91"/>
<label x="26.67" y="68.58" size="1.778" layer="95"/>
</segment>
</net>
<net name="SPS" class="0">
<segment>
<pinref part="U$2" gate="G$1" pin="P$15"/>
<wire x1="12.7" y1="-30.48" x2="24.13" y2="-30.48" width="0.1524" layer="91"/>
<label x="24.13" y="-30.48" size="1.778" layer="95"/>
</segment>
<segment>
<pinref part="U$1" gate="G$1" pin="P$8"/>
<wire x1="19.05" y1="73.66" x2="26.67" y2="73.66" width="0.1524" layer="91"/>
<label x="26.67" y="73.66" size="1.778" layer="95"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
</eagle>
