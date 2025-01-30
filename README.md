# NFT Gallery Marketplace

## Overview
NFT Gallery Marketplace is a decentralized application that enables users to mint, list, buy, and transfer NFTs in a secure and efficient manner. The contract includes input validation and error handling to ensure smooth interactions within the marketplace.

## Features
- **Minting NFTs**: Users can create unique NFTs with metadata such as name, description, and properties.
- **Listing NFTs**: NFT owners can list their tokens for sale at a specified price.
- **Buying NFTs**: Buyers can purchase listed NFTs by transferring the required amount.
- **Cancelling Listings**: Sellers can cancel their NFT listings at any time.
- **Transferring NFTs**: Owners can transfer NFTs to other users.
- **Querying NFTs**: Read-only functions allow users to fetch token ownership, metadata, and listing information.

## Smart Contract Functions

### Public Functions
- `mint(metadata-uri, name, description, properties) -> (ok token-id | err code)`  
  Creates a new NFT and stores its metadata.
- `list-token(token-id, price) -> (ok true | err code)`  
  Lists an NFT for sale at the specified price.
- `cancel-listing(token-id) -> (ok true | err code)`  
  Cancels an active NFT listing.
- `buy-token(token-id) -> (ok true | err code)`  
  Allows a buyer to purchase a listed NFT.
- `transfer-token(token-id, recipient) -> (ok true | err code)`  
  Transfers an NFT to another user.

### Read-Only Functions
- `get-token-owner(token-id) -> principal | err`  
  Returns the owner of an NFT.
- `get-listing(token-id) -> listing-data | none`  
  Retrieves the details of a listed NFT.
- `get-token-metadata(token-id) -> metadata | none`  
  Returns the metadata of an NFT.

## Error Handling
The contract defines several error codes for input validation and access control:
- `ERR-NOT-AUTHORIZED (u100)`: Unauthorized access attempt.
- `ERR-NFT-EXISTS (u101)`: Token already exists.
- `ERR-INVALID-PRICE (u102)`: Invalid price input.
- `ERR-NOT-OWNER (u103)`: Action attempted by a non-owner.
- `ERR-NOT-LISTED (u104)`: Token is not listed for sale.
- `ERR-INSUFFICIENT-FUNDS (u105)`: Buyer has insufficient funds.
- `ERR-INVALID-URI (u106)`: Invalid metadata URI.
- `ERR-INVALID-NAME (u107)`: Invalid token name.
- `ERR-INVALID-DESCRIPTION (u108)`: Invalid token description.
- `ERR-INVALID-PROPERTIES (u109)`: Invalid token properties.
- `ERR-INVALID-TOKEN-ID (u110)`: Token ID does not exist.
- `ERR-INVALID-RECIPIENT (u111)`: Transfer recipient is invalid.

## Crowdfunding Smart Contract

## Overview
This smart contract enables users to create crowdfunding campaigns, pledge funds, withdraw pledges, and claim funds upon reaching the campaign goal. It includes robust error handling and validation mechanisms.

## Features
- **Create Campaigns**: Users can set up campaigns with a funding goal and deadline.
- **Pledge Funds**: Contributors can pledge funds to active campaigns.
- **Withdraw Pledges**: If a campaign fails to meet its goal, contributors can withdraw their funds.
- **Claim Funds**: Campaign owners can claim funds if the goal is met.
- **Query Campaigns**: Users can check campaign status, contributions, and funding details.

## Smart Contract Functions

### Public Functions
- `create-campaign(goal, deadline) -> (ok campaign-id | err code)`  
  Creates a new crowdfunding campaign.
- `pledge(id, amount) -> (ok true | err code)`  
  Allows users to pledge funds to a campaign.
- `withdraw-pledge(id) -> (ok true | err code)`  
  Enables contributors to withdraw their pledges if the goal is not met.
- `claim-funds(id) -> (ok true | err code)`  
  Allows campaign owners to claim funds if the goal is reached.

### Error Handling
The contract includes the following error codes:
- `ERR-CAMPAIGN-NOT-FOUND (u1001)`: Campaign does not exist.
- `ERR-CAMPAIGN-ENDED (u1002)`: Campaign has ended.
- `ERR-GOAL-REACHED (u1003)`: Campaign goal already reached.
- `ERR-INVALID-AMOUNT (u1004)`: Invalid pledge amount.
- `ERR-UNAUTHORIZED (u1005)`: Unauthorized action.
- `ERR-FUNDS-ALREADY-CLAIMED (u1006)`: Funds already claimed by owner.
- `ERR-GOAL-NOT-MET (u1007)`: Campaign goal not met.
- `ERR-WITHDRAWAL-NOT-ALLOWED (u1008)`: Withdrawal not allowed.

## Installation & Deployment
1. Deploy the smart contract using Clarity on the Stacks blockchain.
2. Ensure all required permissions are granted for users to interact with the contract.

## Contribution
Contributions are welcome! Please submit a pull request with detailed changes.

## License
This project is open-source and available under the MIT License.

