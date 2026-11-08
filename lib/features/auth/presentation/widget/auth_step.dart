/// The register steps, in order; log-in uses only the first two.
enum AuthStep {
  phone,
  otp,
  name,
  dateOfBirth;

  int get number => index + 1;

  int get total => values.length;

  double get progress => number / total;

  /// Where the ring starts when this step opens.
  double get previousProgress => index / total;
}
