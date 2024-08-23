class LGA {
  final String id;
  final String name;
  final String hq;

  LGA({required this.id, required this.name, this.hq = ""});
}

final List<LGA> gombeLGAS = [
  LGA(id: "1", name: "Akko", hq: "Kumo"),
  LGA(id: "2", name: "Balanga", hq: "Tallase"),
  LGA(id: "3", name: "Billiri", hq: "Billiri"),
  LGA(id: "4", name: "Dukku", hq: "Dukku"),
  LGA(id: "5", name: "Funakaye", hq: "Bajoga"),
  LGA(id: "6", name: "Gombe", hq: "Gombe"),
  LGA(id: "7", name: "Kaltungo", hq: "Kaltungo"),
  LGA(id: "8", name: "Kwami", hq: "Mallam Sidi"),
  LGA(id: "9", name: "Nafada", hq: "Nafada"),
  LGA(id: "10", name: "Shongom", hq: "Boh"),
  LGA(id: "11", name: "Yamaltu/Deba", hq: "Deba"),
];

String returnLGA({required int lgID}) {
  return lgID == 1
      ? "Akko"
      : lgID == 2
          ? "Balanga"
          : lgID == 3
              ? "Billiri"
              : lgID == 4
                  ? "Dukku"
                  : lgID == 5
                      ? "Funakaye"
                      : lgID == 6
                          ? "Gombe"
                          : lgID == 7
                              ? "Kaltungo"
                              : lgID == 8
                                  ? "Kwami"
                                  : lgID == 9
                                      ? "Nafada"
                                      : lgID == 10
                                          ? "Shongom"
                                          : lgID == 11
                                              ? "Yamaltu/Deba"
                                              : "NA";
}
