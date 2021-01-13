class Rank{
	int id;
	int level;
	String name;
	int score;
	String time;

	Rank();

	Rank.fromMap(Map<String, dynamic> map){
		id = map["id"];
		level = map["level"];
		name = map["name"];
		score = map["score"];
		time = map["time"];
	}

	Map<String, dynamic> toMap(){
		return <String, dynamic>{
			"id": id,
			"level": level,
			"name": name,
			"score": score,
			"time": time,
		};
	}
}