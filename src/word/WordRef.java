package word;

public class WordRef {
	
	String word;
	String def;
	String id;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
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
	
	public WordRef() {
		
	}
	public WordRef(String word, String def, String id) {
		super();
		this.word = word;
		this.def = def;
		this.id = id;
	}
	
}
