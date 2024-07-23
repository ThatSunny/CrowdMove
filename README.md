# CrowdMove: A Crowdfunding Smartcontract

**CrowdMove** is designed to facilitate decentralized fundraising campaigns on a blockchain platform using the Move language.<br/>This contract enables fund creators to establish funding goals, accept donations, and manage withdrawals efficiently. It leverages Move’s resource-oriented programming paradigm to ensure secure and predictable behavior. Additionally, the contract is designed to be flexible, allowing users to customize various aspects according to their specific needs and requirements.

## Key Features
1. **Fund Creation:**
    - The contract allows user to create a crowdfunding campaign by specifying a target funding goal in a generic currency.
    - Upon creation, a Fund object is instantiated, recording owner's address, target amount, and the initial raised balance (set 0).
    - A FundOwnerCap object is also created, granting the creator the authority to withdraw funds once the campaign is complete.

2. **Donations:**
    - Users can donate to a campaign by transferring a specified amount of a generic Coin type to the Fund object.
    - Each donation increments the raised amount within the Fund.
    - A Receipt object is issued to the donor, detailing the donation amount for record-keeping purposes.

3. **Fund Withdrawal:**
    - The fund creator can withdraw the raised funds once the campaign is completed.
    - The function verifies that the requester holds the corresponding FundOwnerCap, ensuring only the rightful owner can access the funds.
    - The contract resets the raised amount post-withdrawal, preventing multiple withdrawals without additional fundraising.

4. **Target Tracking:**
    - The contract monitors the total funds raised, comparing it against the specified target.
    - When the fundraising target is reached or exceeded, a string is triggered, notifying that the goal has been reached.


## Contract Overview

The contract includes the following main functions:
1. `create_fund`: Initializes a new crowdfunding campaign by setting a target funding goal, creating a Fund object linked to the creator's address, and generating a FundOwnerCap to authorize withdrawals.

2. `donate`: Allows users to contribute to a specific fund by transferring currency, increasing the fund's raised balance, and issuing a Receipt to the donor for record-keeping.

3. `withdraw_funds`: Enables the fund creator to withdraw accumulated funds once the campaign target is reached, requiring the FundOwnerCap to ensure only authorized withdrawals.


## Functions

### 1. `create_fund`

```move
public fun create_fund(account: &signer, target: u64)
```

- **`account`**: The signer account creating the fund.
- **`target`**: The target funding goal in a generic currency unit.

This function initializes a new crowdfunding campaign by setting the target funding goal, creating a `Fund` object associated with the creator's address, and generating a `FundOwnerCap` for authorization. The `Fund` object and `FundOwnerCap` are saved under the creator's address.


### 2. `donate`

```move
public fun donate<CoinType>(account: &signer, fund: &mut Fund, amount: u64) acquires Fund
```

- **`account`**: The signer account making the donation.
- **`fund`**: The mutable reference to the `Fund` object receiving the donation.
- **`amount`**: The amount of currency to be donated.

This function allows users to contribute to a specific fund by transferring the specified amount of currency from the donor to the fund. It updates the fund’s raised balance, creates a `Receipt` for the donor, and checks if the fundraising target has been reached, logging a message if the target is met.


### 3. `withdraw_funds`

```move
public fun withdraw_funds(account: &signer, fund: &mut Fund) acquires Fund, FundOwnerCap
```

- **`account`**: The signer account requesting the withdrawal.
- **`fund`**: The mutable reference to the `Fund` object from which funds will be withdrawn.
- **`amount`**: The amount of currency to be donated.

This function enables the fund creator to withdraw accumulated funds once the target is reached. It requires the account to possess a `FundOwnerCap` and verifies ownership before transferring the raised amount back to the creator. The fund’s raised amount is reset post-withdrawal.



## Usage & Prerequisites

### Prerequisites

- **Move Language Toolchain**: Ensure you have the Move language toolchain installed, including the **Move compiler** and other necessary tools for development and testing.
- **Blockchain CLI**: Depending on the blockchain you choose (e.g., _Sui, Aptos_), ensure you have the appropriate CLI tools installed for deployment and interaction.

### Deployment

1. Clone the repository:
    ```sh
    git clone https://github.com/ThatSunny/crowdmove.git
    cd crowdmove
    ```

2. Compile the contract:
    ```sh
    aptos move compile --save-metadata
    ```

3. Publish the contract to the blockchain:
  - If you are using **Aptos**: 
      ```sh
      aptos move publish --private-key <path-to-private-key> --url <aptos-node-url>
      ```
  - If you are using **SUI**: 
      ```sh
      sui move publish --private-key <path-to-private-key> --url <sui-node-url>
      ```

## Interaction with CrowdMove

1. **Create Fund**:
    ```sh
    aptos move run --function-id 'crowd_fund::fund_contract::create_fund' --args <target-amount>
    ```

2. **Donate**:
    ```sh
    aptos move run --function-id 'crowd_fund::fund_contract::donate' --args <fund-id> <donation-amount>
    ```

3. **Withdraw Funds**:
    ```sh
    aptos move run --function-id 'crowd_fund::fund_contract::withdraw_funds'
    ```

## Advantages
1. **Decentralized Control**: Removes intermediaries, allowing direct interaction between fundraisers and contributors.
2. **Transparency**: Maintains a public record of donations and withdrawals, ensuring trust and accountability.
3. **Security**: Leverages Move’s safety features to prevent unauthorized access and mitigate risks associated with smart contract execution.
4. **Flexibility**: Offers the ability to make custom adjustments, giving users control over contract features to better align with their project goals.

## Summary
This crowdfunding smart contract provides a comprehensive and foundational framework for decentralized fundraising efforts, enabling creators to set up and manage campaigns with greater control and transparency. By leveraging blockchain technology, the contract empowers project creators to achieve their financial goals by clearly defining target amounts, tracking contributions, and facilitating withdrawals. Donors benefit from a transparent and secure method of participation, with each transaction recorded immutably on the blockchain. This structure not only ensures that funds are managed responsibly but also fosters trust and accountability throughout the fundraising process. The contract’s flexibility allows for customization to fit various project needs, making it a versatile tool for a wide range of crowdfunding initiatives.

---
