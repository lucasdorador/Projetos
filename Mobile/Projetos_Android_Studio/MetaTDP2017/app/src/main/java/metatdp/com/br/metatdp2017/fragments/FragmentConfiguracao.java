package metatdp.com.br.metatdp2017.fragments;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;

import metatdp.com.br.metatdp2017.ConexaoWebService.ComunicaWebService_old;
import metatdp.com.br.metatdp2017.Constants.Url_Conexao;
import metatdp.com.br.metatdp2017.R;
import metatdp.com.br.metatdp2017.Utilitario.Util;

/**
 * Created by Lucas on 18/05/2017.
 */

public class FragmentConfiguracao extends Fragment {

    private EditText edtIP;
    private EditText edtPORTA;
    private Button btnConfiguracao;
    private Button btnTestaConfig;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setHasOptionsMenu(true);
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.Home:
                Util.SimpleToast(getActivity(), "Home");
                return false;
        }

        return false;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        final View view = inflater.inflate(R.layout.fragment_configuracao, container, false);
        edtIP = (EditText) view.findViewById(R.id.edtIP);
        edtPORTA = (EditText) view.findViewById(R.id.edtPORTA);
        btnConfiguracao = (Button) view.findViewById(R.id.btnConfigIP);
        btnTestaConfig = (Button) view.findViewById(R.id.btnTestaConfig);

        btnConfiguracao.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                InputMethodManager imm = (InputMethodManager) getActivity().getSystemService(getActivity().INPUT_METHOD_SERVICE);
                imm.hideSoftInputFromWindow(view.getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS);
                if (fncValidaDados(edtIP.getText().toString(), edtPORTA.getText().toString())) {
                    configIP();
                }
            }
        });

        btnTestaConfig.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                InputMethodManager imm = (InputMethodManager) getActivity().getSystemService(getActivity().INPUT_METHOD_SERVICE);
                imm.hideSoftInputFromWindow(view.getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS);
                ComunicaWebService_old.pcdTestaServidor(getActivity());
            }
        });

        if (Url_Conexao.IP_Pref != null && Url_Conexao.Porta_Pref != null) {
            edtIP.setText(Url_Conexao.IP_Pref);
            edtPORTA.setText(Url_Conexao.Porta_Pref);
        }

        return view;
    }

    public void configIP() {
        SharedPreferences.Editor editor = this.getActivity().getSharedPreferences("configIP", Context.MODE_PRIVATE).edit();
        editor.putString("IP", edtIP.getText().toString());
        editor.putString("PORTA", edtPORTA.getText().toString());
        editor.commit();

        ComunicaWebService_old.pcdConfigIP(edtIP.getText().toString(), edtPORTA.getText().toString());
        Util.SimpleToast(this.getActivity(), "Configurações Gravadas com Sucesso!");
    }

    private Boolean fncValidaDados(String IP, String Porta) {
        Boolean vlbResult = true;
        if (IP == null || "".equals(IP)) {
            edtIP.setError("Campo Obrigatório");
            vlbResult = false;
        }

        if (Porta == null || "".equals(Porta)) {
            edtPORTA.setError("Campo Obrigatório");
            vlbResult = false;
        }

        return vlbResult;
    }
}
