package metatdp.com.br.metatdp2017.Classes;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Programacao on 23/06/2017.
 */

public class ListaItens {

    List<PedidoItens> itensList = new ArrayList<PedidoItens>();

    public void popularItens(PedidoItens pedidoItens) {
        itensList.add(pedidoItens);
    }

    public int fncRetornaTotalItens() {

        return itensList.size();
    }

    public List<PedidoItens> fncRetornaLista(){

        return itensList;
    }
}