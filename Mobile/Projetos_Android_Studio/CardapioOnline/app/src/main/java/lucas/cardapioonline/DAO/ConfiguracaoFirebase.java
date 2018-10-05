package lucas.cardapioonline.DAO;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.StorageReference;

public class ConfiguracaoFirebase {

    private static DatabaseReference referenciaFirebase;
    private static FirebaseAuth autenticacao;
    private static FirebaseStorage storage;
    private static StorageReference storageReference;

    public static DatabaseReference getReferenciaFirebase() {
        if (referenciaFirebase == null) {
            referenciaFirebase = FirebaseDatabase.getInstance().getReference();
        }

        return referenciaFirebase;
    }

    public static FirebaseAuth getFirebaseAuth() {
        if (autenticacao == null) {
            autenticacao = FirebaseAuth.getInstance();
        }

        return autenticacao;
    }

    public static FirebaseStorage getFirebaseStorage(){
        if (storage == null) {
            storage = FirebaseStorage.getInstance();
        }

        return storage;
    }

    public static StorageReference getReferenciaStorage() {
        if (storageReference == null){
            storageReference  = FirebaseStorage.getInstance().getReference();
        }

        return storageReference;
    }
}
