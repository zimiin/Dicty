package word;

public class Etymology {
	String word;
	String def;
	String moreInfo;
	
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
	public String getMoreInfo() {
		return moreInfo;
	}
	public void setMoreInfo(String moreInfo) {
		this.moreInfo = moreInfo;
	}
	
	public Etymology() {
		
	}
	public Etymology(String word, String def, String moreInfo) {
		super();
		this.word = word;
		this.def = def;
		this.moreInfo = moreInfo;
	}
	
	
}
