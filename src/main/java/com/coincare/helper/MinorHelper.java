package com.coincare.helper;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

/**
 *
 * @author Dell
 */
public class MinorHelper {

  public static String getMonth(int month) {
    String monthStr = "";
    switch (month) {
      case 1:
        monthStr = "January";
        break;
      case 2:
        monthStr = "February";
        break;
      case 3:
        monthStr = "March";
        break;
      case 4:
        monthStr = "April";
        break;
      case 5:
        monthStr = "May";
        break;
      case 6:
        monthStr = "June";
        break;
      case 7:
        monthStr = "July";
        break;
      case 8:
        monthStr = "August";
        break;
      case 9:
        monthStr = "September";
        break;
      case 10:
        monthStr = "October";
        break;
      case 11:
        monthStr = "November";
        break;
      case 12:
        monthStr = "December";
        break;
      default:
        break;
    }
    return monthStr;
  }

  public static int getMonth(String monthStr) {
    int month = 0;
    switch (monthStr) {
      case "January":
        month = 1;
        break;
      case "February":
        month = 2;
        break;
      case "March":
        month = 3;
        break;
      case "April":
        month = 4;
        break;
      case "May":
        month = 5;
        break;
      case "Jun":
        month = 6;
        break;
      case "July":
        month = 7;
        break;
      case "August":
        month = 8;
        break;
      case "September":
        month = 9;
        break;
      case "October":
        month = 10;
        break;
      case "November":
        month = 11;
        break;
      case "December":
        month = 12;
        break;
      default:
        break;
    }
    return month;
  }

  public static String getDateFormatted(Timestamp dateTimeStamp) {
    String dateString = dateTimeStamp.toString();
    try {
      // Parse the date string into LocalDate
      LocalDate date = LocalDate.parse(dateString, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S"));

      // Define the desired output format
      DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");

      // Format the date
      String formattedDate = date.format(formatter);
      return formattedDate;
    } catch (DateTimeParseException e) {
      System.out.println("Invalid date format: " + e.getMessage());
    }
    return dateString;
  }

  public static LocalDate getStringToDate(String dateString) {
    // Optionally, define a formatter if the date string is not in the default ISO format
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    LocalDate localDate= LocalDate.now(); 
    try {
      // Parse the string to LocalDate
      localDate = LocalDate.parse(dateString, formatter);
      System.out.println("Converted LocalDate: " + localDate);
    } catch (DateTimeParseException e) {
      System.out.println("Invalid date format: " + e.getMessage());
    }
    return localDate;
  }
}
