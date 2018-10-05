package lucas.cardapioonline.Activity;

import android.Manifest;
import android.app.AlertDialog;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.ActivityOptionsCompat;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.WindowManager;

import com.beardedhen.androidbootstrap.BootstrapButton;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.List;

import dmax.dialog.SpotsDialog;
import lucas.cardapioonline.Fragments.FragmentCadastro;
import lucas.cardapioonline.Fragments.FragmentConectar;
import lucas.cardapioonline.R;

public class MainActivity extends AppCompatActivity {

    private BootstrapButton btnConectar, btnCadastrar;
    private FirebaseAuth autenticacao;
    private DatabaseReference reference;
    private AlertDialog dialog;
    private int PERMISSAO_REQUEST = 128;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        overridePendingTransition(R.anim.activity_menu_entrada, R.anim.activity_principal_saida);

        permissoes();

        dialog = new SpotsDialog.Builder()
                .setContext(MainActivity.this)
                .setTheme(R.style.LoginCustom)
                .setCancelable(false)
                .build();

        dialog.show();

        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN);

        //getWindow().setBackgroundDrawable(null);

        btnConectar = findViewById(R.id.btnConectar);
        btnCadastrar = findViewById(R.id.btnCadastrar);
        reference = FirebaseDatabase.getInstance().getReference();
        autenticacao = FirebaseAuth.getInstance();

        if (usuarioLogado()) {
            abrirTelaPrincipal();
        } else {
            dialog.dismiss();
            btnConectar.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {

                    FragmentManager fragmentManager = getSupportFragmentManager();
                    FragmentTransaction transaction = fragmentManager.beginTransaction();
                    transaction.setCustomAnimations(R.anim.activity_menu_entrada, R.anim.activity_principal_saida);
                    transaction.replace(R.id.contentframe, new FragmentConectar(), "FragConectar");
                    transaction.addToBackStack(null);
                    transaction.commit();

                    /*getSupportFragmentManager()
                            .beginTransaction()
                            .replace(R.id.contentframe, new FragmentConectar(), "FragConectar")
                            .addToBackStack(null)
                            .commit();*/
                }
            });

            btnCadastrar.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {

                    FragmentManager fragmentManager = getSupportFragmentManager();
                    FragmentTransaction transaction = fragmentManager.beginTransaction();
                    transaction.setCustomAnimations(R.anim.activity_menu_entrada, R.anim.activity_principal_saida);
                    transaction.replace(R.id.contentframe, new FragmentCadastro(), "FragCadastro");
                    transaction.addToBackStack(null);
                    transaction.commit();

                    /*getSupportFragmentManager()
                            .beginTransaction()
                            .replace(R.id.contentframe, new FragmentCadastro(), "FragCadastro")
                            .addToBackStack(null)
                            .commit();*/
                }
            });
        }
    }

    public Boolean usuarioLogado() {
        FirebaseUser user = FirebaseAuth.getInstance().getCurrentUser();
        return (user != null);
    }

    private void abrirTelaPrincipal() {
        String email = autenticacao.getCurrentUser().getEmail().toString();

        reference.child("usuarios").orderByChild("email").equalTo(email.toString()).addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                for (DataSnapshot postSnapshot : dataSnapshot.getChildren()) {
                    String tipoEmailUsuario = postSnapshot.child("tipoUsuario").getValue().toString();

                    if (tipoEmailUsuario.equals("Administrador")) {

                    } else if (tipoEmailUsuario.equals("Comum")) {
                        Intent intent = new Intent(MainActivity.this, PrincipalActivity.class);
                        //startActivity(intent);
                        ActivityOptionsCompat optionsCompat = ActivityOptionsCompat.makeCustomAnimation(getApplicationContext(), R.anim.activity_menu_entrada, R.anim.activity_principal_saida);
                        ActivityCompat.startActivity(MainActivity.this, intent, optionsCompat.toBundle());
                        dialog.dismiss();
                        finish();
                    }
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
    }

    @Override
    public void onBackPressed() {
        List<Fragment> fragments = getSupportFragmentManager().getFragments();

        if (fragments.size() > 0) {
            Fragment visibleFragment = fragments.get(0);
            switch (visibleFragment.getTag()) {
                case "FragCadastro": {
                    voltarMainActivity();
                    break;
                }
                case "FragConectar": {
                    voltarMainActivity();
                    break;
                }
            }
        } else {
            finish();
        }
    }

    private void voltarMainActivity() {
        FragmentManager fm = this.getSupportFragmentManager();
        if (fm.getBackStackEntryCount() > 0) {
            fm.popBackStack();
        }
    }

    public void permissoes() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
            if (ActivityCompat.shouldShowRequestPermissionRationale(this, Manifest.permission.READ_EXTERNAL_STORAGE)) {
            } else {
                ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_EXTERNAL_STORAGE}, PERMISSAO_REQUEST);
            }
        }

        if (ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
            if (ActivityCompat.shouldShowRequestPermissionRationale(this, Manifest.permission.WRITE_EXTERNAL_STORAGE)) {
            } else {
                ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE}, PERMISSAO_REQUEST);
            }
        }
    }

    @Override
    public void finish() {
        super.finish();

        overridePendingTransition(R.anim.activity_principal_entrada, R.anim.activity_menu_saida);
    }
}
