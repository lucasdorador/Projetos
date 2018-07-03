package apresentacao;

public class TesteContaCorrente {
	
	public static void main(String[] args) {
		Contacorrente contacorrente = new Contacorrente();
		
		contacorrente.setNumero(123456);
		contacorrente.setLimite(1000);
		contacorrente.setSaldo(500);
		
		System.out.println("Número : " + contacorrente.getNumero());
		System.out.println("Limite : " + contacorrente.getLimite());
		System.out.println("Saldo  : " + contacorrente.getSaldo());
	}

}
