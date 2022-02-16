$(document).on("change", ".shoping__cart__quantity #quantity", function(e) {
  let id = $(this).data("id");
  let quantity = $(this).val();

  $.ajax({
    method: "POST",
    url: "/update_cart",
    data: {id: id, quantity: quantity},
    dataType: 'script'
  });
});
