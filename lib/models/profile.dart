class Profiledata {
  final String name;
  final String useremail;
  final String firstname;
  final String lastname;
  final int userid;

  Profiledata({this.name, this.useremail, this.firstname, this.lastname, this.userid});

    factory Profiledata.fromJson(Map<String, dynamic> json) {
      return Profiledata(
        name: json['username'] as String,
        useremail: json['useremail'] as String,
        firstname: json['firstname'] as String,
        lastname: json['lastname'] as String,
        userid: json['userid'] as int,
      );
    }
}