const pay = () => {
  // PAY.JPテスト公開鍵
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);

  // フォームを取得する
  const form = document.getElementById("charge-form");

  // フォーム送信時の動作
  form.addEventListener("submit", (e) => {

    // JavaScriptでフォーム送信するため、デフォルトのRailsの処理をしない設定にする
    e.preventDefault();

    // フォームの入力値を取得する
    const cardForm = document.getElementById("charge-form");
    const formData = new FormData(cardForm);

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
        
        // 隠し要素を埋め込む要素「charge-form」を取得する
        const cardForm = document.getElementById("charge-form");
        
        // トークンを含む隠し要素タグを作成
        const tokenObj = `<input value=${token} type="hidden" name='token'>`;
        
        // charge-form内の最後に隠しオブジェクトを追記する。
        cardForm.insertAdjacentHTML("beforeend", tokenObj);

        // フォームの入力欄からname属性をクリアして、カード情報を送信しないようにする
        document.getElementById("card-number").removeAttribute("name");
        document.getElementById("card-cvc").removeAttribute("name");
        document.getElementById("card-exp-month").removeAttribute("name");
        document.getElementById("card-exp-year").removeAttribute("name");

        // フォームを送信する
        cardForm.submit();

        // フォームをリセットする
        cardForm.reset();
      } else {
        location.reload();
        // document.getElementById("card-number").value = ""
        // document.getElementById("card-cvc").value = ""
        // document.getElementById("card-exp-month").value = ""
        // document.getElementById("card-exp-year").value = ""
        // return
      }
    });
  });
};

window.addEventListener("load", pay);