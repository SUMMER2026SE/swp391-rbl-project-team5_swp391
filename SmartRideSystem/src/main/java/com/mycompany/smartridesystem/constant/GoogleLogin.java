
package com.mycompany.smartridesystem.constant;

import com.mycompany.smartridesystem.dto.Account;
import java.io.IOException;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.json.Json;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import org.json.JSONObject;

public class GoogleLogin {
    public static String getToken(String code) throws ClientProtocolException, IOException {

        String response = Request.Post(IConstant.GOOGLE_LINK_GET_TOKEN)

                .bodyForm(
                        Form.form().add("client_id", IConstant.GOOGLE_CLIENT_ID)

                        .add("client_secret", IConstant.GOOGLE_CLIENT_SECRET)

                        .add("redirect_uri", IConstant.GOOGLE_REDIRECT_URI)

                        .add("code", code)

                        .add("grant_type", IConstant.GOOGLE_GRANT_TYPE)

                        .build()

                )

                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);

        return jobj.get("access_token").getAsString();

    }
    public static String getUserInfo(final String accessToken) throws ClientProtocolException, IOException {

        String link = IConstant.GOOGLE_LINK_GET_USER_INFO + accessToken;

        String response = Request.Get(link).execute().returnContent().asString();
        

        return response;

    }
    
    public static String getEmail(final String accessToken) throws IOException {
        String jsonInfo = getUserInfo(accessToken);
        JSONObject jsonObject = new JSONObject(jsonInfo);
        return jsonObject.getString("email");
    }
    








}

