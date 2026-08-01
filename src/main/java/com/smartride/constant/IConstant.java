package com.smartride.constant;

public interface IConstant {
    String GOOGLE_CLIENT_ID = System.getenv().getOrDefault("GOOGLE_CLIENT_ID", "YOUR_GOOGLE_CLIENT_ID");

    String GOOGLE_CLIENT_SECRET = System.getenv().getOrDefault("GOOGLE_CLIENT_SECRET", "YOUR_GOOGLE_CLIENT_SECRET");

    String GOOGLE_REDIRECT_URI = "http://localhost:8080/MotorcyleHiringProject/login-google";

    String GOOGLE_GRANT_TYPE = "authorization_code";

    String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";

    String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";

    String SUPABASE_URL = "https://zfvgigfjmbtgwgirdify.supabase.co";
    String SUPABASE_ANON_KEY = System.getenv().getOrDefault("SUPABASE_ANON_KEY", "YOUR_SUPABASE_ANON_KEY");
    String SUPABASE_SERVICE_ROLE_KEY = System.getenv().getOrDefault("SUPABASE_SERVICE_ROLE_KEY", "YOUR_SUPABASE_SERVICE_ROLE_KEY");
}
