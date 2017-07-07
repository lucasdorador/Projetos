package metatdp.com.br.metatdp2017.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.FloatingActionButton;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import metatdp.com.br.metatdp2017.Classes.ConsultasServidor;
import metatdp.com.br.metatdp2017.Classes.PedidoItens;
import metatdp.com.br.metatdp2017.Classes.PedidoVencs;
import metatdp.com.br.metatdp2017.R;

/**
 * Created by Lucas on 08/06/2017.
 */

public class FragmentVisualizaVencs extends Fragment {

    private ListView listVencs;
    private ArrayAdapter adapter;
    private List<PedidoVencs> listaVencs;
    private FloatingActionButton btnVoltar;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_visualizavencs, container, false);

        btnVoltar = (FloatingActionButton) view.findViewById(R.id.btnvoltar_Vencs);
        listVencs = (ListView) view.findViewById(R.id.listaVencs);
        adapter = new ArrayAdapter(getActivity(), android.R.layout.simple_list_item_1);

        listaVencs = (List<PedidoVencs>) getArguments().getSerializable("Vencs");

        adapter.clear();

        for (int i=0; i < listaVencs.size(); i++){
            setArrayAdapterVencimentosPedido(listaVencs.get(i), i + 1);

        }

        listVencs.setAdapter(adapter);
        listVencs.setDivider(null);

        btnVoltar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                btnClickVoltar();
            }
        });


        return view;
    }

    private void setArrayAdapterVencimentosPedido(PedidoVencs pedidoVencs, int posicao) {
        List<String> valores = new ArrayList<String>();
        DecimalFormat formatacao = new DecimalFormat("00");
        valores.add("Pos.: " + formatacao.format(posicao));
        valores.add("Vencimento: " + pedidoVencs.getDataVenc().toString() + " - " +
                    "Cobrança: " + pedidoVencs.getCobranca().toString());
        valores.add("Docto.: " + pedidoVencs.getDocto().toString() + " - " +
                    "Status: " + pedidoVencs.getStatus().toString());

        adapter.add(valores);
    }

    private void btnClickVoltar(){
        ConsultasServidor consultasServidor = new ConsultasServidor();
        consultasServidor.ConsultaPedidoJSON(FragmentVisualizaVencs.this);
    }
}
