

class Subscription {
  String? id;
  int? payer_id;
  String? payer_email;
  String? back_url;
  String? status;
  String? reason;
  String? date_created;
  String? last_modifed;
  String? init_point;
  String? next_payment_date;
  String? payment_method_id;
  String? card_id;
  int? first_invoice_offset;

  Subscription(
      this.id,
      this.payer_id,
      this.payer_email,
      this.back_url,
      this.status,
      this.reason,
      this.date_created,
      this.last_modifed,
      this.init_point,
      this.next_payment_date,
      this.payment_method_id,
      this.card_id,
      this.first_invoice_offset,
      );

  factory Subscription.fromJson(dynamic json) {
    return Subscription(
        json["id"],
        json["payer_id"],
        json["payer_email"],
        json["back_url"],
        json["status"],
        json["reason"],
        json["date_created"],
        json["last_modifed"],
        json["init_point"],
        json["next_payment_date"],
        json["payment_method_id"],
        json["card_id"],
        json["first_invoice_offset"],
    );
  }


  factory Subscription.toNull() {
    return Subscription(null, null, null, null, null, null, null, null, null, null, null, null, null);
  }

  @override
  String toString() {
    return '{id: $id, payer_id: $payer_id, payer_email: $payer_email, back_url: $back_url, status: $status, reason: $reason, date_created: $date_created, last_modifed: $last_modifed, init_point: $init_point, next_payment_date: $next_payment_date, payment_method_id: $payment_method_id, card_id: $card_id, first_invoice_offset: $first_invoice_offset}';
  }
}