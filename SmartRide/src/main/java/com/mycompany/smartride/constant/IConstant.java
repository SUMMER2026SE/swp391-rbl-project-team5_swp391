package com.mycompany.smartride.constant;
public interface IConstant {
    String GOOGLE_CLIENT_ID = System.getenv("GOOGLE_CLIENT_ID") != null ? System.getenv("GOOGLE_CLIENT_ID") : "YOUR_GOOGLE_CLIENT_ID";

    String GOOGLE_CLIENT_SECRET = System.getenv("GOOGLE_CLIENT_SECRET") != null ? System.getenv("GOOGLE_CLIENT_SECRET") : "YOUR_GOOGLE_CLIENT_SECRET";

    String GOOGLE_REDIRECT_URI = "http://localhost:8080/SmartRide/login-google";

    String GOOGLE_GRANT_TYPE = "authorization_code";

    String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";

    String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
}
