package lucas.cardapioonline.Fragments;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

import lucas.cardapioonline.Adapter.CardapioAdapter;
import lucas.cardapioonline.Classes.Cardapio_Itens;
import lucas.cardapioonline.R;

public class FragmentCardapio extends Fragment {

    private OnFragmentInteractionListener mListener;
    private String EmpresaSelecionada = "";
    private LinearLayout linearLayout_RetornarMenuPrincipal;
    private RecyclerView recycleViewCardapio;
    private LinearLayoutManager mLayoutManagerTodosProdutos;
    private CardapioAdapter adapter;
    private List<Cardapio_Itens> cardapios;

    public FragmentCardapio() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        final View view = inflater.inflate(R.layout.layout_cardapio, container, false);

        Bundle bundle = this.getArguments();
        EmpresaSelecionada = bundle.getString("Empresa");

        linearLayout_RetornarMenuPrincipal = view.findViewById(R.id.linearLayout_RetornarMenuPrincipal);
        recycleViewCardapio = view.findViewById(R.id.recycleViewCardapio);
        carregarTodosProdutos(EmpresaSelecionada);

        linearLayout_RetornarMenuPrincipal.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });

        return view;
    }

    private void retornaCardapioCompleto(String empresaSelecionada){
        cardapios = new ArrayList<>();
        //referenciaFirebase = FirebaseDatabase.getInstance().getReference();

        /*referenciaFirebase.child("cardapio").orderByChild("nomePrato").addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {

                for (DataSnapshot postSnapShot : dataSnapshot.getChildren()) {
                    todosCardapio = postSnapShot.getValue(Cardapio.class);
                    cardapios.add(todosCardapio);
                }

                adapter.notifyDataSetChanged();
            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {

            }
        });*/

        Cardapio_Itens itens;

        itens = new Cardapio_Itens();
        itens.setGrupo("Porções Chapeadas");
        itens.setKeyProduto("1");
        itens.setProduto("Contra-Filé acebolado");
        itens.setComplementoProduto("(Acompanha pão)");
        itens.setValorMeia("0");
        itens.setValorInteira("52");
        cardapios.add(0, itens);

        itens = new Cardapio_Itens();
        itens.setKeyProduto("2");
        itens.setProduto("Picanha");
        itens.setComplementoProduto("(Acompanha arroz e salada)");
        itens.setValorMeia("30.00");
        itens.setValorInteira("62.00");
        cardapios.add(1, itens);

        itens = new Cardapio_Itens();
        itens.setKeyProduto("3");
        itens.setProduto("Calabresa Acebolada");
        itens.setComplementoProduto("(Acompanha pão)");
        itens.setValorMeia("0");
        itens.setValorInteira("35.00");
        cardapios.add(2, itens);
    }

    private void carregarTodosProdutos(String empresaSelecionada) {
        recycleViewCardapio.setHasFixedSize(true);
        mLayoutManagerTodosProdutos = new LinearLayoutManager(getActivity(), LinearLayoutManager.VERTICAL, false);
        recycleViewCardapio.setLayoutManager(mLayoutManagerTodosProdutos);
        retornaCardapioCompleto(empresaSelecionada);
        adapter = new CardapioAdapter(cardapios, getActivity());
        recycleViewCardapio.setAdapter(adapter);
        adapter.notifyDataSetChanged();
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

    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }
}
