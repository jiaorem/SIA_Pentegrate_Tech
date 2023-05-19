<?php

include ("init.php");
use Models\Cart;

$carts = new Cart('', '', '', '');
$carts->setConnection($connection);
$all_carts = $carts->getCartItems(1);

if(count($all_carts)===0){
    $template = $mustache->loadTemplate('cart.mustache');
    echo $template->render();
} elseif (count($all_carts)===1) {
    $cart_total = $all_carts[0][7];
    
    $template = $mustache->loadTemplate('cart.mustache');
    echo $template->render(compact('all_carts','cart_total'));
} else {
    $prices[] = array();
    foreach($all_carts as $carts){
        $product_price = $carts['total_price'];
        $p = array_push($prices,$product_price);
    }
    $total = intval($prices[1]) + intval($prices[2]);
    $cart_total = number_format($total,2);
    
    $template = $mustache->loadTemplate('cart.mustache');
    echo $template->render(compact('all_carts','cart_total'));
}

