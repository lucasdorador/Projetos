package apresentacao;

public class TesteProgramador {
	
	public static void main(String[] args) {
		Programador programador1 = new Programador();
		
		programador1.setNome("José");
		programador1.setSalario(1000);
		programador1.setUsuario("jose_123");
		programador1.setSenha("123");	
		
		System.out.println("Calculo da Meta: " + programador1.calculaMeta());
	}

}
