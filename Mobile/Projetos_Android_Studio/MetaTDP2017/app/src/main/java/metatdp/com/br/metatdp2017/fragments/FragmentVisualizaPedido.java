package metatdp.com.br.metatdp2017.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;

import com.google.gson.Gson;
import com.loopj.android.http.TextHttpResponseHandler;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import cz.msebera.android.httpclient.Header;
import metatdp.com.br.metatdp2017.Async.AsyncHttpServidor;
import metatdp.com.br.metatdp2017.Classes.ListaItens;
import metatdp.com.br.metatdp2017.Classes.ListaVencimentos;
import metatdp.com.br.metatdp2017.Classes.PedidoCabecalho;
import metatdp.com.br.metatdp2017.Classes.PedidoItens;
import metatdp.com.br.metatdp2017.Classes.PedidoVencs;
import metatdp.com.br.metatdp2017.Constants.Constantes;
import metatdp.com.br.metatdp2017.R;
import metatdp.com.br.metatdp2017.Utilitario.Util;

/**
 * Created by Lucas on 30/05/2017.
 */

public class FragmentVisualizaPedido extends Fragment {

    private ListView listPedido;
    private ArrayAdapter adapter;
    private PedidoCabecalho cabecalho;
    private Button btnVisualizaItens, btnVisualizaVencimentos;
    private FloatingActionButton btnVoltar;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_visualizapedido, container, false);

        listPedido = (ListView) view.findViewById(R.id.listaCabecalho);
        adapter = new ArrayAdapter(getActivity(), android.R.layout.simple_list_item_1);
        cabecalho = (PedidoCabecalho) getArguments().getSerializable("Cabecalho");
        btnVisualizaItens = (Button) view.findViewById(R.id.btnConsultaItens);
        btnVisualizaVencimentos = (Button) view.findViewById(R.id.btnConsultaVencs);
        btnVoltar = (FloatingActionButton) view.findViewById(R.id.btnvoltar_Pedido);
        setArrayAdapterPedidoCabecalho(cabecalho);
        listPedido.setDivider(null);

        btnVisualizaItens.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ConsultaItens_JSON();
            }
        });

        btnVisualizaVencimentos.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ConsultaVencs_JSON();
            }
        });

        btnVoltar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                btnClickVoltar();
            }
        });

        return view;
    }

    public void ConsultaItens_JSON() {
        final JSONObject jsonObject = new JSONObject();

        try {
            jsonObject.put("Pedv_Empresa", Constantes.vgsEmpresa);
            jsonObject.put("Pedv_Numero", Constantes.vgsPedido);
        } catch (JSONException e) {
            e.printStackTrace();
        }

        AsyncHttpServidor.get("Service/fncRetornaItensPedido/" + jsonObject.toString(), null, new TextHttpResponseHandler() {
            @Override
            public void onFailure(int statusCode, Header[] headers, String responseString, Throwable throwable) {
                Util.SimpleToast(getActivity(), "Não foi possível visualizar os Itens!" + throwable.getMessage());
            }

            @Override
            public void onSuccess(int statusCode, Header[] headers, String responseString) {
                Gson gson = new Gson();
                JSONObject jResultServer, jsi = null;
                JSONArray ja_ResultServer, ja_ResultItem = new JSONArray();
                PedidoItens pedidoItens = null;
                String vlsResultArray = "";
                ListaItens itens = new ListaItens();

                try {
                    jResultServer = new JSONObject(responseString); // Converte o retorno do Server em JSON
                    ja_ResultServer = jResultServer.getJSONArray("result"); // Converte o "result" do Server em JSONARRAY
                    jsi = new JSONObject(ja_ResultServer.getString(0));
                    ja_ResultItem = jsi.getJSONArray("Itens");

                    // Laço para popular a classe PedidoItens
                    for (int i = 0; i < ja_ResultItem.length(); i++) {
                        vlsResultArray = ja_ResultItem.getString(i);
                        pedidoItens = gson.fromJson(vlsResultArray, PedidoItens.class);
                        itens.popularItens(pedidoItens);
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }

                Bundle bundle = new Bundle();
                if (!itens.fncRetornaLista().isEmpty()) {
                    bundle.putSerializable("Itens", (Serializable) itens.fncRetornaLista());
                    Fragment fragment = new FragmentVisualizaItens();
                    fragment.setArguments(bundle);
                    getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.nav_contentframe, fragment, "TAG").commit();
                } else {
                    Snackbar.make(getView(), "Pedido não contém itens.", Snackbar.LENGTH_LONG)
                            .setActionTextColor(0xffff0000).setAction("Action", null).show();
                }

            }
        });
    }

    public void ConsultaVencs_JSON() {
        final JSONObject jsonObject = new JSONObject();

        try {
            jsonObject.put("Pedv_Empresa", Constantes.vgsEmpresa);
            jsonObject.put("Pedv_Numero", Constantes.vgsPedido);
        } catch (JSONException e) {
            e.printStackTrace();
        }

        AsyncHttpServidor.get("Service/fncRetornaVencimentoPedido/" + jsonObject.toString(), null, new TextHttpResponseHandler() {
            @Override
            public void onFailure(int statusCode, Header[] headers, String responseString, Throwable throwable) {
                Util.SimpleToast(getActivity(), "Não foi possível visualizar os Vencimentos!" + throwable.getMessage());
            }

            @Override
            public void onSuccess(int statusCode, Header[] headers, String responseString) {
                Gson gson = new Gson();
                JSONObject jResultServer, jsi = null;
                JSONArray ja_ResultServer, ja_ResultVencs = new JSONArray();
                PedidoVencs pedidoVencs = null;
                String vlsResultArray = "";
                ListaVencimentos vencimentos = new ListaVencimentos();

                try {
                    jResultServer = new JSONObject(responseString); // Converte o retorno do Server em JSON
                    ja_ResultServer = jResultServer.getJSONArray("result"); // Converte o "result" do Server em JSONARRAY
                    jsi = new JSONObject(ja_ResultServer.getString(0));
                    ja_ResultVencs = jsi.getJSONArray("Vencimentos");

                    // Laço para popular a classe PedidoVencs
                    for (int i = 0; i < ja_ResultVencs.length(); i++) {
                        vlsResultArray = ja_ResultVencs.getString(i);
                        pedidoVencs = gson.fromJson(vlsResultArray, PedidoVencs.class);
                        vencimentos.popularVencs(pedidoVencs);
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }

                Bundle bundle = new Bundle();
                if (!vencimentos.fncRetornaLista_Vencs().isEmpty()) {
                    bundle.putSerializable("Vencs", (Serializable) vencimentos.fncRetornaLista_Vencs());
                    Fragment fragment = new FragmentVisualizaVencs();
                    fragment.setArguments(bundle);
                    getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.nav_contentframe, fragment, "TAG").commit();
                } else {
                    Snackbar.make(getView(), "Pedido não contém vencimentos.", Snackbar.LENGTH_LONG)
                            .setActionTextColor(0xffff0000).setAction("Action", null).show();
                }
            }
        });
    }


    private void setArrayAdapterPedidoCabecalho(PedidoCabecalho cabecalho) {
        List<String> valores = new ArrayList<String>();
        valores.add("Empresa: " + cabecalho.getEmpresa());
        valores.add("Pedido: " + cabecalho.getPedido());
        valores.add("Cliente: " + cabecalho.getCliente());
        valores.add("Data do Pedido: " + cabecalho.getDataPedido());
        valores.add("Negociação: " + cabecalho.getNegociacao());
        valores.add("Status: " + cabecalho.getStatus());

        adapter.clear();
        adapter.addAll(valores);
        listPedido.setAdapter(adapter);
    }

    private void btnClickVoltar() {
        Fragment fragment_consulta = new FragmentConsulta();
        getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.nav_contentframe, fragment_consulta, "TAG").commit();
    }

}
