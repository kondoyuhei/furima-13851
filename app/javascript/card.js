const pay = () => {
  // PAY.JPテスト公開鍵
  Payjp.setPublicKey("pk_test_a1edc5754818c5c9732b20d7");

  // フォームを取得する
  const form = document.getElementById("charge-form");

  // フォーム送信時の動作
  form.addEventListener("submit", (e) => {

    // JavaScriptでフォーム送信するため、デフォルトのRailsの処理をしない設定にする
    e.preventDefault();

    // フォームの入力値を取得する
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    // カード情報を取得して定数cardに代入
    const card = {
      number:    formData.get("number"),
      cvc:       formData.get("cvc"),
      exp_month: formData.get("exp_month"),
      exp_year:  `20${formData.get("exp_year")}`,
    };

    // カード情報をもとにトークンを生成する。
    Payjp.createToken(card, (status, response) => {
      // トークンが正常に作成されたら処理を続ける
      if (status === 200) {
        // レスポンスとして得たデータからトークンを取得
        const token = response.id;
        
        // トークンを含む隠し要素（HTML）を生成する
        const tokenObject = `<input value=${token} type="hidden" name='token'>`;

        // フォームの最後に隠し要素を埋め込む
        const renderDom = document.getElementById("charge-form");
        renderDom.insertAdjacentHTML("beforeend", tokenObject);

        // フォームの入力欄からname属性をクリアして、カード情報を送信しないようにする
        document.getElementById("number").removeAttribute("name");
        document.getElementById("cvc").removeAttribute("name");
        document.getElementById("exp_month").removeAttribute("name");
        document.getElementById("exp_year").removeAttribute("name");

        // フォームを送信する
        document.getElementById("charge-form").submit();
      } else {
        // メッセージを表示する
        const retry_message = "<p>決済できません</p>" ;
        renderDom.insertAdjacentHTML("afterbegin", retry_message);        
      }
    });
  });
};

window.addEventListener("load", pay);