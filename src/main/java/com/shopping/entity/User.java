package edu.neu.csye6220.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="User")
public class User {

	private int UserId;
	private String FirstName;
	private String LastName;
	private String Email;
	private String Username;
	private String Password;
	private String Cellphone;
	private int Gender;
	private String Address;
	private String City;
	private String State;
	private String Zipcode;
	private int role;
	
	@Id
	@GenericGenerator(name = "generator", strategy = "uuid.hex") 
	@GeneratedValue(generator = "generator")
	@Column(name="id", nullable =false, length = 32, unique = true)
	public int getUserId() {
		return UserId;
	}
	public void setUserId(int userId) {
		UserId = userId;
	}
	
	@Column(name="FirstName")
	public String getFirstName() {
		return FirstName;
	}
	public void setFirstName(String firstName) {
		FirstName = firstName;
	}
	
	@Column(name="FirstName")
	public String getLastName() {
		return LastName;
	}
	public void setLastName(String lastName) {
		LastName = lastName;
	}
	
	@Column(name="Email")
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	
	@Column(name="Username")
	public String getUsername() {
		return Username;
	}
	public void setUsername(String username) {
		Username = username;
	}
	
	@Column(name="Role")
	public int getRole() {
		return role;
	}
	public void setRole(int role) {
		this.role = role;
	}
	
	@Column(name="Password")
	public String getPassword() {
		return Password;
	}
	public void setPassword(String password) {
		Password = password;
	}
	
	@Column(name="Cellphone")
	public String getCellphone() {
		return Cellphone;
	}
	public void setCellphone(String cellphone) {
		Cellphone = cellphone;
	}
	
	@Column(name="Gender")
	public int getGender() {
		return Gender;
	}
	public void setGender(int gender) {
		Gender = gender;
	}
	
	@Column(name="Adress")
	public String getAddress() {
		return Address;
	}
	public void setAddress(String address) {
		Address = address;
	}
	
	@Column(name="City")
	public String getCity() {
		return City;
	}
	public void setCity(String city) {
		City = city;
	}
	
	@Column(name="State")
	public String getState() {
		return State;
	}
	public void setState(String state) {
		State = state;
	}
	
	@Column(name="Zipcode")
	public String getZipcode() {
		return Zipcode;
	}
	public void setZipcode(String zipcode) {
		Zipcode = zipcode;
	}
	
	
	
}
