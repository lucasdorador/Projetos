package metatdp.com.br.metatdp2017.Async;

import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.AsyncHttpResponseHandler;
import com.loopj.android.http.RequestParams;

import metatdp.com.br.metatdp2017.Constants.Url_Conexao;

/**
 * Created by Lucas on 15/05/2017.
 */

public class AsyncHttpServidor {

    private static AsyncHttpClient client = new AsyncHttpClient();

    public static void getSemParametro(String url, AsyncHttpResponseHandler responseHandler) {
        client.get(getAbsoluteUrl(url), responseHandler);
    }

    public static void get(String url, RequestParams params, AsyncHttpResponseHandler responseHandler) {
        client.get(getAbsoluteUrl(url), params, responseHandler);
    }

    public static void post(String url, RequestParams params, AsyncHttpResponseHandler responseHandler) {
        client.post(getAbsoluteUrl(url), params, responseHandler);
    }

    private static String getAbsoluteUrl(String relativeUrl) {
        client.setConnectTimeout(3000);
        return Url_Conexao.BASE_URL + relativeUrl;
    }
}
