// Crowdfunding Smartcontract

// Importing modules
module crowd_fund::fund_contract {
    use std::signer;
    use std::coin::{transfer, Coin};
    use std::account;
    use std::string;

    // Good practise: Define errors in the beginning of code for maintenance and readability
    const ENotFundOwner: u64 = 0;

}