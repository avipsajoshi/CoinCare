package com.coincare.helper;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class HashPassword {
  private static byte[] hash_salt =new byte[16];
  public static void generateSalt() throws NoSuchAlgorithmException {
    SecureRandom sr = new SecureRandom();
    byte[] salt = new byte[16];
    sr.nextBytes(salt);
    hash_salt = salt;
  }
  
  public static String hashUserPassword(String password) throws Exception {
//    byte[] generated_salt = HashPassword.generateSalt();
    int iterations = 65536;
    int keyLength = 128;
    PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), hash_salt, iterations, keyLength);
    SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
    byte[] hashedPassword = skf.generateSecret(spec).getEncoded();
    return Base64.getEncoder().encodeToString(hashedPassword);
  }

  public static boolean verifyPassword(String password, String storedPassword) throws Exception {
    String hashedPassword = hashUserPassword(password);
    return hashedPassword.equals(storedPassword);
  }
}
