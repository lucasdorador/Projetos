package metatdp.com.br.metatdp2017.Classes;

import java.io.Serializable;

/**
 * Created by Lucas on 05/06/2017.
 */

public class PedidoItens implements Serializable{
    private String Produto;
    private Double Qtde;
    private Double Unitario;
    private Double Total;

    public String getProduto() {
        return Produto;
    }

    public void setProduto(String produto) {
        Produto = produto;
    }

    public Double getQtde() {
        return Qtde;
    }

    public void setQtde(Double qtde) {
        Qtde = qtde;
    }

    public Double getUnitario() {
        return Unitario;
    }

    public void setUnitario(Double unitario) {
        Unitario = unitario;
    }

    public Double getTotal() {
        return Total;
    }

    public void setTotal(Double total) {
        Total = total;
    }
}
