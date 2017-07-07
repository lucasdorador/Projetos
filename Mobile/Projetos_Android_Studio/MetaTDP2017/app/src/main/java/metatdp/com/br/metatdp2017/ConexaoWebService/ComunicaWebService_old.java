package metatdp.com.br.metatdp2017.ConexaoWebService;

import android.app.Activity;
import android.content.IntentSender;
import android.widget.Toast;

import com.loopj.android.http.TextHttpResponseHandler;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import cz.msebera.android.httpclient.Header;
import metatdp.com.br.metatdp2017.Async.AsyncHttpServidor;
import metatdp.com.br.metatdp2017.Constants.Url_Conexao;
import metatdp.com.br.metatdp2017.Utilitario.Util;

/**
 * Created by Lucas on 23/05/2017.
 */

public class ComunicaWebService_old {
    static String resultadoServidor = "";
    static Boolean result = false;

    public static void pcdConfigIP(String ip, String porta) {
        Url_Conexao.BASE_URL = "http://" + ip + ":" + porta + "/datasnap/rest/";
    }

    public static Boolean pcdTesteSimplesServidor(final Activity activity) {
        AsyncHttpServidor.getSemParametro("Service/Ping", new TextHttpResponseHandler() {
            @Override
            public void onFailure(int statusCode, Header[] headers, String responseString, Throwable throwable) {
                Util.SimpleToast(activity, "Não foi possível conectar, verifique o servidor!");
                result = false;
            }

            @Override
            public void onSuccess(int statusCode, Header[] headers, String responseString) {
                result = true;
                JSONObject jsonObject = null;

                try {
                    jsonObject = new JSONObject(responseString);
                    resultadoServidor = jsonObject.getString("result");
                } catch (JSONException e) {
                    e.printStackTrace();
                }

                if (resultadoServidor == "") {
                    Util.SimpleToast(activity, "Não foi possível conectar, verifique o IP e a Porta!");
                    result = false;
                }
            }
        });

        return result;
    }

    public static Boolean pcdTestaServidor(final Activity activity) {
        AsyncHttpServidor.get("Service/Ping", null, new TextHttpResponseHandler() {
            @Override
            public void onFailure(int statusCode, Header[] headers, String responseString, Throwable throwable) {
                Util.SimpleToast(activity, "Não foi possível conectar, verifique o servidor! - " + throwable.getMessage());
                result = false;
            }

            @Override
            public void onSuccess(int statusCode, Header[] headers, String responseString) {
                result = true;
                JSONObject jsonObject = null;

                try {
                    jsonObject = new JSONObject(responseString);
                    resultadoServidor = jsonObject.getString("result");
                } catch (JSONException e) {
                    e.printStackTrace();
                }

                if (resultadoServidor == "") {
                    Util.SimpleToast(activity, "Não foi possível conectar, verifique o IP e a Porta!");
                    result = false;
                } else {
                    Util.SimpleToast(activity, "Conexão realizada com sucesso!");
                    result = true;
                }

            }
        });

        return result;
    }
}
