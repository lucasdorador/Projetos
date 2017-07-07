package metatdp.com.br.metatdp2017.ConexaoWebService;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;

import org.json.JSONException;
import org.json.JSONObject;

import java.net.URLEncoder;
import java.util.ArrayList;

import metatdp.com.br.metatdp2017.Constants.Url_Conexao;

/**
 * Created by Lucas on 29/05/2017.
 */

public class ComunicaWebService {

    public static ArrayList<String> getCliente(String url, String empresa, String pedido) throws Exception {

        JSONObject jsonObject = new JSONObject();

        try {
            jsonObject.put("Pedv_Empresa", empresa);
            jsonObject.put("Pedv_Numero", pedido);
        } catch (JSONException e) {
            e.printStackTrace();
        }

        // Array de String que recebe o JSON do Web Service
//        String thePath = Url_Conexao.BASE_URL + url;
//        thePath = URLEncoder.encode(thePath, "UTF-8");

//        String[] json = new WebService().get(thePath + url);
        String[] json = new WebService().post(Url_Conexao.BASE_URL + url, jsonObject.toString());

        ArrayList<String> cliente = new ArrayList<String>();

        if (json[0].equals("200")) {

            Gson gson = new Gson();

            JsonParser parser = new JsonParser();

            // Fazendo o parse do JSON para um JsonArray
            JsonArray array = parser.parse(json[1]).getAsJsonArray();

            for (int i = 0; i < array.size(); i++) {

                // Adicionando na lista a posicao atual do JsonArray
                cliente.add(gson.fromJson(array.get(i), String.class));
            }
            // retornado a lista que consumiu do WS
            return cliente;

        } else {
            throw new Exception(json[1]);
        }

    }
}
