package metatdp.com.br.metatdp2017.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.FloatingActionButton;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import metatdp.com.br.metatdp2017.Classes.ConsultasServidor;
import metatdp.com.br.metatdp2017.Classes.PedidoCabecalho;
import metatdp.com.br.metatdp2017.Classes.PedidoItens;
import metatdp.com.br.metatdp2017.R;

/**
 * Created by Lucas on 04/06/2017.
 */

public class FragmentVisualizaItens extends Fragment {

    private ListView listItens;
    private ArrayAdapter adapter;
    private FloatingActionButton btnVoltar;
    private List<PedidoItens> listaItens;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_visualizaitens, container, false);

        btnVoltar = (FloatingActionButton) view.findViewById(R.id.btnvoltar_Itens);
        listItens = (ListView) view.findViewById(R.id.listaItens);
        adapter = new ArrayAdapter(getActivity(), android.R.layout.simple_list_item_1);
        listaItens = (List<PedidoItens>) getArguments().getSerializable("Itens");

        adapter.clear();

        for (int i=0; i < listaItens.size(); i++){
            setArrayAdapterItensPedido(listaItens.get(i), i+1);
        }

        listItens.setAdapter(adapter);
        listItens.setDivider(null);

        btnVoltar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                btnClickVoltar();
            }
        });

        return view;
    }

    private void setArrayAdapterItensPedido(PedidoItens itens, int posicao) {
        List<String> valores = new ArrayList<String>();
        DecimalFormat formatacao = new DecimalFormat("00");
        valores.add("Pos.: " + formatacao.format(posicao));
        valores.add("Produto: " + itens.getProduto());
        valores.add("Qtde: " + formatacao.format(itens.getQtde()) + " - " +
                    "Unit: " + formatacao.format(itens.getUnitario()) + " - " +
                    "Total: " + formatacao.format(itens.getTotal()));

        adapter.add(valores);
    }

    private void btnClickVoltar(){
        ConsultasServidor consultasServidor = new ConsultasServidor();
        consultasServidor.ConsultaPedidoJSON(FragmentVisualizaItens.this);
    }
}
