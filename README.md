# vcds_data_processing

R scripts to process and visualize data generated by Ross-Tech VCDS

---

## Usage

1. clone this repo into `Ross-Tech/VCDS`

2. open script in R Studio

3. `alt-o` to collapse code

4. change variable values in `"USER DEFINED VARIABLES"`

---

## misfires_rpm.R

This reads in data logged by the VCDS and produces a jittered bubble plot of misfires per 1000 revs vs. rpm

If you don't want to modify code, log data from the following channels:

* Engine RPM
* Vehicle speed
* Misfire totalizer
* Misfires per 1000 revolutions of cylinder 1
* Misfires per 1000 revolutions of cylinder 2
* Misfires per 1000 revolutions of cylinder 3
* Misfires per 1000 revolutions of cylinder 4
* Numb.of misfir.: cylinder 1
* Numb.of misfir.: cylinder 2
* Numb.of misfir.: cylinder 3
* Numb.of misfir.: cylinder 4
* Misfires all cylinders per 1000 rpm
