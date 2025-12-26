Bilkul bhidu 😄🔥 — GitHub ke liye **proper professional README.md** ready kar diyaa hoon.
Bas isko `README.md` file me paste karke repo me push kar de 👍

---

# 📘 **README.md — three_tier_application**

````md
# 🚀 Three Tier Application on Azure using Terraform

This project demonstrates how to deploy a **3-Tier Architecture** on **Microsoft Azure** using **Terraform (Infrastructure as Code)**.

The architecture follows a classic separation of concerns:
- Frontend Layer (Public-facing VM)
- Backend Layer (Private VM)
- Database Layer (Azure SQL Server & Database)

All resources are provisioned automatically using Terraform.

---

## 🏗 Architecture Overview

- **Frontend VM**
  - Public IP for external access
  - Connected to frontend subnet

- **Backend VM**
  - No public IP (private only)
  - Communicates with frontend and database

- **Database Layer**
  - Azure SQL Server
  - Azure SQL Database

- **Networking**
  - Virtual Network (VNET)
  - Frontend, Backend, and DB Subnets
  - Network Interfaces (NICs)

- **Infrastructure as Code**
  - Terraform used to manage all Azure resources

---

## 📂 Project Structure

```bash
three_tier_application/
│
├── main.tf
├── provider.tf
├── variable.tf
├── terraform.tfstate
└── README.md
````

---

## ⚙ Prerequisites

* Azure Subscription
* Azure CLI installed (`az login`)
* Terraform installed
* Git installed

---

## 🚀 How to Deploy

```bash
# Login to Azure
az login

# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply configuration
terraform apply
```

---

## 🧹 Cleanup (Destroy resources)

```bash
terraform destroy
```

---

## 🧠 Key Learnings

* Infrastructure provisioning using Terraform
* Managing Terraform state & imports
* Understanding Azure networking components
* Handling real-world deployment errors
* Dependency management in Terraform

---

## 📌 Tech Stack

* Terraform
* Microsoft Azure
* Azure Virtual Machines
* Azure Virtual Network
* Azure SQL Database

---

## 🤝 Contributing

Contributions are welcome!
Feel free to fork this repository and submit pull requests.

---
