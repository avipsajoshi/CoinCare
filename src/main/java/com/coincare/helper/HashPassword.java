package com.coincare.helper;

import java.security.NoSuchAlgorithmException;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.security.SecureRandom;
import java.util.Base64;

public class HashPassword {
  public static byte[] generateSalt() throws NoSuchAlgorithmException {
    SecureRandom sr = new SecureRandom();
    byte[] salt = new byte[16];
    sr.nextBytes(salt);
    return salt;
  }

  public static String hashPassword(String password) throws Exception {
    byte[] generated_salt = HashPassword.generateSalt();
    int iterations = 65536;
    int keyLength = 128;
    PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), generated_salt, iterations, keyLength);
    SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
    byte[] hashedPassword = skf.generateSecret(spec).getEncoded();
    return Base64.getEncoder().encodeToString(hashedPassword);
  }

  public static boolean verifyPassword(String password, String storedHash) throws Exception {
    String hashedPassword = hashPassword(password);
    return hashedPassword.equals(storedHash);
  }

}
