package lucas.cardapioonline.Adapter;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.google.firebase.database.DatabaseReference;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.List;

import lucas.cardapioonline.Classes.Cardapio_Itens;
import lucas.cardapioonline.R;

public class CardapioAdapter extends RecyclerView.Adapter<CardapioAdapter.ViewHolder> {

    private List<Cardapio_Itens> mCardapioList;
    private Context context;
    private DatabaseReference referenciaFirebase;
    private List<Cardapio_Itens> cardapios;
    private Cardapio_Itens todosProdutos;

    public CardapioAdapter(List<Cardapio_Itens> l, Context c) {
        context = c;
        mCardapioList = l;
    }

    @NonNull
    @Override
    public CardapioAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        View itemView = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.layout_item_cardapio, viewGroup, false);
        return new CardapioAdapter.ViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(@NonNull final CardapioAdapter.ViewHolder holder, int position) {
        DecimalFormat nf = new DecimalFormat("0.00");
        final Cardapio_Itens item = mCardapioList.get(position);
        /*cardapios = new ArrayList<>();
        referenciaFirebase = FirebaseDatabase.getInstance().getReference();
        referenciaFirebase.child("cardapio").orderByChild("keyProduto").equalTo(item.getKeyProduto()).addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(@NonNull DataSnapshot dataSnapshot) {
                cardapios.clear();
                for (DataSnapshot postSnapShot : dataSnapshot.getChildren()) {
                    todosProdutos = postSnapShot.getValue(Cardapio.class);
                    cardapios.add(todosProdutos);
                    DisplayMetrics displayMetrics = context.getResources().getDisplayMetrics();

                    final int height = (displayMetrics.heightPixels / 4);
                    final int width = (displayMetrics.widthPixels / 2);

                    Picasso.get().load(todosProdutos.getUrlImagem()).resize(width, height).centerCrop().into(holder.fotoProdutoCardapio);

                }
            }

            @Override
            public void onCancelled(@NonNull DatabaseError databaseError) {

            }
        });*/

        holder.cardapio_Produto.setText(item.getProduto());
        holder.cardapio_ComplementoProduto.setText(item.getComplementoProduto());
        if (item.getValorMeia().equals("0")) {
            holder.cardapio_ValorMeia.setText("--");
        } else if (!item.getValorMeia().equals("")) {
            holder.cardapio_ValorMeia.setText(nf.format(Double.valueOf(item.getValorMeia())));
        }

        if (!item.getValorInteira().equals("")) {
            holder.cardapio_ValorInteria.setText(nf.format(Double.valueOf(item.getValorInteira())));
        }

        holder.linearLayout_Produtos.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

            }
        });
    }

    @Override
    public int getItemCount() {
        return mCardapioList.size();
    }

    public static class ViewHolder extends RecyclerView.ViewHolder {

        protected TextView /*cardapio_GrupoProdutos,*/ cardapio_Produto,
                cardapio_ComplementoProduto, cardapio_ValorMeia, cardapio_ValorInteria;
        protected LinearLayout linearLayout_Produtos;

        public ViewHolder(View itemView) {
            super(itemView);

            //cardapio_GrupoProdutos = itemView.findViewById(R.id.cardapio_GrupoProdutos);
            cardapio_Produto = itemView.findViewById(R.id.cardapio_Produto);
            cardapio_ComplementoProduto = itemView.findViewById(R.id.cardapio_ComplementoProduto);
            cardapio_ValorMeia = itemView.findViewById(R.id.cardapio_ValorMeia);
            cardapio_ValorInteria = itemView.findViewById(R.id.cardapio_ValorInteria);
            linearLayout_Produtos = itemView.findViewById(R.id.linearLayout_Produtos);
        }
    }
}
