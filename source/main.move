// Crowdfunding Smartcontract

// Importing modules
module crowd_fund::fund_contract {
    use std::signer;
    use std::coin::{transfer, Coin};
    use std::account;
    use std::string;

    // Good practise: Define errors in the beginning of code for maintenance and readability
    const ENotFundOwner: u64 = 0;

    // Defining objects
    // Fund object
    struct Fund has key {
        owner: address,
        target: u64, // in generic currency unit
        raised: u64, // in generic currency unit
    }

    // Receipt object
    struct Receipt has key {
        owner: address,
        amount_donated: u64,
    }

    // FundOwnerCap object
    // Allows fund creator to withdraw funds from the specific crowdfunding campaign
    struct FundOwnerCap has key {
        owner: address,
        fund_id: address,
    }

    // Functions
    // Function to create fund
    public fun create_fund(account: &signer, target: u64) {
        let owner = signer::address_of(account);
        let fund = Fund {
            owner,
            target,
            raised: 0,
        };

        // Save the Fund object under the owner's address
        move_to(account, fund);

        // Create and move a FundOwnerCap to the owner
        let cap = FundOwnerCap {
            owner,
            fund_id: owner,
        };
        move_to(account, cap);
    }

}