package lucas.cardapioonline.Fragments;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.Spinner;
import android.widget.Toast;

import com.beardedhen.androidbootstrap.BootstrapButton;
import com.beardedhen.androidbootstrap.BootstrapDropDown;
import com.beardedhen.androidbootstrap.BootstrapEditText;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthInvalidCredentialsException;
import com.google.firebase.auth.FirebaseAuthUserCollisionException;
import com.google.firebase.auth.FirebaseAuthWeakPasswordException;
import com.google.firebase.database.DatabaseReference;

import lucas.cardapioonline.Classes.Usuarios;
import lucas.cardapioonline.DAO.ConfiguracaoFirebase;
import lucas.cardapioonline.R;

import static lucas.cardapioonline.Classes.Util.MensagemRapida;

public class FragmentCadastro extends Fragment {

    private BootstrapButton btnCadastrarFacebook, btnCadastrarGoogle,
            btnCadastrarEmail;
    private BootstrapEditText edtCadastrarEmail, edtCadastrarSenha,
            edtCadastrarNome, edtCadastrarIdade;
    private Spinner SpinnerGenero;
    private OnFragmentInteractionListener mListener;
    private FirebaseAuth autenticacao;
    private DatabaseReference reference;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        final View view = inflater.inflate(R.layout.layout_cadastrar, container, false);

        btnCadastrarFacebook = view.findViewById(R.id.btnCadastrarFacebook);
        btnCadastrarGoogle = view.findViewById(R.id.btnCadastrarGoogle);
        btnCadastrarEmail = view.findViewById(R.id.btnCadastrarEmail);
        edtCadastrarEmail = view.findViewById(R.id.edtCadastrarEmail);
        edtCadastrarSenha = view.findViewById(R.id.edtCadastrarSenha);
        edtCadastrarNome = view.findViewById(R.id.edtCadastrarNome);
        edtCadastrarIdade = view.findViewById(R.id.edtCadastrarIdade);
        SpinnerGenero = view.findViewById(R.id.SpinnerGenero);

        btnCadastrarFacebook.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

            }
        });

        btnCadastrarGoogle.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

            }
        });

        btnCadastrarEmail.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Usuarios usuarios = new Usuarios();
                usuarios.setEmail(edtCadastrarEmail.getText().toString());
                usuarios.setSenha(edtCadastrarSenha.getText().toString());
                usuarios.setNome(edtCadastrarNome.getText().toString());
                usuarios.setIdade(edtCadastrarIdade.getText().toString());
                usuarios.setGenero(SpinnerGenero.getSelectedItem().toString());
                usuarios.setEndereco("");
                usuarios.setNumero("");
                usuarios.setBairro("");
                usuarios.setCelular("");
                usuarios.setUriFotoPerfil("");
                usuarios.setTipoUsuario("Comum");

                cadastrarUsuario(usuarios);
            }
        });

        return view;
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
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }

    private void cadastrarUsuario(final Usuarios usuarios) {
        Boolean vlbValidaCadastro = true;

        if (usuarios.getEmail().toString().equals("")) {
            vlbValidaCadastro = false;
            edtCadastrarEmail.setError("Preenchimento obrigatório");
        }

        if (usuarios.getSenha().toString().equals("")) {
            vlbValidaCadastro = false;
            edtCadastrarSenha.setError("Preenchimento obrigatório");
        }

        if (usuarios.getNome().toString().equals("")) {
            vlbValidaCadastro = false;
            edtCadastrarNome.setError("Preenchimento obrigatório");
        }

        if (vlbValidaCadastro) {
            autenticacao = ConfiguracaoFirebase.getFirebaseAuth();
            autenticacao.createUserWithEmailAndPassword(
                    usuarios.getEmail(),
                    usuarios.getSenha()
            ).addOnCompleteListener(getActivity(), new OnCompleteListener<AuthResult>() {
                @Override
                public void onComplete(@NonNull Task<AuthResult> task) {
                    if (task.isSuccessful()) {
                        insereUsuario(usuarios);
                    } else {
                        String erroExcecao = "";

                        try {
                            throw task.getException();
                        } catch (FirebaseAuthWeakPasswordException e) {
                            erroExcecao = "Digite uma senha mais forte, contendo no mínimo 8 caracteres " +
                                    "e que contenha letras e números!";
                        } catch (FirebaseAuthInvalidCredentialsException e) {
                            erroExcecao = "E-mail digitado é inválido, digite outro E-mail!";
                        } catch (FirebaseAuthUserCollisionException e) {
                            erroExcecao = "Esse E-mail já está cadastrado!";
                        } catch (Exception e) {
                            erroExcecao = "Erro ao efetuar o cadastro!";
                            e.printStackTrace();
                        }

                        MensagemRapida(getActivity(), "Erro: " + erroExcecao);
                    }
                }
            });
        }
    }

    private boolean insereUsuario(Usuarios usuarios) {
        try {
            reference = ConfiguracaoFirebase.getReferenciaFirebase().child("usuarios");
            String key = reference.push().getKey();
            usuarios.setKeyUsuario(key);
            reference.child(key).setValue(usuarios);
            MensagemRapida(getActivity(), "Usuário cadastrado com sucesso!");
            abreTelaConectar();
            return true;
        } catch (Exception e) {
            MensagemRapida(getActivity(), "Erro ao gravar usuário!");
            e.printStackTrace();
            return false;
        }
    }

    private void abreTelaConectar() {
        Fragment fragment_conectar = new FragmentConectar();
        getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.contentframe, fragment_conectar, "TAG").commit();
    }
}
