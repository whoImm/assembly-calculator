![Banner](https://i.hizliresim.com/3zhwn12.png)

# 🧮 Assembly Calculator

---

## 🚀 Overview

**Assembly Calculator** is a 16-bit arithmetic calculator written in x86 Assembly language for the DOS environment.  
It allows users to perform basic arithmetic operations (addition, subtraction, multiplication, division) using a simple text-based interface.  
Error handling and input validation are built-in to ensure reliability and user-friendliness.

| | |
| - | - |
| **⚙️ Core Functions** | **🧰 System Design** |
| <table><tr><td>Addition / Subtraction</td><td>Performs signed integer arithmetic</td></tr><tr><td>Multiplication / Division</td><td>Handles integer math with overflow detection</td></tr><tr><td>Input Validation</td><td>ASCII to numeric conversion with range check</td></tr><tr><td>Error Handling</td><td>Detects division by zero and invalid operators</td></tr></table> | <table><tr><td>Platform</td><td>DOS environment (x86 real mode)</td></tr><tr><td>Interrupts</td><td>Uses DOS INT 21h for I/O operations</td></tr><tr><td>Loop System</td><td>Performs repeated calculations without restart</td></tr><tr><td>Interface</td><td>Simple text-based UI</td></tr></table> |

---

## ⚡ Features

| | | |
| - | - | - |
| **🔢 Arithmetic Operations** | **🧠 Logic Handling** | **💬 Interface & Interaction** |
| <table><tr><td>Addition</td><td>Signed 16-bit integer addition</td></tr><tr><td>Subtraction</td><td>Handles negative and positive results</td></tr><tr><td>Multiplication</td><td>Integer multiplication using MUL</td></tr><tr><td>Division</td><td>Division with zero check</td></tr></table> | <table><tr><td>Overflow Detection</td><td>Checks results exceeding 16-bit limit</td></tr><tr><td>Invalid Input Handling</td><td>Prompts for re-entry when input is invalid</td></tr><tr><td>Error Messages</td><td>Displays clear messages for all error types</td></tr></table> | <table><tr><td>Menu System</td><td>Selectable operations via keyboard</td></tr><tr><td>Loop Control</td><td>Repeat calculations or exit gracefully</td></tr><tr><td>User Prompts</td><td>Guided step-by-step interaction</td></tr></table> |

---

## 🛠️ Tech Stack

| Component | Description |
|------------|-------------|
| 💾 **Language** | x86 Assembly Language |
| 🧮 **Environment** | DOS (Real Mode) |
| 🔧 **Assembler** | MASM or TASM |
| 🧱 **Interrupts** | DOS INT 21h for I/O |
| 🖥️ **Interface** | Text-based console input/output |

---

## 🧩 Installation

### 1️⃣ Install MASM/TASM Extension for VS Code
```bash
- Open VS Code
- Press Ctrl+Shift+X to open Extensions
- Search for "MASM/TASM"
- Install the extension by "vscode-masm"
```

### 2️⃣ Create a Working Directory
```bash
mkdir assembly-projects
cd assembly-projects
```

The extension provides syntax highlighting and integrated assembly/execution capabilities.  
You can now write, assemble, and run x86 assembly programs directly from VS Code.

> 💡 **Note:** The extension automatically handles DOSBox configuration, eliminating the need for manual setup.

---

## 💻 Usage

![Demo](https://github.com/whoImm/assembly-calculator/blob/main/demo.gif?raw=true)

1. Run the compiled `.asm` code.  
2. The program will display a menu with available operations:  
   - a. Addition  
   - b. Subtraction  
   - c. Multiplication  
   - d. Division  
3. Enter the operator (a, b, c, or d) corresponding to the desired operation.  
4. Enter the two numbers when prompted.  
5. The program will display the result or an error message if an error occurs (e.g., division by zero).  
6. Press any key to continue and perform another calculation, or exit the program.

---

## 📝 License

This project is open-source and available under the [MIT License](LICENSE)
