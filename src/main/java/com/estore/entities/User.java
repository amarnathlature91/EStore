package com.estore.entities;

import javax.persistence.*;

@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userId;
    private String userName;
    private String email;
    private String password;
    private String contact;
    private String profilePic;
    @Column(length = 1500)
    private String address;

    private String role;


    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getProfilePic() {
        return profilePic;
    }

    public void setProfilePic(String profilePic) {
        this.profilePic = profilePic;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public User(String userName, String email, String password, String contact, String profilePic, String address, String role) {
        this.userName = userName;
        this.email = email;
        this.password = password;
        this.contact = contact;
        this.profilePic = profilePic;
        this.address = address;
        this.role = role;
    }

    public User(int userId, String userName, String email, String password, String contact, String profilePic, String address, String role) {
        this.userId = userId;
        this.userName = userName;
        this.email = email;
        this.password = password;
        this.contact = contact;
        this.profilePic = profilePic;
        this.address = address;
        this.role = role;
    }

    public User() {
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", userName='" + userName + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", contact='" + contact + '\'' +
                ", profilePic='" + profilePic + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}
