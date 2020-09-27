import 'dart:convert';

BaacMapBranch baacMapBranchFromJson(String str) => BaacMapBranch.fromJson(json.decode(str));

String baacMapBranchToJson(BaacMapBranch data) => json.encode(data.toJson());

class BaacMapBranch {
    BaacMapBranch({
        this.branch,
    });

    List<Branch> branch;

    factory BaacMapBranch.fromJson(Map<String, dynamic> json) => BaacMapBranch(
        branch: json["branch"] == null ? null : List<Branch>.from(json["branch"].map((x) => Branch.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "branch": branch == null ? null : List<dynamic>.from(branch.map((x) => x.toJson())),
    };
}

class Branch {
    Branch({
        this.address,
        this.id,
        this.image,
        this.lat,
        this.lng,
        this.name,
        this.phone,
    });

    String address;
    String id;
    String image;
    String lat;
    String lng;
    String name;
    String phone;

    factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        address: json["address"] == null ? null : json["address"],
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : json["image"],
        lat: json["lat"] == null ? null : json["lat"],
        lng: json["lng"] == null ? null : json["lng"],
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
        "id": id == null ? null : id,
        "image": image == null ? null : image,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
    };
}