# Crowdfunding Smart Contract

## Overview
This smart contract is a crowdfunding system that allows users to create campaigns, pledge funds, withdraw pledges if goals are not met, and claim funds if the goal is reached. The contract ensures security through defined error codes and access control mechanisms.

## Features
- **Campaign Creation**: Users can create campaigns with a specified funding goal and deadline.
- **Pledging Funds**: Contributors can pledge funds to active campaigns.
- **Withdraw Pledge**: If the campaign deadline has passed and the goal was not met, contributors can withdraw their pledge.
- **Claim Funds**: If the campaign goal is met, the campaign owner can claim the funds.

## Data Structures
- **campaigns** (Map): Stores campaign details including owner, goal, deadline, pledged amount, and claim status.
- **pledges** (Map): Tracks pledges made by contributors to specific campaigns.

## Error Codes
- `ERR_CAMPAIGN_NOT_FOUND (1001)`: Campaign does not exist.
- `ERR_CAMPAIGN_ENDED (1002)`: Campaign deadline has passed.
- `ERR_GOAL_REACHED (1003)`: Campaign has already met its goal.
- `ERR_INVALID_AMOUNT (1004)`: Pledge or goal amount is invalid.
- `ERR_UNAUTHORIZED (1005)`: Unauthorized action.
- `ERR_FUNDS_ALREADY_CLAIMED (1006)`: Campaign funds have already been claimed.
- `ERR_GOAL_NOT_MET (1007)`: Campaign did not meet its goal.
- `ERR_WITHDRAWAL_NOT_ALLOWED (1008)`: Withdrawal is not allowed.

## Functions
### 1. Create Campaign
```lisp
(define-public (create-campaign (goal uint) (deadline uint))
```
- Creates a new campaign.
- Requires a valid goal amount and a deadline in the future.
- Returns the newly created campaign ID.

### 2. Pledge Funds
```lisp
(define-public (pledge (id uint) (amount uint))
```
- Allows users to pledge funds to an active campaign.
- Ensures the campaign is still active and has not yet met its goal.

### 3. Withdraw Pledge
```lisp
(define-public (withdraw-pledge (id uint))
```
- Allows users to withdraw their pledge if the campaign failed to meet its goal.
- Ensures the campaign has ended and the goal was not met.

### 4. Claim Funds
```lisp
(define-public (claim-funds (id uint))
```
- Enables the campaign owner to claim funds if the goal is met.
- Ensures the funds have not been claimed already and the caller is the campaign owner.

## Helper Functions
- `get-current-block-height`: Retrieves the current block height.
- `campaign-exists?`: Checks if a campaign exists.
- `is-campaign-active?`: Determines if a campaign is still running.
- `is-goal-met?`: Checks if a campaign has reached its funding goal.

## Security Considerations
- Only the campaign owner can claim funds.
- Pledges can only be withdrawn if the goal was not met.
- Pledges must be greater than zero.
- Campaign deadlines must be in the future at creation.

## License
This contract is open-source and can be modified for use in crowdfunding projects.

