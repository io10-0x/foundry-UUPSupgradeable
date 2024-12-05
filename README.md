# Foundry UUPS Upgradeable: README

## Overview

This repository contains the implementation of a Universal Upgradeable Proxy Standard (UUPS) upgradeable contract system using Foundry. It demonstrates key concepts like upgradeability, storage slots, initializer functions, and testing with Foundry. The project uses OpenZeppelin's UUPS contracts for a secure and modular implementation.

## Features

- **UUPS Proxy Architecture:** Implements a proxy contract for upgradeable smart contracts.
- **Initializer Functions:** Replaces constructors to initialize state variables in implementation contracts.
- **Storage Slot Management:** Avoids storage conflicts during upgrades using storage gaps.
- **Abstract Contracts:** Leverages abstract contracts for secure upgrade functionality.
- **Testing:** Comprehensive testing scripts to ensure correctness and compatibility during upgrades.

---

## Contracts

### 1. `BoxV1.sol`

The first implementation contract used with the UUPS proxy, featuring basic functionality and initializer setup.

#### Key Points

- **Inherits From:**
  - `UUPSUpgradeable` (OpenZeppelin)
  - `OwnableUpgradeable` (OpenZeppelin)
- **Initializer Function:** Configures the contract instead of using a constructor.
- **Upgrade Authorization:** Implements `_authorizeUpgrade` with `onlyOwner` to restrict upgrades.
- **Functions:**
  - `setNumber(uint256 _number)`: Sets a state variable.
  - `getNumber()`: Retrieves the state variable.
  - `version()`: Returns the contract version (1).

---

### 2. `BoxV2.sol`

The upgraded implementation with additional functionality.

#### Key Points

- **Inherits From:**
  - `UUPSUpgradeable` (OpenZeppelin)
  - `OwnableUpgradeable` (OpenZeppelin)
- **Reinitializer Function:** Updates the version number in the proxy storage.
- **Additional Functions:**
  - `version()`: Returns the updated contract version (2).

---

### 3. `ERC1967Proxy`

The OpenZeppelin proxy contract used for deploying and linking the implementation contracts.

#### Key Points

- **Constructor:**
  - Takes the address of the implementation contract.
  - Encodes the initializer function's call data for the proxy.
- **Delegatecall:** Ensures state changes occur in the proxy's storage.

---

## Testing

### Unit Testing

- Ensures that:
  - The `initialize` function works correctly.
  - Functions in `BoxV1` and `BoxV2` operate as expected.
  - Storage remains consistent during upgrades.

### Integration Testing

- Verifies that:
  - The proxy delegates calls to the correct implementation.
  - The upgrade process is seamless and secure.

---

## Deployment and Upgrade

### Deployment

1. Deploy the `BoxV1` contract.
2. Deploy the `ERC1967Proxy` with the `BoxV1` address and initializer call data.

### Upgrade

1. Deploy the `BoxV2` contract.
2. Use the `upgradeToAndCall` function from the proxy to point to the new implementation.

## Known Issues and Enhancements

- **Storage Conflicts:** Rapid collateral price drops can lead to temporary undercollateralisation.
- **Security Risks:** Improperly implemented \_authorizeUpgrade can lead to unauthorized upgrades.
- **Future Improvement:** Add automated tools to detect storage slot conflicts.

---

## Usage

1. Clone the repository and initialise a Foundry project:

   ```bash
   git clone <repository-url>
   cd foundry-UUPSupgradeable

   ```

2. ## Compile Contracts

   ```bash
   forge build

   ```

3. ## Run Tests

   ```bash
   forge test

   ```

4. ## Deploy Contracts
   Use the provided deployment scripts for BoxV1 and ERC1967Proxy.

## Tools and Libraries

- **Foundry:** For smart contract development and testing.
- **OpenZeppelin Contracts:** Prebuilt ERC20 and security modules.
- **ERC1967Proxy:** For price data integration.
- **Forge-Std:** Testing utilities.

## License

- **This project is licensed under the MIT License.**
