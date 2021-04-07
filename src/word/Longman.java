package word;

import java.util.ArrayList;

public class Longman {

	String word;
	String id;
	ArrayList<LongmanSense> sense;
	
	
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
	public ArrayList<LongmanSense> getSense() {
		return sense;
	}
	public void setSense(ArrayList<LongmanSense> sense) {
		this.sense = sense;
	}
	public void addSense(LongmanSense sense) {
		this.sense.add(sense);
	}
	
	public Longman() {
		this.sense = new ArrayList<LongmanSense>();
	}
	
	public Longman(String word, String id, ArrayList<LongmanSense> sense) {
		super();
		this.word = word;
		this.id = id;
		this.sense = sense;
	}
	
}
