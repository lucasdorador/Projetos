package lucas.cardapioonline.Fragments;

import android.app.AlertDialog;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.beardedhen.androidbootstrap.BootstrapButton;
import com.beardedhen.androidbootstrap.BootstrapEditText;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import dmax.dialog.SpotsDialog;
import lucas.cardapioonline.Activity.PrincipalActivity;
import lucas.cardapioonline.Classes.Usuarios;
import lucas.cardapioonline.DAO.ConfiguracaoFirebase;
import lucas.cardapioonline.Helper.Preferencias;
import lucas.cardapioonline.R;

import static lucas.cardapioonline.Classes.Util.MensagemRapida;

public class FragmentConectar extends Fragment {

    private BootstrapButton btnConectarFacebook, btnConectarGoogle, btnCadastrarEmail;
    private BootstrapEditText edtConectarEmail, edtConectarSenha;
    private TextView txtEsqueceuSenha;
    private FirebaseAuth autenticacao;
    private DatabaseReference reference;
    private Usuarios usuario;
    private AlertDialog dialog;

    private OnFragmentInteractionListener mListener;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        final View view = inflater.inflate(R.layout.layout_conectar, container, false);

        dialog = new SpotsDialog.Builder()
                .setContext(getActivity())
                .setTheme(R.style.LoginCustom)
                .setCancelable(false)
                .build();

        btnConectarFacebook = view.findViewById(R.id.btnConectarFacebook);
        btnConectarGoogle = view.findViewById(R.id.btnConectarGoogle);
        btnCadastrarEmail = view.findViewById(R.id.btnCadastrarEmail);
        edtConectarEmail = view.findViewById(R.id.edtConectarEmail);
        edtConectarSenha = view.findViewById(R.id.edtConectarSenha);
        txtEsqueceuSenha = view.findViewById(R.id.txtEsqueceuSenha);
        reference = FirebaseDatabase.getInstance().getReference();
        autenticacao = FirebaseAuth.getInstance();

        btnConectarFacebook.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

            }
        });

        btnConectarGoogle.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

            }
        });

        btnCadastrarEmail.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.show();
                conectarEmail();
            }
        });


        txtEsqueceuSenha.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

            }
        });

        return view;
    }

    private void conectarEmail() {
        boolean vlbValidacao = true;

        if (edtConectarEmail.getText().toString().equals("")) {
            vlbValidacao = false;
            edtConectarEmail.setError("Preenchimento obrigatório!");
        }

        if (edtConectarSenha.getText().toString().equals("")) {
            vlbValidacao = false;
            edtConectarSenha.setError("Preenchimento obrigatório!");
        }

        if (vlbValidacao) {

            usuario = new Usuarios();
            usuario.setEmail(edtConectarEmail.getText().toString());
            usuario.setSenha(edtConectarSenha.getText().toString());

            validarLogin();
        }
    }

    private void validarLogin() {
        autenticacao = ConfiguracaoFirebase.getFirebaseAuth();
        autenticacao.signInWithEmailAndPassword(usuario.getEmail().toString(), usuario.getSenha().toString()).addOnCompleteListener(new OnCompleteListener<AuthResult>() {
            @Override
            public void onComplete(@NonNull Task<AuthResult> task) {
                if (task.isSuccessful()) {
                    abrirTelaPrincipal();
                    Preferencias preferencias = new Preferencias(getActivity());
                    preferencias.salvarUsuarioPreferencias(usuario.getEmail(), usuario.getSenha());
                    dialog.dismiss();
                    MensagemRapida(getActivity(), "Login efetuado com sucesso!");
                } else {
                    MensagemRapida(getActivity(), "Usuário ou senha inválidos! Tente novamente");
                }
            }
        });
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
                        Intent intent = new Intent(getActivity(), PrincipalActivity.class);
                        startActivity(intent);
                        getActivity().finish();
                    }
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    public interface OnFragmentInteractionListener {
        void onFragmentInteraction(Uri uri);
    }
}
