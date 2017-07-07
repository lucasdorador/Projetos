package metatdp.com.br.metatdp2017.ConexaoWebService;

import cz.msebera.android.httpclient.impl.client.DefaultHttpClient;
import cz.msebera.android.httpclient.params.BasicHttpParams;
import cz.msebera.android.httpclient.params.HttpConnectionParams;
import cz.msebera.android.httpclient.params.HttpParams;

/**
 * Created by Lucas on 29/05/2017.
 */

public class HttpClientSingleton {
    private static final int JSON_CONNECTION_TIMEOUT = 3000;
    private static final int JSON_SOCKET_TIMEOUT = 5000;

    private static HttpClientSingleton instance;
    private HttpParams httpParameters ;
    private DefaultHttpClient httpclient;

    private void setTimeOut(HttpParams params){
        HttpConnectionParams.setConnectionTimeout(params, JSON_CONNECTION_TIMEOUT);
        HttpConnectionParams.setSoTimeout(params, JSON_SOCKET_TIMEOUT);
    }


    private HttpClientSingleton() {
        httpParameters = new BasicHttpParams();
        setTimeOut(httpParameters);
        httpclient = new DefaultHttpClient(httpParameters);
    }

    public static DefaultHttpClient getHttpClientInstace(){
        if(instance==null)
            instance = new HttpClientSingleton();
        return instance.httpclient;
    }
}
