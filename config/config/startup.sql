
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS shopmanagement;
CREATE SCHEMA shopmanagement;
USE shopmanagement;

CREATE TABLE customers (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  phone VARCHAR(50)
);

CREATE TABLE employees (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  phone VARCHAR(50),
  'address' VARCHAR(50),
  'type' VARCHAR(50)
);

CREATE TABLE payments (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  phone VARCHAR(50),
  'address' VARCHAR(50),
  'type' VARCHAR(50)
);

CREATE TABLE product_category (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  phone VARCHAR(50),
  'address' VARCHAR(50),
  'type' VARCHAR(50)
);

CREATE TABLE products (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  phone VARCHAR(50),
  'address' VARCHAR(50),
  'type' VARCHAR(50)
);

CREATE TABLE order_detials (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  phone VARCHAR(50),
  'address' VARCHAR(50),
  'type' VARCHAR(50)
);

CREATE TABLE orders (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  phone VARCHAR(50),
  'address' VARCHAR(50),
  'type' VARCHAR(50)
);