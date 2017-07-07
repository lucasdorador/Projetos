package metatdp.com.br.metatdp2017.Classes;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Programacao on 23/06/2017.
 */

public class ListaVencimentos {

    List<PedidoVencs> vencsList = new ArrayList<PedidoVencs>();

    public void popularVencs(PedidoVencs pedidoVencs) {
        vencsList.add(pedidoVencs);
    }

    public int fncRetornaTotalVencs() {

        return vencsList.size();
    }

    public List<PedidoVencs> fncRetornaLista_Vencs(){

        return vencsList;
    }
}