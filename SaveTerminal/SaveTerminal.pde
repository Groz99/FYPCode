import processing.serial.*;
Serial mySerial;
Table table;

void setup()
{
  //set mySerial to listen on COM port 10 at 9600 baud
  mySerial = new Serial(this, "COM3", 9600);
  
  table = new Table();
  //add a column header "Data" for the collected data
  table.addColumn("Data");
}

void draw()
{
  if(mySerial.available() > 0)
  {
    //set the value recieved as a String
    String value = mySerial.readString();
    //check to make sure there is a value
    if(value != null)
    {
      //add a new row for each value
      TableRow newRow = table.addRow();
      //place the new row and value under the "Data" column
      newRow.setString("Data", value);
    }
  }
  saveTable(table, "data/table.csv");
  //exit();
}
