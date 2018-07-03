package apresentacao;

public class Programador extends Funcionario {
	
	private String usuario;
	private String senha;
	
	public String getUsuario() {
		return usuario;
	}
	
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	
	public String getSenha() {
		return senha;
	}
	
	public void setSenha(String senha) {
		this.senha = senha;
	}
	
	public double calculaMeta() {
		return this.getSalario() + 72;
	}
}
