package word;

import java.util.ArrayList;

public class LongmanSense {

	String signPost;
	ArrayList<String> def;
	
	public String getSignPost() {
		return signPost;
	}
	public void setSignPost(String signPost) {
		this.signPost = signPost;
	}
	public ArrayList<String> getDef() {
		return def;
	}
	public void setDef(ArrayList<String> def) {
		this.def = def;
	}
	public void addDef(String def) {
		this.def.add(def);
	}
	
	public LongmanSense() {
		this.def = new ArrayList<String>();
		this.signPost = null;
	}
	public LongmanSense(String signPost, String id, ArrayList<String> def) {
		super();
		this.signPost = signPost;
		this.def = def;
	}
	
	
}
