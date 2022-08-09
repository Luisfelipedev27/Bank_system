var Show = (function() {
  let $btnNewTransaction;
  let $btnSave;
  let $inputAmount;
  let $inputRecipient;
  let $modalTransaction;
  let $selectTransactionType;
  let $parameters;
  let $notification;

  let bankAccountId;
  let bankAccountNumber;
  let url = "/api/v1/bank_accounts/new_transaction";

  const fetchElements = () => {
    $btnNewTransaction = $("#btn-new-transaction");
    $btnSave = $("#btn-save");
    $inputAmount = $("#input-amount");
    $inputRecipient = $("#input-recipient");
    $modalTransaction = $("#modal-transaction");
    $selectTransactionType = $("#select-transaction-type");
    $parameters = $("#parameters");
    $notification = $(".notification");

    bankAccountId = $parameters.data("bank-account-id");
    bankAccountNumber = $parameters.data("bank-account-number");
  };

  const disableControls = () => {
    $btnSave.prop("disabled", true);
    $inputAmount.prop("disabled", true);
    $selectTransactionType.prop("disabled", true);
    $inputRecipient.prop("disabled", true);
  };

  const enableControls = () => {
    $btnSave.prop("disabled", false);
    $inputAmount.prop("disabled", false);
    $selectTransactionType.prop("disabled", false);
    if ($selectTransactionType.val() === "transfer") {
      $inputRecipient.prop("disabled", false);
    } else {
      $inputRecipient.prop("disabled", true);
    }
  };

  const initializeEvents = () => {
    $inputRecipient.prop("disabled", true);
    $btnNewTransaction.on("click", () => $modalTransaction.modal("show"));
    $selectTransactionType.on("change", () => {
      if ($selectTransactionType.val() === "transfer") {
        $inputRecipient.prop("disabled", false);
      } else {
        $inputRecipient.val();
        $inputRecipient.prop("disabled", true);
      }
    });
    $btnSave.on("click", () => {
      let amount = $inputAmount.val();
      let transactionType = $selectTransactionType.val();
      if (transactionType === "transfer") {
        bankAccountNumber = $inputRecipient.val();
      }
      disableControls();
      console.log(
        `Amount: ${amount} Transaction Type: ${transactionType} Bank Account Id: ${bankAccountId} Bank Account Number: ${bankAccountNumber}`
      );

      $notification.html("");

      $.ajax({
        url: url,
        method: "POST",
        dataType: "json",
        data: {
          amount: amount,
          transaction_type: transactionType,
          bank_account_id: bankAccountId,
          recipient_id: bankAccountNumber
        },
        success: function(response) {
          window.location.href = "" + bankAccountId;
        },
        error: function(response) {
          $notification.html(JSON.parse(response.responseText).errors.join());
          enableControls();
        }
      });
    });
  };
  const init = () => {
    fetchElements();
    initializeEvents();
  };
  return {
    init: init
  };
})();
