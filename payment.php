<?php

include ("init.php");
use Models\Cart;
use Models\Order;

$stripe = new \Stripe\StripeClient(
    'sk_test_51LgIL6JDVdkZQkB8LlIgHQbRhd0nkWRJZmUlg32mJIleQ6DyHGmdMg2JXKk3wXWenDOaQ8fMGgmBBSt0wmJeY0HY00FjrBokRO'
  );

try {
  $checkout = $stripe->paymentIntents->all(['limit' => 1]);

  var_dump($checkout);
//   $jsonData = json_encode($checkout);
//   file_put_contents("checkout_session.json", $jsonData);

  // $session = $checkout->data[0];
  // $amount_total = $session->amount_total;
  // $id = $session->id;

  // $currency = $session->currency;
  // $email = $session->customer_details->email;
  // $name = $session->customer_details->name;
  // $payment_intent = $session->payment_intent;


} catch (Exception $e) {
    echo "<script>window.location.href='index.php?error='" . $e->getMessage() . ";</script>";
    exit();
}