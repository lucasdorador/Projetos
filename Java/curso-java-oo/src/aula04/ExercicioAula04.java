package aula04;

public class ExercicioAula04 {
	
	void tabuada(int x) {
		System.out.println("Tabuada do " + x);
		for (int i=1; i<11; i++) {
			int resultado = x*i;
			System.out.println(x + "x" + i + "=" + resultado);
		}
	}
	
	public static void main (String[] args) {
		ExercicioAula04 e = new ExercicioAula04();
		e.tabuada(8);		
	}

}
