void updateTiming() {
  
  s = second();  // Values from 0 - 59
  mi = minute();  // Values from 0 - 59
  h = hour();    // Values from 0 - 23
  d = day();    // Values from 1 - 31
  mo = month();  // Values from 1 - 12
  y = year();   // 2003, 2004, 2005, etc.
  
  epoch = System.currentTimeMillis()/1000;
  
  DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
  epoch = (epoch * sim_dt_speedMult) + sim_dt_timeOfffset;
  simulatedDateTimeFormattedString = df.format(new Date( epoch * 1000 ));

}
