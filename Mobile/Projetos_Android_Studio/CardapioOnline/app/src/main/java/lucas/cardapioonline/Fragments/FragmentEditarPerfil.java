package lucas.cardapioonline.Fragments;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.support.annotation.NonNull;
import android.support.v4.app.Fragment;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Spinner;

import com.beardedhen.androidbootstrap.BootstrapButton;
import com.beardedhen.androidbootstrap.BootstrapEditText;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.storage.StorageReference;
import com.google.firebase.storage.UploadTask;
import com.squareup.picasso.Picasso;

import java.io.ByteArrayOutputStream;

import lucas.cardapioonline.Classes.Mascara;
import lucas.cardapioonline.Classes.Usuarios;
import lucas.cardapioonline.DAO.ConfiguracaoFirebase;
import lucas.cardapioonline.R;

import static lucas.cardapioonline.Classes.Util.MensagemRapida;

public class FragmentEditarPerfil extends Fragment {

    private OnFragmentInteractionListener mListener;
    private BootstrapEditText edtEditarEmail, edtEditarNome, edtEditarEndereco,
            edtEditarNumero, edtEditarBairro, edtEditarCelular, edtEditarIdade,
            edtEditarSenha1, edtEditarSenha2;
    private Spinner spinnerEditarGenero;
    private BootstrapButton btnEditarPerfil, btnExcluirPerfil;
    private LinearLayout linearLayout_FotoPerfil;
    private ImageView imgEditarFotoPerfil;
    private String txtOrigem = "", txtNome = "", txtIdade = "",
            txtEndereco = "", txtNumero = "", txtGenero = "", txtKeyUsuario = "",
            txtEmail = "", txtTipoUsuario = "", txtBairro = "", txtCelular = "",
            txtUriFotoPerfil = "";
    private Integer height, width;
    private DatabaseReference reference;
    private StorageReference storageReference;


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        final View view = inflater.inflate(R.layout.layout_editarcadastro, container, false);

        /*DisplayMetrics displayMetrics = view.getResources().getDisplayMetrics();

        height = (displayMetrics.heightPixels / 4);
        width = (displayMetrics.widthPixels / 2);*/

        edtEditarEmail = view.findViewById(R.id.edtEditarEmail);
        edtEditarNome = view.findViewById(R.id.edtEditarNome);
        edtEditarEndereco = view.findViewById(R.id.edtEditarEndereco);
        edtEditarNumero = view.findViewById(R.id.edtEditarNumero);
        edtEditarBairro = view.findViewById(R.id.edtEditarBairro);
        edtEditarCelular = view.findViewById(R.id.edtEditarCelular);
        edtEditarIdade = view.findViewById(R.id.edtEditarIdade);
        edtEditarSenha1 = view.findViewById(R.id.edtEditarSenha1);
        edtEditarSenha2 = view.findViewById(R.id.edtEditarSenha2);
        spinnerEditarGenero = view.findViewById(R.id.spinnerEditarGenero);
        btnEditarPerfil = view.findViewById(R.id.btnEditarPerfil);
        btnExcluirPerfil = view.findViewById(R.id.btnExcluirPerfil);
        //linearLayout_FotoPerfil = view.findViewById(R.id.linearLayout_FotoPerfil);
        //imgEditarFotoPerfil = view.findViewById(R.id.imgEditarFotoPerfil);
        storageReference = ConfiguracaoFirebase.getReferenciaStorage();

        edtEditarCelular.addTextChangedListener(Mascara.insert("(##)#####-####", edtEditarCelular));

        btnEditarPerfil.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                editarUsuario();
            }
        });

        btnExcluirPerfil.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

            }
        });

        /*linearLayout_FotoPerfil.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //Intent intent = new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.EXTERNAL_CONTENT_URI);
                //startActivityForResult(Intent.createChooser(intent, "Selecione uma imagem"), 123);
            }
        });*/

        Bundle bundle = this.getArguments();

        txtOrigem = bundle.getString("origem");

        if (txtOrigem.equals("editarUsuario")) {
            carregaDadosIniciais(view, bundle);
        }

        return view;
    }

    private void editarUsuario() {
        boolean validaDados = true;
        boolean alteraSenha = false;

        if (edtEditarSenha1.getText().toString().equals(edtEditarSenha2.getText().toString())) {
            if (!edtEditarSenha1.getText().toString().equals("")) {
                alteraSenha = true;
            }
        } else {
            validaDados = false;
            MensagemRapida(getActivity(), "Senhas não conferem!");
        }

        if (validaDados) {
            Usuarios usuarios = new Usuarios();
            usuarios.setEmail(edtEditarEmail.getText().toString());
            usuarios.setSenha(edtEditarSenha1.getText().toString());
            usuarios.setNome(edtEditarNome.getText().toString());
            usuarios.setIdade(edtEditarIdade.getText().toString());
            usuarios.setGenero(spinnerEditarGenero.getSelectedItem().toString());
            usuarios.setEndereco(edtEditarEndereco.getText().toString());
            usuarios.setNumero(edtEditarNumero.getText().toString());
            usuarios.setBairro(edtEditarBairro.getText().toString());
            usuarios.setCelular(edtEditarCelular.getText().toString());
            usuarios.setKeyUsuario(txtKeyUsuario);
            usuarios.setTipoUsuario("Comum");

            atualizarDados(usuarios, alteraSenha);
        }
    }

    private boolean atualizarDados(final Usuarios usuarios, Boolean alteraSenha) {
        btnEditarPerfil.setEnabled(false);

        try {
            reference = ConfiguracaoFirebase.getReferenciaFirebase().child("usuarios");

            if (alteraSenha) {
                atualizarSenha(usuarios.getSenha().toString());
            }

            //Carregar foto storage
            //cadastraFotoPerfil(usuarios.getEmail().toString());

            usuarios.setUriFotoPerfil("");
            reference.child(txtKeyUsuario).setValue(usuarios);
            MensagemRapida(getActivity(), "Dados alterados com sucesso!");
            btnEditarPerfil.setEnabled(true);

            /*StorageReference urlFoto = storageReference.child("fotoPerfilUsuario/" + usuarios.getEmail().toString() + ".jpg");
            urlFoto.getDownloadUrl().addOnSuccessListener(new OnSuccessListener<Uri>() {
                @Override
                public void onSuccess(Uri uri) {
                    usuarios.setUriFotoPerfil(uri.toString());
                    reference.child(txtKeyUsuario).setValue(usuarios);
                    MensagemRapida(getActivity(), "Dados alterados com sucesso!");
                    btnEditarPerfil.setEnabled(true);
                }
            }).addOnFailureListener(new OnFailureListener() {
                @Override
                public void onFailure(@NonNull Exception e) {
                    usuarios.setUriFotoPerfil("");
                    reference.child(txtKeyUsuario).setValue(usuarios);
                    MensagemRapida(getActivity(), "Problemas para carregar a imagem com a mensagem: " + e.getMessage());
                }
            });*/

            //abrirTelaPrincipal();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }

    /*private void cadastraFotoPerfil(String emailUsuarioLogado) {
        StorageReference montaImagemReferencia = storageReference.child("fotoPerfilUsuario/" + emailUsuarioLogado + ".jpg");
        imgEditarFotoPerfil.setDrawingCacheEnabled(true);
        imgEditarFotoPerfil.buildDrawingCache();

        Bitmap bitmap = imgEditarFotoPerfil.getDrawingCache();
        ByteArrayOutputStream byteArray = new ByteArrayOutputStream();
        bitmap.compress(Bitmap.CompressFormat.JPEG, 100, byteArray);
        byte[] data = byteArray.toByteArray();

        UploadTask uploadTask = montaImagemReferencia.putBytes(data);
        uploadTask.addOnFailureListener(new OnFailureListener() {
            @Override
            public void onFailure(@NonNull Exception e) {
                MensagemRapida(getActivity(), "Problemas para carregar a imagem com a mensagem: " + e.getMessage());
            }
        });
    }*/

    private void atualizarSenha(String senhaNova) {
        FirebaseUser user = FirebaseAuth.getInstance().getCurrentUser();
        user.updatePassword(senhaNova)
                .addOnCompleteListener(new OnCompleteListener<Void>() {
                    @Override
                    public void onComplete(@NonNull Task<Void> task) {
                        if (task.isSuccessful()) {
                            Log.d("NOVA_SENHA_ATUALIZADA", "Senha atualizada com sucesso!");
                        }
                    }
                });
    }

    private void carregaDadosIniciais(View view, Bundle bundle) {
        txtEmail = bundle.getString("email");
        txtNome = bundle.getString("nome");
        txtIdade = bundle.getString("idade");
        txtKeyUsuario = bundle.getString("keyusuario");
        txtTipoUsuario = bundle.getString("tipoUsuario");
        txtGenero = bundle.getString("genero");
        txtEndereco = bundle.getString("endereco");
        txtNumero = bundle.getString("numero");
        txtBairro = bundle.getString("bairro");
        txtCelular = bundle.getString("celular");
        txtUriFotoPerfil = bundle.getString("uriFotoPerfil");

        edtEditarEmail.setText(txtEmail.toString());
        edtEditarNome.setText(txtNome.toString());
        edtEditarIdade.setText(txtIdade.toString());

        if (txtGenero.equals("Masculino")) {
            spinnerEditarGenero.setSelection(0);
        } else if (txtGenero.equals("Feminino")) {
            spinnerEditarGenero.setSelection(1);
        }

        edtEditarEndereco.setText(txtEndereco.toString());
        edtEditarNumero.setText(txtNumero.toString());
        edtEditarBairro.setText(txtBairro.toString());
        edtEditarCelular.setText(txtCelular.toString());
    }

    // TODO: Rename method, update argument and hook method into UI event
    public void onButtonPressed(Uri uri) {
        if (mListener != null) {
            mListener.onFragmentInteraction(uri);
        }
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

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if ((resultCode == getActivity().RESULT_OK) && (requestCode == 123)) {
            Uri imagemSelecionada = data.getData();
            Picasso.get().load(imagemSelecionada.toString()).resize(width, height).centerCrop().into(imgEditarFotoPerfil);
        }
    }

    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }

    @Override
    public void onSaveInstanceState(@NonNull Bundle outState) {
        super.onSaveInstanceState(outState);
    }
}
