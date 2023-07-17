function addToCart(pid, pname, price) {
    let cart = localStorage.getItem("cart");
    if (cart == null) {
        let products = [];
        let product = {productId: pid, productName: pname, productPrice: price, productQuantity: 1}
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products))
        showToast("product is added for first time")
    } else {
        let pcart = JSON.parse(cart);
        let oldproduct = pcart.find((item) => item.productId == pid)
        console.log(oldproduct)
        if (oldproduct) {
            oldproduct.productQuantity = oldproduct.productQuantity + 1
            pcart.map((item) => {

                if (item.productId == oldproduct.productId) {
                    item.productQuantity = oldproduct.productQuantity;
                }
            })
            localStorage.setItem("cart", JSON.stringify(pcart))
            showToast("product quantity is increased")
        } else {
            let product = {productId: pid, productName: pname, productPrice: price, productQuantity: 1}
            pcart.push(product);
            localStorage.setItem("cart", JSON.stringify(pcart))
           showToast("product is added to cart")
        }
    }
    updateCart();
}

function updateCart() {
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);
    if (cart == null || cart.length == 0) {
        $(".cart-items").html(0);
        $(".cart-body").html("<h3>Cart does not have any items</h3>");
        $(".checkout-btn").attr('disabled',true);
    } else {
        console.log(cart)
        $(".cart-items").html(`(${cart.length})`);
        let table = `
        <table class="table">
             <thead class="thead-light">
             <tr>
                <th>Item Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total price</th>
                <th>Action</th>
             </tr>
             </thead>
        `;

        let totalPrice=0;
        cart.map((item)=>{
            table+=`
            <tr>
            <td>${item.productName}</td>
            <td>${item.productPrice}</td>
            <td>${item.productQuantity}</td>
            <td>${item.productQuantity * item.productPrice}</td>
            <td><button onclick="deleteFromCart(${item.productId})" class="btn btn-danger btn-sm">Remove</button></td>
            </tr>
            `
            totalPrice+=item.productPrice * item.productQuantity;
        })

        table=table+`
            <tr><td colspan="5" style="font-size:25px" class="text-right font-weight-bold"><span class="badge badge-success">Total price: ${totalPrice}</span></td></tr>
            </table>`
        $(".cart-body").html(table);
        $(".checkout-btn").attr('disabled',false);
    }

}

function deleteFromCart(pid) {
    let cart=JSON.parse(localStorage.getItem("cart"));
    let newCart=cart.filter((item)=>item.productId!=pid)
    localStorage.setItem("cart",JSON.stringify(newCart))
    updateCart();
    showToast("item(s) removed from cart")
}

$(document).ready(function () {
    updateCart();
})

// toast function start

function showToast(content) {
    $('#toast').addClass("display");
    $('#toast').html(content);
    setTimeout(()=>{
        $("#toast").removeClass("display");
    },2000);
}
// toast function end

// go to checkout function start
function goToCheckOut() {

    window.location="checkout.jsp"
}