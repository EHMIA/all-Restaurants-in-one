# Akiel - Egyptian Restaurant Guide 🍽️

Akiel is a comprehensive web platform designed to help users discover and explore Egyptian restaurants, and allow users to add their restaurant to be exist on this website. Akie also provide a dashboard for Owner to manage their restaurant, dashboard for Admin to manage the whole website.
This repository contains the **Frontend** of the application, built with modern web technologies to ensure a smooth and responsive user experience.

---

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### 📋 Prerequisites

Before you begin, ensure you have the following installed:
* **Node.js** (v18.0.0 or higher recommended)
* **npm** (comes with Node) or **yarn**
* **Git**

---

### 🛠️ Installation & Setup

**1. Clone the Repository:**
First, clone the specific branch of the project:
```bash
git clone -b frontend https://github.com/EHMIA/all-Restaurants-in-one.git
```

**2. Navigate to the Frontend Directory:**
```bash
cd all-Restaurants-in-one/
```

**3. Install Dependencies:**
```bash
npm install
```

### 🏃‍♂️ Running the Application
To start the development server:
```bash
npm run dev
```

Once the server starts, open your browser and navigate to:
http://localhost:5173 (or the port specified in your terminal).

### 💻 Tech Stack

#### 🔹 Core & Build Tools
* **React 19** - A modern JavaScript library for building interactive user interfaces.
* **TypeScript** - Ensures type safety, reduces runtime errors, and improves code maintainability.
* **Vite 8** - A next-generation, ultra-fast frontend build tool providing Hot Module Replacement (HMR).

#### 🔄 State Management & Data Fetching
* **TanStack React Query (v5)** - Powerful asynchronous state management for fetching, caching, and synchronizing server state.
* **Zustand** - A lightweight, fast, and scalable barebones state-management solution for global client state.
* **Axios** - Promise-based HTTP client for making clean and optimized API requests.

#### 🛣️ Routing & Security
* **React Router (v7)** - Declarative, client-side routing for seamless navigation in Single Page Applications (SPAs).
* **JWT Decode** - Used to decode JSON Web Tokens to handle user authentication and session management.

#### 📝 Forms & Validation
* **React Hook Form** - Performance-focused, flexible, and extensible forms validation framework.
* **Zod** - TypeScript-first schema-declaration and validation library with static type inference, integrated via `@hookform/resolvers`.

#### 🎨 Styling & UI/UX
* **Tailwind CSS (v4)** - A utility-first CSS framework for rapid and high-performance UI development.
* **Framer Motion** - A production-ready motion library for creating smooth, interactive, and advanced animations.
* **React Icons** - A comprehensive library providing popular icons from various icon packs.
* **React Hot Toast** - Lightweight, customizable, and responsive toast notifications.

#### ⚙️ Optimization & Code Quality
* **ESLint** - Pluggable linting utility to maintain consistent code quality and enforce best practices.
* **Use-Debounce** - A lightweight hook used to optimize performance (e.g., search inputs) by delaying API requests.
