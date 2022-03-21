from fileinput import filename
from numpy import true_divide
import serial 
import csv
import time
# Write USB port on laptop uses COM5
# Default BUAD rate is 9600, but try up to 115200 for maximum speeds

ser = serial.Serial('COM5', 9600)
fileName = 'test.csv'
#ser_bytes = = ser.readline()
ser.flushInput()


while True:
    #display the data to the terminal
    getData=str(ser.readline())
    data=getData[0:][:-2]
    #print(data)

    #add the data to the file
    file = open(fileName) # Defaults to overwrite current log
    file.write(data + "\\n") #write data with a newline
    #close out the file
file.close()
