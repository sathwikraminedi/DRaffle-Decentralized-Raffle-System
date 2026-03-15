# 🎟️ DRaffle – Decentralized Raffle System

DRaffle is a **decentralized raffle platform built on the Aptos blockchain** that enables users to participate in transparent and trustless raffles using cryptocurrency.

Traditional raffle and lottery systems are centralized, meaning participants must trust an organizer to handle ticket purchases, select winners fairly, and distribute prizes honestly. **DRaffle removes this trust requirement by using smart contracts to automate the entire process.**

---

## 🚀 Problem

Traditional raffle systems suffer from several issues:

* ❌ Lack of transparency
* ❌ Possibility of manipulation by organizers
* ❌ Delayed or unfair prize distribution
* ❌ No verifiable randomness

Participants have no way to verify whether the raffle was conducted fairly.

---

## 💡 Solution

DRaffle solves these issues by using **blockchain smart contracts**.

Key features include:

* 🔐 **Trustless raffle system**
* ⛓️ **All transactions recorded on blockchain**
* 🎲 **Automated winner selection**
* 💰 **Instant prize distribution**
* 👛 **Wallet-based participation**

Everything is handled by the smart contract, ensuring fairness and transparency.

---

## ⚙️ How It Works

1. Users connect their wallet.
2. Participants buy raffle tickets using **APT tokens**.
3. The smart contract records all participants.
4. When the raffle ends, a **winner is selected automatically**.
5. The prize pool is transferred directly to the winner.

---

## 🏗️ Architecture

User Wallet
⬇
Frontend (React + Vite + TailwindCSS)
⬇
Web3 Interaction Layer
⬇
Move Smart Contract
⬇
Aptos Blockchain

---

## 🛠️ Tech Stack

**Blockchain**

* Aptos
* Move Smart Contracts

**Frontend**

* React
* TypeScript
* Vite
* TailwindCSS

**Web3 Integration**

* Aptos Wallet Adapter

---

## 📂 Project Structure

```
DRaffle
│
├── client/                # Frontend application
│   ├── src/
│   │   ├── App.tsx
│   │   ├── main.tsx
│   │   └── components/
│
├── contract/              # Move smart contract
│   ├── Move.toml
│   └── sources/
│       └── draffle2.move
│
└── README.md
```

---

## 🚀 Getting Started

### 1️⃣ Clone the Repository

```
git clone https://github.com/sathwikraminedi/DRaffle.git
cd DRaffle
```

### 2️⃣ Install Frontend Dependencies

```
cd client
npm install
```

### 3️⃣ Run the Frontend

```
npm run dev
```

### 4️⃣ Deploy Smart Contract

```
cd contract
aptos move compile
aptos move publish
```

---

## 🎯 Future Improvements

* 🎲 Verifiable randomness using **Chainlink VRF**
* 🖼️ NFT-based raffle tickets
* ⏳ Automated raffle countdown timer
* 📊 Dashboard with raffle analytics
* 🗳️ DAO governance for raffle parameters

---

## 👨‍💻 Team

Built during a **Web3 Hackathon** to demonstrate how decentralized applications can bring transparency and fairness to digital lotteries.

---

## 📜 License

MIT License

---

⭐ If you like this project, consider giving it a star!



