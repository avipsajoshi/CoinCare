package com.coincare.helper;

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
}
