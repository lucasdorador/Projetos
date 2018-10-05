package lucas.cardapioonline.Classes;

public class Cardapio_Itens {

    //Dados do Cardápio
    private String Grupo;
    private String KeyProduto;
    private String Produto;
    private String ComplementoProduto;
    private String ValorMeia;
    private String ValorInteira;

    public String getKeyProduto() {
        return KeyProduto;
    }

    public void setKeyProduto(String keyProduto) {
        KeyProduto = keyProduto;
    }

    public String getComplementoProduto() {
        return ComplementoProduto;
    }

    public void setComplementoProduto(String complementoProduto) {
        ComplementoProduto = complementoProduto;
    }

    public String getGrupo() {
        return Grupo;
    }

    public void setGrupo(String grupo) {
        Grupo = grupo;
    }

    public String getProduto() {
        return Produto;
    }

    public void setProduto(String produto) {
        Produto = produto;
    }

    public String getValorMeia() {
        return ValorMeia;
    }

    public void setValorMeia(String valorMeia) {
        ValorMeia = valorMeia;
    }

    public String getValorInteira() {
        return ValorInteira;
    }

    public void setValorInteira(String valorInteira) {
        ValorInteira = valorInteira;
    }

}
