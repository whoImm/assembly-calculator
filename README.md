# 🧮 Assembly Calculator 🧮

This project is a simple 16-bit calculator program written in assembly language, designed to run in a DOS environment. It allows users to perform basic arithmetic operations (addition, subtraction, multiplication, and division) on two integer inputs. The program takes user input, performs the selected calculation, and displays the result or appropriate error messages. It provides a text-based user interface for easy interaction.

## 🚀 Key Features

- **Basic Arithmetic Operations:** Supports addition, subtraction, multiplication, and division.
- **User Input:** Reads two integer numbers and an operator from the user via the console.
- **Error Handling:** Detects and handles errors such as division by zero, invalid operator input, and potential overflow during calculations.
- **Text-Based Interface:** Presents a simple, easy-to-use menu for selecting operations.
- **Looping:** Allows the user to perform multiple calculations without restarting the program.
- **Input Validation:** Converts ASCII input to numerical values and performs basic error checking.
- **DOS Compatibility:** Designed to run in a DOS environment, utilizing DOS interrupts for input and output.

## 🛠️ Tech Stack

- **Language:** Assembly Language (x86)
- **Environment:** DOS
- **Interrupts:** DOS Interrupts (INT 21h)

### Installation

1. **Install MASM/TASM Extension for VS Code:**
   ```bash
   - Open VS Code
   - Press Ctrl+Shift+X to open Extensions
   - Search for "MASM/TASM"
   - Install the extension by "vscode-masm"
   ```

2. **Create a Working Directory:**
   ```bash
   mkdir assembly-projects
   cd assembly-projects
   ```

The extension provides syntax highlighting and integrated assembly/execution capabilities. You can now write, assemble, and run x86 assembly programs directly from VS Code.
**Note:** The extension automatically handles DOSBox configuration, eliminating the need for manual setup.

## 💻 Usage

![MASM/TASM Extension Demo](https://storage.imgbly.com/imgbly/PIyz0OaixX.gif)

1.  Run ASM code
2.  The program will display a menu with available operations:
    - a. Addition
    - b. Subtraction
    - c. Multiplication
    - d. Division
3.  Enter the operator (a, b, c, or d) corresponding to the desired operation.
4.  Enter the two numbers when prompted.
5.  The program will display the result or an error message if an error occurs (e.g., division by zero).
6.  Press any key to continue and perform another calculation, or exit the program.

## 📝 License

This project is open-source and available under the [MIT License](LICENSE) (add a LICENSE file if applicable).
