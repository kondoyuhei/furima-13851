function calculate() {
  let price = document.getElementById("item-price"); // 販売価格の要素を取得する

  price.addEventListener("input", function() {
    margin = Math.floor(this.value * 0.1) // 販売手数料を計算
    document.getElementById("add-tax-price").innerHTML = margin.toLocaleString(); // 販売手数料を更新
    document.getElementById("profit").innerHTML = (this.value - margin).toLocaleString(); // 販売利益を更新
  });
}

window.addEventListener("load", calculate);