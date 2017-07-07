package metatdp.com.br.metatdp2017.Classes;

import android.app.Activity;
import android.os.Bundle;
import android.support.design.widget.Snackbar;
import android.support.v4.app.Fragment;

import com.google.gson.Gson;
import com.loopj.android.http.TextHttpResponseHandler;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import cz.msebera.android.httpclient.Header;
import metatdp.com.br.metatdp2017.Async.AsyncHttpServidor;
import metatdp.com.br.metatdp2017.Constants.Constantes;
import metatdp.com.br.metatdp2017.R;
import metatdp.com.br.metatdp2017.Utilitario.Util;
import metatdp.com.br.metatdp2017.fragments.FragmentVisualizaPedido;

/**
 * Created by Lucas on 27/06/2017.
 */

public class ConsultasServidor {

    public void ConsultaPedidoJSON(final Fragment fragment) {
        final JSONObject jsonObject = new JSONObject();

        try {
            jsonObject.put("Pedv_Empresa", Constantes.vgsEmpresa);
            jsonObject.put("Pedv_Numero", Constantes.vgsPedido);
        } catch (JSONException e) {
            e.printStackTrace();
        }

        AsyncHttpServidor.get("Service/fncRetornaDadosPedido/" + jsonObject.toString(), null, new TextHttpResponseHandler() {
            @Override
            public void onFailure(int statusCode, Header[] headers, String responseString, Throwable throwable) {
                Util.SimpleToast(fragment.getActivity(), "Não foi possível localizar o servidor! - " + throwable.getMessage());
            }

            @Override
            public void onSuccess(int statusCode, Header[] headers, String responseString) {
                Gson gson = new Gson();
                JSONObject json = null;
                JSONArray jsonArray = new JSONArray();
                JSONArray jsonArray2 = new JSONArray();
                String s = "";
                try {
                    json = new JSONObject(responseString);
                    jsonArray = json.getJSONArray("result");
                    jsonArray2 = jsonArray.getJSONArray(0);
                    s = jsonArray2.getString(0);
                } catch (JSONException e) {
                    e.printStackTrace();
                }

                PedidoCabecalho pedidoCabecalho = gson.fromJson(s, PedidoCabecalho.class);

                if (pedidoCabecalho.getPedido() != null && !pedidoCabecalho.getPedido().equals("")) {
                    Bundle bundle = new Bundle();
                    bundle.putSerializable("Cabecalho", pedidoCabecalho);
                    Fragment fragment_Pedido = new FragmentVisualizaPedido();
                    fragment_Pedido.setArguments(bundle);
                    fragment.getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.nav_contentframe, fragment_Pedido, "TAG").commit();
                } else {
                    Snackbar.make(fragment.getView(), "Pedido pesquisado não foi localizado.", Snackbar.LENGTH_LONG)
                                                   .setActionTextColor(0xffff0000).setAction("Action", null).show();
                }
            }
        });
    }

}
