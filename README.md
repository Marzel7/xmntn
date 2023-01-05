#Vulnerability Analysis#

88mph’s functionality allows users to deposit their assets into the DInterest contract, which mints the user an ERC721 token that contains information about the deposit amount and maturity of the deposit. It also makes an external call to the MPHMinter contract to forward the call to the vesting03 contract, which mints another ERC721 token. This second token contains information regarding vesting status, and vesting03 further allows users to claim their reward in the form of 88mph tokens.

The vulnerability existed in the vesting03 contract in the createVestForDeposit() function. This function is responsible for storing initial information regarding user deposit and minting the vestID.

However, this function didn’t update the vestRewardPerTokenPaid[vestID] with the current rewardPerToken, which should actually be very low after an immediate deposit because not enough time has passed for the user to earn their full token reward. So, the \_earned() function in the withdraw() function will calculate as though the user were eligible for the full rewardPerToken from the amount that they deposited.

A flashloan is the most natural way to exploit this vulnerability.

Here are the steps to reproduce the attack:

Flashloan WETH from Uniswap or AAVE.
Call deposit() to the DInterest contract to deposit WETH.
Call withdraw() to the vesting03 contract by supplying the vestID obtained from depositing WETH.
Call withdraw() to DInterest contract by supplying true as an argument, in order to withdraw the initial deposit before the maturity ends.
Swap 88mph tokens obtained from step 3 to Balancer or Uniswap.
Pay back the initial flashloan and fee.

# 88mph

> 88mph Offers two non-custodial on-chain products

- A fixed-term fixed-rate yield product acting as an intermediary between you and third-party variable yield rate lending protocols to offer the best fixed yield rate on your capital, with a custom maturity up to 1 year.
- A yield speculation instrument, called Yield Tokens (YTs), allowing users to speculate on the variable yield rate of third-party protocols such as Compound or Aave.

By using the fixed rate pools, users receive MPH tokens that can be used to obtain veMPH tokens to earn protocol revenues and exercise voting rights.

## Table of Contents

- [Vulnerability Analysis](#analysis)
- [Technologies Used](#technologies-used)
- [Features](#features)
- [Screenshots](#screenshots)
- [Setup](#setup)
- [Usage](#usage)
- [Project Status](#project-status)

- [Contact](#contact)
<!-- * [License](#license) -->

## Vulnerability Analysis

- 88mph’s functionality allows users to deposit their assets into the DInterest contract, which mints the user an ERC721 token that contains information about the deposit amount and maturity of the deposit. It also makes an external call to the MPHMinter contract to forward the call to the vesting03 contract, which mints another ERC721 token. This second token contains information regarding vesting status, and vesting03 further allows users to claim their reward in the form of 88mph tokens.

The vulnerability existed in the vesting03 contract in the createVestForDeposit() function. This function is responsible for storing initial information regarding user deposit and minting the vestID.

However, this function didn’t update the vestRewardPerTokenPaid[vestID] with the current rewardPerToken, which should actually be very low after an immediate deposit because not enough time has passed for the user to earn their full token reward. So, the \_earned() function in the withdraw() function will calculate as though the user were eligible for the full rewardPerToken from the amount that they deposited.

A flashloan is the most natural way to exploit this vulnerability.

<!-- You don't have to answer all the questions - just the ones relevant to your project. -->

## Technologies Used

- Foundry

## Features

List the ready features here:

- Awesome feature 1
- Awesome feature 2
- Awesome feature 3

## Screenshots

![Example screenshot](./img/screenshot.png)

<!-- If you have screenshots you'd like to share, include them here. -->

## Setup

What are the project requirements/dependencies? Where are they listed? A requirements.txt or a Pipfile.lock file perhaps? Where is it located?

Proceed to describe how to install / setup one's local environment / get started with the project.

## Usage

How does one go about using it?
Provide various use cases and code examples here.

`write-your-code-here`

## Project Status

Project is: _in progress_ / _complete_ / _no longer being worked on_. If you are no longer working on it, provide reasons why.

## Contact

Created by [@flynerdpl](https://www.flynerd.pl/) - feel free to contact me!

<!-- Optional -->
<!-- ## License -->
<!-- This project is open source and available under the [... License](). -->

<!-- You don't have to include all sections - just the one's relevant to your project -->
