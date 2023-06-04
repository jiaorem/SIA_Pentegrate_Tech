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

  $amount = $checkout['data'][0]['amount'];
  $amount_total = number_format($amount / 100, 2);
  $checkout['amount_total'] = $amount_total;

  $updated_json = json_encode($checkout);
  file_put_contents("checkout_session.json", $updated_json);

  $orders = new Order('','','');
  $orders->setConnection($connection);
  $orders->recordOrder();
  $order_detail_id = $orders->getOrderId(1);
  $detail_id = end($order_detail_id);

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