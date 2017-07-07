package metatdp.com.br.metatdp2017.fragments;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;

import com.google.gson.Gson;
import com.loopj.android.http.TextHttpResponseHandler;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import cz.msebera.android.httpclient.Header;
import metatdp.com.br.metatdp2017.Async.AsyncHttpServidor;
import metatdp.com.br.metatdp2017.Classes.ConsultasServidor;
import metatdp.com.br.metatdp2017.Classes.PedidoCabecalho;
import metatdp.com.br.metatdp2017.ConexaoWebService.ComunicaWebService;
import metatdp.com.br.metatdp2017.Constants.Constantes;
import metatdp.com.br.metatdp2017.R;
import metatdp.com.br.metatdp2017.Utilitario.Util;


/**
 * Created by Lucas on 18/05/2017.
 */

public class FragmentConsulta extends Fragment {

    private Button btnConsulta;
    private EditText edtempresa, edtPedido;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        final View view = inflater.inflate(R.layout.fragment_consulta, container, false);

        btnConsulta = (Button) view.findViewById(R.id.btnConsulta);
        edtempresa = (EditText) view.findViewById(R.id.edtEmpresa);
        edtPedido = (EditText) view.findViewById(R.id.edtPedido);

        if (Constantes.vgsPedido != "" && Constantes.vgsEmpresa != ""){
            edtempresa.setText(Constantes.vgsEmpresa);
            edtPedido.setText(Constantes.vgsPedido);
        }

        edtempresa.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View v, boolean hasFocus) {
                if (!hasFocus){
                    ((InputMethodManager) getActivity().getSystemService(Context.INPUT_METHOD_SERVICE))
                            .hideSoftInputFromWindow(edtempresa.getWindowToken(), 0);
                }
            }
        });

        edtPedido.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View v, boolean hasFocus) {
                if (!hasFocus){
                    ((InputMethodManager) getActivity().getSystemService(Context.INPUT_METHOD_SERVICE))
                            .hideSoftInputFromWindow(edtPedido.getWindowToken(), 0);
                }
            }
        });

        btnConsulta.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (fncValidaDados(edtempresa.getText().toString(), edtPedido.getText().toString())) {
                    Constantes.vgsEmpresa = edtempresa.getText().toString();
                    Constantes.vgsPedido  = edtPedido.getText().toString();
                    InputMethodManager imm = (InputMethodManager) getActivity().getSystemService(getActivity().INPUT_METHOD_SERVICE);
                    imm.hideSoftInputFromWindow(view.getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS);
                    ConsultasServidor consultasServidor = new ConsultasServidor();
                    consultasServidor.ConsultaPedidoJSON(FragmentConsulta.this);
                }
            }
        });

        return view;
    }

    private void ConsultaPedidoJSON() throws Exception {
        ComunicaWebService.getCliente("Service/fncRetornaDadosPedido/", edtempresa.getText().toString(), edtPedido.getText().toString());
    }

    private Boolean fncValidaDados(String Empresa, String Pedido) {
        Boolean vlbResult = true;
        if (Empresa == null || "".equals(Empresa)) {
            edtempresa.setError("Campo Obrigatório");
            vlbResult = false;
        }

        if (Pedido == null || "".equals(Pedido)) {
            edtPedido.setError("Campo Obrigatório");
            vlbResult = false;
        }

        return vlbResult;
    }
}
