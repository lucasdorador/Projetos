package lucas.cardapioonline.Classes;

import android.app.Activity;
import android.widget.Toast;

public class Util {

    public static void MensagemRapida(Activity activity, String mensagem) {
        Toast.makeText(activity, mensagem, Toast.LENGTH_LONG).show();
    }
}
