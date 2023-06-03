<?php

include ("init.php");
use Models\Cart;
use Models\Order;

$stripe = new \Stripe\StripeClient(
    'sk_test_51LgIL6JDVdkZQkB8LlIgHQbRhd0nkWRJZmUlg32mJIleQ6DyHGmdMg2JXKk3wXWenDOaQ8fMGgmBBSt0wmJeY0HY00FjrBokRO'
  );

try {
  //$checkout = $stripe->checkout->sessions->all(['limit' => 1]);
  $checkout = $stripe->paymentIntents->all(['limit' => 1]);
  
  $jsonData = json_encode($checkout);
  file_put_contents("checkout_session.json", $jsonData);

  // $session = $checkout->data[0];
  // $amount_total = $session->amount_total;
  // $id = $session->id;

  // $currency = $session->currency;
  // $email = $session->customer_details->email;
  // $name = $session->customer_details->name;
  // $payment_intent = $session->payment_intent;

  $orders = new Order('','','');
  $orders->setConnection($connection);
  $orders->recordOrder();
  $order_detail_id = $orders->getOrderId(1);
  $detail_id = end($order_detail_id);
  //var_dump($lastElement);

  $carts = new Cart('','', '', '');
  $carts->setConnection($connection);
  $cart = $carts->getCartItems(1);

  foreach($cart as $cart_item){
    $order_id = $detail_id[0];
    $product_id = $cart_item['product_id'];
    $product_quantity = $cart_item['cart_item_quantity'];
    $orders->addOrderDetails($order_id, $product_id, $product_quantity);
  }

  header("Location: order-page.php");

} catch (Exception $e) {
    echo "<script>window.location.href='index.php?error='" . $e->getMessage() . ";</script>";
    exit();
}