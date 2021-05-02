# GBADVI

GBADVI is a custom DVI driver written in VHDL for the Gameboy Advance. It employs a custom PCB based around the Spartan-6 (XC6SLX9) FPGA that takes in GBA display and control signals (through SNES port) and outputs a pure DVI signal through the onboard HDMI. Project includes a custom quick solder flex cable made by [Helder](https://github.com/Helder1981) (Instagram: @angryhelder) that breaks out control signals to the FPGA as well as supplies power to the GBA itself.

## Deployment

To deploy firmware to the custom PCB, the project must be built by Xilinx ISE project navigator then subsequently flashed via Xilinx Impact sofware with the Xilinx Platform Cable II. 

## To-Do/Improvements

* Design custom case
* Implement sound and audio filters
* Implement scanlines 
* Implement color filters
* Implement OSD
* Implement additional controller support
* Port to alternate FPGAs/dev boards

## Known Issues

* Power button circuitry untested in latest PCB revision. A 0ohm jumper resistor has been added as a fail safe until the circuitry is officially tested by Gamebox Systems. The repository will be updated once the circuitry is tested.

## Built With

* [Xilinx ISE](https://www.xilinx.com/products/design-tools/ise-design-suite.html) - Synthesis and deployment suite

* [Eagle](https://www.autodesk.com/products/eagle/overview?plc=F360&term=1-YEAR&support=ADVANCED&quantity=1) - PCB design software

## Contributing

GBADVI is completely open source under GPL and those wanting to contribute are welcome to do so. Please feel free to submit a pull request.

## Authors

* **Oleksandr Kiyenko** - *System Architect* - [Oleksandr Kiyenko](https://github.com/kienko)

* **Aaron Silberman** - *Hardware Engineer* - [Postman](https://github.com/GameboxSystems/)

## License

This project is licensed under the GPLv3 License - see the LICENSE.md file for details

## Acknowledgments

* **zwenergy** - Original inspiration for the project, his [gbaHD] is a wonderful implementation that they were kind enough to give to us all. Thank you zwenergy!

