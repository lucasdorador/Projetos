package lucas.cardapioonline.Helper;

import android.content.Context;
import android.content.SharedPreferences;

public class Preferencias {

    private Context context;
    private SharedPreferences preferences;
    private String NOME_ARQUIVO = "app.preferencias_cardapio";
    private int MODE = 0;
    private SharedPreferences.Editor editor;

    private final String EMAIL_USUARIO_LOGADO = "email_usuario_logado";
    private final String SENHA_USUARIO_LOGADO = "senha_usuario_logado";

    public Preferencias(Context contextoParametros){
        context = contextoParametros;
        preferences = context.getSharedPreferences(NOME_ARQUIVO, MODE);
        editor = preferences.edit();
    }

    public void salvarUsuarioPreferencias(String email, String senha){
        editor.putString(EMAIL_USUARIO_LOGADO, email);
        editor.putString(SENHA_USUARIO_LOGADO, senha);
        editor.commit();
    }

    public String getEMAIL_USUARIO_LOGADO(){
        return preferences.getString(EMAIL_USUARIO_LOGADO, null);
    }

    public String getSENHA_USUARIO_LOGADO(){
        return preferences.getString(SENHA_USUARIO_LOGADO, null);
    }
}
