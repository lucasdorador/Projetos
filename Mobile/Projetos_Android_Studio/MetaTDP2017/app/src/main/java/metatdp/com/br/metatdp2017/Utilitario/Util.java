package metatdp.com.br.metatdp2017.Utilitario;

import android.app.Activity;
import android.content.DialogInterface;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.Toast;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import metatdp.com.br.metatdp2017.R;

/**
 * Created by Lucas on 04/04/2017.
 */

public class Util {
    public static void SimpleToast(Activity activity, String psTexto) {
        Toast.makeText(activity, psTexto, Toast.LENGTH_SHORT).show();
    }

    public static void MensageINFO(final Activity activity, String psTitulo, String psTexto, TipoMsg psTipo) {
        int tema = 0, icone = 0;

        switch (psTipo) {
            case INFO:
                tema = R.style.AppTheme_Dark_Dialog_Info;
                icone = R.mipmap.info64;
                break;
        }
        final AlertDialog alertdialog = new AlertDialog.Builder(activity, tema).create();
        alertdialog.setTitle(psTitulo);
        alertdialog.setMessage(psTexto);
        alertdialog.setIcon(icone);

        alertdialog.setButton(DialogInterface.BUTTON_POSITIVE, "Ok", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                alertdialog.dismiss();
            }
        });

        WindowManager.LayoutParams params = new WindowManager.LayoutParams();
        params.copyFrom(alertdialog.getWindow().getAttributes());
        params.width = WindowManager.LayoutParams.MATCH_PARENT;
        params.height = WindowManager.LayoutParams.WRAP_CONTENT;
        alertdialog.show();
        alertdialog.getWindow().setAttributes(params);
    }

    public static String formataData(Date pdData) {
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        return dateFormat.format(pdData);
    }

    public static void FechaTeclado_Activity(Activity activity) {
        activity.getWindow().setSoftInputMode(
                WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
    }
}
