package metatdp.com.br.metatdp2017.Classes;

import java.io.Serializable;

/**
 * Created by Lucas on 29/05/2017.
 */

public class PedidoCabecalho implements Serializable{

    private String Empresa;
    private String Pedido;
    private String Cliente;
    private String DataPedido;
    private String Negociacao;
    private String Status;

    public String getEmpresa() {
        return Empresa;
    }

    public void setEmpresa(String empresa) {
        Empresa = empresa;
    }

    public String getPedido() {
        return Pedido;
    }

    public void setPedido(String pedido) {
        Pedido = pedido;
    }

    public String getCliente() {
        return Cliente;
    }

    public void setCliente(String cliente) {
        Cliente = cliente;
    }

    public String getDataPedido() {
        return DataPedido;
    }

    public void setDataPedido(String dataPedido) {
        DataPedido = dataPedido;
    }

    public String getNegociacao() {
        return Negociacao;
    }

    public void setNegociacao(String negociacao) {
        Negociacao = negociacao;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String status) {
        Status = status;
    }
}
