package wordList;

public class WordListDTO {

	String word;
	String def;
	
	public String getWord() {
		return word;
	}
	public void setWord(String word) {
		this.word = word;
	}
	public String getDef() {
		return def;
	}
	public void setDef(String def) {
		this.def = def;
	}
	
	public WordListDTO() {
		
	}
	public WordListDTO(String word, String def) {
		super();
		this.word = word;
		this.def = def;
	}
	
}
