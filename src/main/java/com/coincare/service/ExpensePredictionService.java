package com.coincare.service;

import com.coincare.entities.Expense;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;

public class ExpensePredictionService {

  // Reference date for numeric conversion of dates
  private static final LocalDate REFERENCE_DATE = LocalDate.now();

  private double[] beta; // Coefficients for the regression model

  // Method to train the model with historical data
  public void train(List<Expense> historicalData) {
    // Step 1: Prepare the data
    int n = historicalData.size();
    double[][] X = new double[n][3]; // Assuming 3 features: date, category, amount
    double[] y = new double[n];

    for (int i = 0; i < n; i++) {
      Expense data = historicalData.get(i);
      X[i][0] = convertDateToNumeric(convertTimestampToLocalDate(data.getExpenseDate()));
      X[i][1] = convertCategoryToNumeric(data.getCategory().getCategoryTitle());
      X[i][2] = data.getExpenseAmount();
      y[i] = data.getExpenseAmount(); // Target is the expense amount itself
    }

    // Step 2: Calculate β = (X^T * X)^(-1) * X^T * y
    double[][] X_T = transpose(X);
    double[][] X_T_X = multiplyMatrices(X_T, X);
    double[][] inverse_X_T_X = invertMatrix(X_T_X);
    double[][] X_T_y = multiplyMatrices(X_T, convertVectorToMatrix(y));

    double[] beta = multiplyMatrixAndVector(inverse_X_T_X, convertMatrixToVector(X_T_y));
    this.beta = beta; // Store the coefficients for prediction
  }

  // Method to predict expenses
  public double predictExpense(List<LocalDate> dates, List<String> categories, List<Double> amounts, String newCategory, LocalDate newDate) {
    // Convert dates to numeric values
    double[] numericDates = convertDatesToNumeric(dates);
    // Convert categories to numeric values
    double[] numericCategories = convertCategoriesToNumeric(categories);

    // Prepare matrix X and vector y
    double[][] X = prepareMatrixX(numericDates, numericCategories);
    double[] y = amounts.stream().mapToDouble(Double::doubleValue).toArray();

    // Calculate regression coefficients
    double[] coefficients = calculateRegressionCoefficients(X, y);

    // Convert new date and category to numeric values
    double newNumericDate = ChronoUnit.DAYS.between(REFERENCE_DATE, newDate);
    double newNumericCategory = convertCategoryToNumeric(newCategory);

    // Predict expense
    return coefficients[0] + coefficients[1] * newNumericCategory + coefficients[2] * newNumericDate;
  }

  // Convert a list of dates to numeric values
  private double[] convertDatesToNumeric(List<LocalDate> dates) {
    return dates.stream().mapToDouble(date -> ChronoUnit.DAYS.between(REFERENCE_DATE, date)).toArray();
  }

  // Convert a list of categories to numeric values using a HashMap
  private double[] convertCategoriesToNumeric(List<String> categories) {
    Map<String, Integer> categoryMap = new HashMap<>();
    int counter = 1;
    for (String category : categories) {
      categoryMap.putIfAbsent(category, counter++);
    }
    return categories.stream().mapToDouble(categoryMap::get).toArray();
  }

  // Convert a single category to numeric value
  private double convertCategoryToNumeric(String category) {
    Map<String, Integer> categoryMap = new HashMap<>();
    // Populate map based on existing categories
    // Example:
    categoryMap.put("Food", 1);
    categoryMap.put("Transport", 2);
    categoryMap.put("Entertainment", 3);
    // ... add other categories

    return categoryMap.getOrDefault(category, 0);
  }

  // Prepare matrix X with an intercept column
  private double[][] prepareMatrixX(double[] dates, double[] categories) {
    int n = dates.length;
    double[][] X = new double[n][3];
    for (int i = 0; i < n; i++) {
      X[i][0] = 1; // Intercept term
      X[i][1] = categories[i];
      X[i][2] = dates[i];
    }
    return X;
  }

  // Calculate regression coefficients using the formula: β = (X^T * X)^(-1) * X^T * y
  private double[] calculateRegressionCoefficients(double[][] X, double[] y) {
    // Transpose X
    double[][] Xt = transpose(X);
    // Xt * X
    double[][] XtX = multiplyMatrices(Xt, X);
    // Inverse of XtX
    double[][] XtX_inv = invertMatrix(XtX);
    // Xt * y
    double[] Xty = multiplyMatrixAndVector(Xt, y);
    // Coefficients β = XtX_inv * Xty
    return multiplyMatrixAndVector(XtX_inv, Xty);
  }

  private double[][] transpose(double[][] matrix) {
    int rows = matrix.length;
    int cols = matrix[0].length;
    double[][] transposedMatrix = new double[cols][rows];

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        transposedMatrix[j][i] = matrix[i][j];
      }
    }
    return transposedMatrix;
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
    return result;
  }

  private double[][] invertMatrix(double[][] matrix) {
    int n = matrix.length;
    double[][] augmentedMatrix = new double[n][2 * n];

    // Create an augmented matrix [matrix | I]
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        augmentedMatrix[i][j] = matrix[i][j];
      }
      augmentedMatrix[i][i + n] = 1.0;
    }

    // Perform Gaussian elimination
    for (int i = 0; i < n; i++) {
      // Make the diagonal contain all 1's
      double diagElement = augmentedMatrix[i][i];
      for (int j = 0; j < 2 * n; j++) {
        augmentedMatrix[i][j] /= diagElement;
      }

      // Make the other elements in the column 0
      for (int k = 0; k < n; k++) {
        if (k != i) {
          double factor = augmentedMatrix[k][i];
          for (int j = 0; j < 2 * n; j++) {
            augmentedMatrix[k][j] -= factor * augmentedMatrix[i][j];
          }
        }
      }
    }

    // Extract the inverted matrix
    double[][] invertedMatrix = new double[n][n];
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        invertedMatrix[i][j] = augmentedMatrix[i][j + n];
      }
    }

    return invertedMatrix;
  }

  // Helper methods for matrix/vector operations
  private double[][] convertVectorToMatrix(double[] vector) {
    double[][] matrix = new double[vector.length][1];
    for (int i = 0; i < vector.length; i++) {
      matrix[i][0] = vector[i];
    }
    return matrix;
  }

  private double[] convertMatrixToVector(double[][] matrix) {
    double[] vector = new double[matrix.length];
    for (int i = 0; i < matrix.length; i++) {
      vector[i] = matrix[i][0];
    }
    return vector;
  }

  private LocalDate convertTimestampToLocalDate(Timestamp timestamp) {
    return timestamp.toInstant()
            .atZone(ZoneId.systemDefault())
            .toLocalDate();
  }

  private double convertDateToNumeric(LocalDate localDate) {
    return ChronoUnit.DAYS.between(REFERENCE_DATE, localDate);
  }

}
