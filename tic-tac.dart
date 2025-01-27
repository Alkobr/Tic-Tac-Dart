import 'dart:io';

class TicTacToe {
  List<List<String>> board;
  String currentPlayer;

  TicTacToe()
      : board = List.generate(3, (_) => List.generate(3, (_) => ' ')),
        currentPlayer = 'X';

  void displayBoard() {
    print('\n');
    for (int i = 0; i < 3; i++) {
      print(' ${board[i][0]} | ${board[i][1]} | ${board[i][2]} ');
      if (i < 2) print('---+---+---');
    }
    print('\n');
  }

  bool isValidMove(int row, int col) {
    return row >= 0 && row < 3 && col >= 0 && col < 3 && board[row][col] == ' ';
  }

  bool makeMove(int position) {
    int row = (position - 1) ~/ 3;
    int col = (position - 1) % 3;
    if (isValidMove(row, col)) {
      board[row][col] = currentPlayer;
      return true;
    }
    return false;
  }

  bool checkWin() {
    // Check rows and columns
    for (int i = 0; i < 3; i++) {
      if ((board[i][0] == currentPlayer &&
              board[i][1] == currentPlayer &&
              board[i][2] == currentPlayer) ||
          (board[0][i] == currentPlayer &&
              board[1][i] == currentPlayer &&
              board[2][i] == currentPlayer)) {
        return true;
      }
    }

    // Check diagonals
    if ((board[0][0] == currentPlayer &&
            board[1][1] == currentPlayer &&
            board[2][2] == currentPlayer) ||
        (board[0][2] == currentPlayer &&
            board[1][1] == currentPlayer &&
            board[2][0] == currentPlayer)) {
      return true;
    }

    return false;
  }

  bool isBoardFull() {
    for (var row in board) {
      if (row.contains(' ')) return false;
    }
    return true;
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  void playGame() {
    print("Welcome to Tic-Tac-Toe!\n");
    displayBoard();

    while (true) {
      print("Player $currentPlayer's turn. Enter your move (1-9):");
      int? move;
      try {
        move = int.parse(stdin.readLineSync()!);
      } catch (e) {
        print("Invalid input. Please enter a number between 1 and 9.");
        continue;
      }

      if (move < 1 || move > 9) {
        print("Invalid input. Please enter a number between 1 and 9.");
        continue;
      }

      if (!makeMove(move)) {
        print("Invalid move. The cell is already occupied. Try again.");
        continue;
      }

      displayBoard();

      if (checkWin()) {
        print("Player $currentPlayer wins!\n");
        break;
      }

      if (isBoardFull()) {
        print("It's a draw!\n");
        break;
      }

      switchPlayer();
    }

    print("Do you want to play again? (y/n):");
    String? response = stdin.readLineSync();
    if (response != null && response.toLowerCase() == 'y') {
      resetGame();
      playGame();
    } else {
      print("Thanks for playing Tic-Tac-Toe!");
    }
  }

  void resetGame() {
    board = List.generate(3, (_) => List.generate(3, (_) => ' '));
    currentPlayer = 'X';
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.playGame();
}
