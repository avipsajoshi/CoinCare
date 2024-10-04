package com.coincare.service;

import com.coincare.dao.CategoryDao;
import com.coincare.entities.Category;
import com.coincare.entities.Expense;
import com.coincare.helper.FactoryProvider;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.time.DayOfWeek;
import java.time.Instant;
import java.util.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalAdjusters;
//MLR for expense record prediction

public class ExpensePredictionService {

  // Reference date for numeric conversion of dates
  private static final LocalDate REFERENCE_DATE = LocalDate.now();
  private Map<String, Integer> categoryMap;

  public ExpensePredictionService() {
    categoryMap = new HashMap<>();
    loadCategoryMap(); // Load once during initialization
  }

  // Method to predict expenses
  public double predictExpense(List<Expense> expenses, String newCategory, LocalDate newDate) {
    if (expenses.isEmpty()) {
      throw new IllegalArgumentException("Expense list is empty.");
    }
    DecimalFormat df = new DecimalFormat("#.00");
    System.out.println(expenses.size());
    List<Double> dates = new ArrayList<Double>();
    List<Double> category = new ArrayList<Double>();
    List<Double> amount = new ArrayList<Double>();
    LocalDate now = LocalDate.now();  // Adjust to get Sunday
    DayOfWeek dayOfWeek = now.getDayOfWeek();
    LocalDate startOfWeek = now.minusDays(dayOfWeek.getValue() % 7);  // Adjust to get Sunday
    LocalDate endOfWeek = startOfWeek.plusDays(6);  // Saturday
    LocalDate firstDayOfMonth =  now.minusMonths(1).with(TemporalAdjusters.firstDayOfMonth());
    LocalDate lastDayOfMonth = now.with(TemporalAdjusters.lastDayOfMonth());
    for (Expense exp : expenses) {
      LocalDate dateExist = convertTimestampToLocalDate(exp.getExpenseDate());
      if (dateExist.isBefore(lastDayOfMonth) && dateExist.isAfter(firstDayOfMonth)) {
        dates.add(convertDateToNumeric(dateExist));
        category.add(convertCategoryToNumeric(exp.getCategory().getCategoryTitle()));
        amount.add(exp.getExpenseAmount());
      }
    }
    // Convert expense dates to numeric values
    double[] numericDates = dates.stream().mapToDouble(Double::doubleValue).toArray();
    double[] numericCategories = category.stream().mapToDouble(Double::doubleValue).toArray();
    double[] amounts = amount.stream().mapToDouble(Double::doubleValue).toArray();
    // Convert expense categories to numeric values
//    Prepare matrix X and vector y
    double[][] X = prepareMatrixX(numericDates, numericCategories);
    double[] y = amounts;

    // Calculate regression coefficients
    double[] coefficients = calculateRegressionCoefficients(X, y);

    // Convert new date and category to numeric values
    double newNumericDate = -ChronoUnit.DAYS.between(REFERENCE_DATE, newDate);
    double newNumericCategory = convertCategoryToNumeric(newCategory);

    System.out.println("Dates: " + Arrays.toString(numericDates));

    System.out.println("Intercept: " + coefficients[0]);
    System.out.println("Category Coefficient: " + coefficients[1]);
    System.out.println("Date Coefficient: " + coefficients[2]);
    // Predict expense for the new category and date
    double predictedExp = coefficients[0] + coefficients[1] * newNumericCategory + coefficients[2] * newNumericDate;
    return predictedExp;
  }

  // Convert a single category to numeric value
  private void loadCategoryMap() {
    CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> allCategory = cDao.getAllCategory();
    for (int i = 0; i < allCategory.size(); i++) {
      categoryMap.put(allCategory.get(i).getCategoryTitle(), i + 1);
    }
  }

  private double convertCategoryToNumeric(String category) {
    return categoryMap.getOrDefault(category, 18);
  }

  // Prepare matrix X with an intercept column
  private double[][] prepareMatrixX(double[] dates, double[] categories) {

    int n = dates.length;
    System.out.println(n);
    double[][] X = new double[n][3];
    for (int i = 0; i < n; i++) {
      X[i][0] = 1; // Intercept term
      X[i][1] = categories[i];
      X[i][2] = dates[i];
    }

    System.out.println(" X ");
    for (double[] row : X) {
      for (double value : row) {
        System.out.print(value + " ");
      }
      System.out.println(" ");
    }

    return X;
  }

  // Calculate regression coefficients using the formula: B = (X^T * X)^(-1) * X^T * y
  private double[] calculateRegressionCoefficients(double[][] X, double[] y) {
    // Transpose X
    double[][] Xt = transpose(X);
    // Xt * X
    double[][] XtX = multiplyMatrices(Xt, X);
    // Inverse of XtX
    double[][] XtX_inv = invertMatrix(XtX);
    // Xt * y
    double[] Xty = multiplyMatrixAndVector(Xt, y);
    // Coefficients B = XtX_inv * Xty
    return multiplyMatrixAndVector(XtX_inv, Xty);
  }

  private double[][] transpose(double[][] matrix) {
    double[][] transpose = new double[matrix[0].length][matrix.length];

    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        transpose[j][i] = matrix[i][j];
      }
    }
    System.out.println(" trans ");
    for (double[] row : transpose) {
      for (double value : row) {
        System.out.print(value + " ");
      }
      System.out.println(" ");
    }
    return transpose;
  }

  private double[][] multiplyMatrices(double[][] a, double[][] b) {
    int aRows = a.length;
    int aCols = a[0].length;
    int bCols = b[0].length;

    double[][] result = new double[aRows][bCols];

    for (int i = 0; i < aRows; i++) {
      for (int j = 0; j < bCols; j++) {
        for (int k = 0; k < aCols; k++) {
          result[i][j] += a[i][k] * b[k][j];
        }
      }
    }
    System.out.println(" mul ");
    for (double[] row : result) {
      for (double value : row) {
        System.out.print(value + " ");
      }
      System.out.println(" ");
    }

    return result;
  }

  private double[] multiplyMatrixAndVector(double[][] matrix, double[] vector) {
    int rows = matrix.length;
    int cols = matrix[0].length;

    double[] result = new double[rows];

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        result[i] += matrix[i][j] * vector[j];
      }
    }

    System.out.println("Vector mul ");
    for (double value : result) {
      System.out.print(value + " ");
    }

    return result;
  }

  private double determinant(double[][] matrix) {
    if (matrix.length != matrix[0].length) {
      throw new IllegalStateException("invalid dimensions");
    }

    if (matrix.length == 2) {
      return matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0];
    }

    double det = 0;
    for (int i = 0; i < matrix[0].length; i++) {
      det += Math.pow(-1, i) * matrix[0][i]
              * determinant(submatrix(matrix, 0, i));
    }
    System.out.println("Det" + det);
    return det;
  }

  private double[][] invertMatrix(double[][] matrix) {
    double[][] inverse = new double[matrix.length][matrix.length];

    // minors and cofactors
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        inverse[i][j] = Math.pow(-1, i + j)
                * determinant(submatrix(matrix, i, j));
      }
    }

    // adjugate and determinant
    if (determinant(matrix) != 0) {
      double det = 1.0 / determinant(matrix);
      for (int i = 0; i < inverse.length; i++) {
        for (int j = 0; j <= i; j++) {
          double temp = inverse[i][j];
          inverse[i][j] = inverse[j][i] * det;
          inverse[j][i] = temp * det;
        }
      }
    }

    System.out.println("inverse");
    for (double[] row : inverse) {
      System.out.println(Arrays.toString(row));
    }

    return inverse;
  }

  private double[][] submatrix(double[][] matrix, int row, int column) {
    double[][] submatrix = new double[matrix.length - 1][matrix.length - 1];

    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; i != row && j < matrix[i].length; j++) {
        if (j != column) {
          submatrix[i < row ? i : i - 1][j < column ? j : j - 1] = matrix[i][j];
        }
      }
    }
    return submatrix;
  }

  private LocalDate convertTimestampToLocalDate(Timestamp timestamp) {
    return timestamp.toLocalDateTime().toLocalDate();
  }

  private double convertDateToNumeric(LocalDate localDate) {
    return (double) -(ChronoUnit.DAYS.between(REFERENCE_DATE, localDate));
  }

}
