package metatdp.com.br.metatdp2017.Classes;

import java.io.Serializable;

/**
 * Created by Lucas on 08/06/2017.
 */

public class PedidoVencs implements Serializable{
    private String DataVenc;
    private String Docto;
    private String Status;
    private String Cobranca;

    public String getDataVenc() {
        return DataVenc;
    }

    public void setDataVenc(String dataVenc) {
        DataVenc = dataVenc;
    }

    public String getDocto() {
        return Docto;
    }

    public void setDocto(String docto) {
        Docto = docto;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String status) {
        Status = status;
    }

    public String getCobranca() {
        return Cobranca;
    }

    public void setCobranca(String cobranca) {
        Cobranca = cobranca;
    }
}
