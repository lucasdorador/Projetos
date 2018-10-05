package lucas.cardapioonline.Activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;

import android.support.v4.app.ActivityCompat;
import android.support.v4.app.ActivityOptionsCompat;
import android.view.View;
import android.support.v7.app.AppCompatActivity;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.ValueEventListener;
import com.squareup.picasso.Picasso;

import lucas.cardapioonline.Classes.Constantes;
import lucas.cardapioonline.DAO.ConfiguracaoFirebase;
import lucas.cardapioonline.R;

public class PrincipalActivity extends AppCompatActivity {

    private FirebaseAuth autenticacao;
    private DatabaseReference reference;
    private ImageView imgPrincipalFoto;
    private TextView txtSaudacaoInicial;
    private String NomeCompleto = "", GeneroUsuario = "";
    private LinearLayout linearLayout_Petiscaria;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_principal);

        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN);

        autenticacao = FirebaseAuth.getInstance();
        reference = ConfiguracaoFirebase.getReferenciaFirebase();
        imgPrincipalFoto = findViewById(R.id.imgPrincipalFoto);
        txtSaudacaoInicial = findViewById(R.id.txtSaudacaoInicial);
        linearLayout_Petiscaria = findViewById(R.id.linearLayout_Petiscaria);

        preencheInfoUsuarioLogado();

        imgPrincipalFoto.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                abreActivityMenus("Abrir_Menus");
            }
        });

        linearLayout_Petiscaria.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                abreActivityMenus("Cardapio");
            }
        });
    }

    @Override
    public void finish() {
        super.finish();
        overridePendingTransition(R.anim.activity_principal_entrada, R.anim.activity_menu_saida);
    }

    private void abreActivityMenus(String AcaoAbertura) {
        Intent intent = new Intent(PrincipalActivity.this, MenuActivity.class);
        Bundle bundle = new Bundle();
        bundle.putString("Acao", AcaoAbertura);
        bundle.putString("Empresa", "Petiscaria");
        bundle.putString("NomeCompleto", NomeCompleto);
        bundle.putString("Genero", GeneroUsuario);
        intent.putExtras(bundle);
        //startActivity(intent);
        ActivityOptionsCompat optionsCompat = ActivityOptionsCompat.makeCustomAnimation(getApplicationContext(), R.anim.activity_menu_entrada, R.anim.activity_principal_saida);
        ActivityCompat.startActivity(PrincipalActivity.this, intent, optionsCompat.toBundle());
        finish();
    }

    private void preencheInfoUsuarioLogado() {
        String emailUsuarioLogado = autenticacao.getCurrentUser().getEmail().toString();

        reference.child("usuarios").orderByChild("email").equalTo(emailUsuarioLogado.toString()).addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                for (DataSnapshot postSnapShot : dataSnapshot.getChildren()) {
                    String nomeUsuarioLogado = postSnapShot.child("nome").getValue().toString();
                    GeneroUsuario = postSnapShot.child("genero").getValue().toString();
                    NomeCompleto = nomeUsuarioLogado;

                    if (GeneroUsuario.equals("Masculino")) {
                        Picasso.get().load(R.mipmap.avatar_masc_124).resize(Constantes.TamanhoFotoPerfil_Width, Constantes.TamanhoFotoPerfil_Height).centerCrop().into(imgPrincipalFoto);
                    } else if (GeneroUsuario.equals("Feminino")) {
                        Picasso.get().load(R.mipmap.avatar_fem_124).resize(Constantes.TamanhoFotoPerfil_Width, Constantes.TamanhoFotoPerfil_Height).centerCrop().into(imgPrincipalFoto);
                    } else {
                        Picasso.get().load(R.mipmap.avatar_user_124).resize(Constantes.TamanhoFotoPerfil_Width, Constantes.TamanhoFotoPerfil_Height).centerCrop().into(imgPrincipalFoto);
                    }

                    if (nomeUsuarioLogado.indexOf(" ") > 0) {
                        txtSaudacaoInicial.setText(nomeUsuarioLogado.substring(0, nomeUsuarioLogado.indexOf(" ")));
                    } else {
                        txtSaudacaoInicial.setText(nomeUsuarioLogado);
                    }

                }
            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {

            }
        });
    }

}
